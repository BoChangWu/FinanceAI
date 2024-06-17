import os
import json
import time
import talib
import traceback
import requests
import numpy as np
import pandas as pd
import yfinance as yf
import pandas_datareader.data as web
from datetime import datetime,timedelta
from is_open import is_open
from deal_holiday import deal_holiday
from environment import *
from tradingbot import *
from backtester import *
# 不需要的欄位
drop_col = ['外陸資買進股數(不含外資自營商)','外陸資賣出股數(不含外資自營商)','外資自營商買進股數','外資自營商賣出股數',
            '投信買進股數','投信賣出股數','自營商買進股數(自行買賣)','自營商賣出股數(自行買賣)','自營商買進股數(避險)',
            '自營商買賣超股數(自行買賣)', '自營商買賣超股數(避險)','自營商賣出股數(避險)']
col = ['symbol','name','foreign_invest','foreign_proprietor','invest_trust','proprietor','total']
# Open setting.json for setting values
f = open('setting.json')
setting = json.load(f)
listurl = setting['Base']['stocklist_url']
conurl = setting['Base']['consitution_url']
tmcurl = setting['Base']["threeMajor_url"]

year = setting['Base']['last_year']
features = setting['Base']['features_fix']
holding = setting['Base']['holding']
ptc = setting['Base']['ptc']
ftc = setting['Base']['ftc']
verbose = setting['Base']['verbose']
def get_major():
    '''
    今日主力買賣超
    '''
    r_date = datetime.strftime(datetime.now(),'%Y%m%d')
    
    try:
        res = requests.get(f'https://www.twse.com.tw/rwd/zh/fund/T86?response=json&date={r_date}&selectType=ALLBUT0999&_=1685065571229')
        
        if res.status_code != 200:
            print(f'HTTP Error for {r_date}')
            return
    except:
        print(f'Cannot get {r_date} data..')
        return

    results = res.json()
    
    if 'data' in results.keys() and 'fields' in results.keys():
        
        df = pd.DataFrame(results['data'],columns=results['fields'])
        df.drop(columns=drop_col,inplace=True)
        df.columns = col
        df.to_csv(f'./data/TMC/tmc_{r_date}.csv')
        print(r_date,'tmc done.')
    else:
        print('No three major data today yet.')

    return r_date


class Finance:

    def __init__(self,total_amount,lags=3,window=20,leverage=1,p1=0,p2=0.6,p3=0.2,p_test=0.2,episodes=61,limit=5):
        self.now = datetime.now()
        # 已在操作的股票
        self.holding  = holding
        self.tmc = None
        self.stocks = dict()
        self.get_major()
        self._update_time()
        self.init_amount = total_amount
        self.total_amount = total_amount
        self.backtest_amount = total_amount
        self.limit = limit
        self.features = features
        self.window = window
        self.lags = lags
        self.leverage=leverage
        self.p1 = p1
        self.p2 = p2
        self.p3 = p3
        self.p_test = p_test
        self.episodes = episodes
    
    def _update_time(self):

        tmp = datetime.now()

        if tmp.year != self.now.year:
            deal_holiday()

        # 如果不是同一天且不是假日, 則更新主力資訊
        if tmp.day != self.now.day:

            
            if is_open():
                self.get_major()

        self.now = tmp

    # 取得主力資訊
    def get_major(self):
        '''
        今日主力買賣超
        '''
        r_date = datetime.strftime(self.now,'%Y%m%d')
        
        try:
            res = requests.get(f'https://www.twse.com.tw/rwd/zh/fund/T86?response=json&date={r_date}&selectType=ALLBUT0999&_=1685065571229')
            
            if res.status_code != 200:
                print(f'HTTP Error for {r_date}')
                return
        except:
            print(f'Cannot get {r_date} data..')
            return
    
        results = res.json()
        
        if 'data' in results.keys() and 'fields' in results.keys():
            
            df = pd.DataFrame(results['data'],columns=results['fields'])
            df.drop(columns=drop_col,inplace=True)
            df.columns = col
            self.tmc = df.copy()
            self.tmc['name_len'] = np.where(self.tmc['證券代號'].str.len()>5,1,0)
            self.tmc = self.tmc.loc[self.tmc['name_len'] == 0]
            self.tmc.drop(columns=['name_len'],inplace=True)
            print(r_date,'tmc done.')
        else:
            print('No three major data today yet.')
        
    # 選股
    def select_stocks(self,top_num):
        if self.tmc:
            new_symbols = []
            self.tmc.sort_values('total',ascending=False)
            new_symbols = self.tmc.iloc[:top_num*2]['證券代號'] + '.TW'
            
            if len(self.holding) < self.limit:

                self.holding = self.holding + new_symbols

            for symbol in self.holding:
                yf.pdr_override()
                raw = web.get_data_yahoo([symbol])
                self.stocks[symbol]['history']  = raw.copy()
                # 對數報酬率
                self.stocks[symbol]['history']['r'] = np.log(self.stocks[symbol]['history']['Close']/self.stocks[symbol]['history']['Close'].shift(1))
                # 策略報酬率
                self.stocks[symbol]['history']['s'] = self.stocks[symbol]['history']['Close'].rolling(window).mean()
                # 動量
                self.stocks[symbol]['history']['m'] = self.stocks[symbol]['history']['r'].rolling(window).mean()
                # 波動率
                self.stocks[symbol]['history']['v'] = self.stocks[symbol]['history']['r'].rolling(window).std()
                self.stocks[symbol]['history'].dropna(inplace=True)
            
        else:
            print('Cannot get three major data.')
    
    # 操作
    def start(self):
        self._build_backtest()
        self._create_agent()
        self._build_backtest()
        self.backtest()

    def _build_env(self):
        
        for i in self.holding:
            t = self.stocks[i]
            s = t['history']
            t['l_env'] = FinanceStock(i,s[self.features],self.features,window=self.window,lags=self.lags,leverage=self.leverage,
                                      min_performance=0.9,min_accuracy=0.475,start=self.p1,end=self.p2,mu=None,std=None,prepare_data=True)
            
            t['v_env'] = FinanceStock(i,s[self.features],self.features,window=self.window,lags=self.lags,leverage=self.leverage,
                                      min_performance=0.9,min_accuracy=0.475,start=self.p2,end=self.p3,mu=None,std=None,prepare_data=True)
            
            t['t_env'] = FinanceStock(i,s[self.features],self.features,window=self.window,lags=self.lags,leverage=self.leverage,
                                      min_performance=0.9,min_accuracy=0.475,start=self.p3,end=self.p_test,mu=None,std=None,prepare_data=True)
            print(s)

    def _create_agent(self):

        for i in self.holding:
            set_seeds(100)
            s = self.stocks[i]
            s['agent'] = TradingBot(s['l_env'],s['v_env'])
            s['agent'].learn(self.episodes)

            print(s)

    def _get_agent(self):
        
        for i in self.holding:
            set_seeds(100)
            s = self.stocks[i]
            s['agent'] = TradingBot(s['l_env'],s['v_env'])
#             self.tradingbots[symbol].learn(self.episodes)

    def _train_agent(self):

        pass

    def _build_backtest(self,amount=10000,ptc=0.0,ftc=0,verbose=False):

        for i in self.holding:
            
            if self.backtest_amount > amount:
                s = self.stocks[i]
                print(s['t_env'].symbol)
                s['backtester'] = TBBacktesterRM(s['t_env'],s['agent'].model,amount,ptc,ftc,verbose=verbose) #amount,ptc,ftc,verbose=False
                self.backtest_amount -= amount
            else:
                print(f'no enough amount for {i}')

    def backtest(self,sl=0.0,tsl=0.0,tp=0.0,wait=5):

        for i in self.holding:
            
            s = self.stocks[i]
            s['backtester'].backtest_strategy(sl=sl,tsl=tsl,tp=tp,wait=wait)
        
            perf = (s['backtester'].current_balance/s['backtester'].initial_amount - 1)* 100
            balance = s['backtester'].current_balance
            s['profit']= {'symbol':s['data'].symbol,'balance': balance,'net_performance':perf,'numberOfTrades': s['backtester'].trades}
        
            self.backtest_amount+= balance

    def show_report_backtest(self):

        print(f'Profit: {str(self.backtest_amount-self.init_amount)}')
        print(f'Growth: {str((self.backtest_amount/self.init_amount)*100)}%')

    def show_report(self):
        print(f'Profit: {str(self.total_amount-self.init_amount)}')
        print(f'Growth: {str((self.total_amount/self.init_amount)*100)}%')

class Stock:
    def __init__(self,symbol,amount,lags=3,window=20,leverage=1,p1=0,p2=0.6,p3=0.2,p_test=0.2,episodes=61,limit=5):
        self.now = datetime.now()
        # 已在操作的股票
        self.symbol = symbol
        self.history = pd.DataFrame()
        # self.get_major()
        self._update_time()
        self.init_amount = amount
        self.amount = amount
        self.backtest_amount = amount
        self.limit = limit
        self.features = features
        self.window = window
        self.lags = lags
        self.leverage=leverage
        self.p1 = p1
        self.p2 = p2
        self.p3 = p3
        self.p_test = p_test
        self.episodes = episodes
        self.backtest_profit = 0
        self._get_history()
        self._build_env()
        self._build_agent()
        self._build_backtester()

    def _update_time(self):

        tmp = datetime.now()

        if tmp.year != self.now.year:
            deal_holiday()

        # 如果不是同一天且不是假日, 則更新主力資訊
        if tmp.day != self.now.day:

            
            if is_open():
                get_major()

        self.now = tmp
        
    def _get_history(self):

        yf.pdr_override()
        raw = web.get_data_yahoo([self.symbol])
        self.history  = raw.copy()
        # 對數報酬率
        self.history['r'] = np.log(self.history['Close']/self.history['Close'].shift(1))
        # 策略報酬率
        self.history['s'] = self.history['Close'].rolling(self.window).mean()
        # 動量
        self.history['m'] = self.history['r'].rolling(self.window).mean()
        # 波動率
        self.history['v'] = self.history['r'].rolling(self.window).std()
        self.history['d'] = np.where(self.history['r'] > 0,1,0)
        self.history['d'] = self.history['d'].astype(int)
        self.history.dropna(inplace=True)

        print(f'get {self.symbol} latest data: {self.history.iloc[-1]}')

    def _build_env(self):
        self.l_env = FinanceStock(self.symbol,self.history[self.features],self.features,window=self.window,lags=self.lags,leverage=self.leverage,
                                      min_performance=0.9,min_accuracy=0.475,start=self.p1,end=self.p2,mu=None,std=None,prepare_data=True)
            
        self.v_env = FinanceStock(self.symbol,self.history[self.features],self.features,window=self.window,lags=self.lags,leverage=self.leverage,
                                      min_performance=0.9,min_accuracy=0.475,start=self.p2,end=self.p3,mu=None,std=None,prepare_data=True)
            
        self.t_env = FinanceStock(self.symbol,self.history[self.features],self.features,window=self.window,lags=self.lags,leverage=self.leverage,
                                      min_performance=0.9,min_accuracy=0.475,start=self.p3,end=self.p_test,mu=None,std=None,prepare_data=True)
        print(f'{self.symbol} environment built.')

    def _build_agent(self):

        set_seeds(100)
        self.agent = TradingBot(self.l_env,self.v_env)
        self.agent.learn(self.episodes)

        print(f'{self.symbol} agent created.')
    
    def _build_backtester(self):

        self.backtester = TBBacktesterRM(self.t_env,self.agent.model,self.amount,ptc,ftc,verbose=verbose) #amount,ptc,ftc,verbose=False
        print(f'{self.symbol} backtester built.')
    
#     def _get_agent(self):
        
#         for i in self.holding:
#             set_seeds(100)
#             s = self.stocks[i]
#             s['agent'] = TradingBot(s['l_env'],s['v_env'])
# #             self.tradingbots[symbol].learn(self.episodes)

    def backtest(self,sl=0.0,tsl=0.0,tp=0.0,wait=5):

            self.backtester.backtest_strategy(sl=sl,tsl=tsl,tp=tp,wait=wait)
        
            perf = (self.backtester.current_balance/self.backtester.initial_amount - 1)* 100
            balance = self.backtester.current_balance
            self.backtest_profit= {'balance': balance,'net_performance':perf,'numberOfTrades': self.backtester.trades}

    def show_report_backtest(self):

        print(f'Profit: {str(self.backtest_amount-self.init_amount)}')
        print(f'Growth: {str((self.backtest_amount/self.init_amount)*100)}%')

    def show_report(self):
        print(f'Profit: {str(self.amount-self.init_amount)}')
        print(f'Growth: {str((self.amount/self.init_amount)*100)}%')

    # 盯盤
    def start(self):
        
        self._update_time()
        print(self.now,end='\r')

    def update_state(self):
        # 每個交易日收盤的動作
        # 重新抓歷史資料(為了包含今日收盤資訊)
        self._get_history()
        # 重新learn agent
        self._build_agent()
        self._build_backtester()
        # 再預測明日操作
        state = self.l_env._get_state(len(self.history))
        action = np.argmax(self.agent.model.predict(self._reshape(state.values))[0,0])
        position = 1 if action == 1 else -1
        print(f"today's position: {position}")