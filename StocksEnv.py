import os
import json
import time
import talib
import traceback
import requests
import numpy as np
import pandas as pd
import yfinance as yf
from technical_analysis import *
import pandas_datareader.data as web
from datetime import datetime,timedelta
from environment import FinanceStock
from tradingbot import TradingBot,plot_treward,plot_performance,set_seeds
from backtester import TBBacktesterRM

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
window = setting['Base']['window']
year = setting['Base']['last_year']
features = setting['Base']['features_fix']

def manage_stock_list():
    _list = []
    for r,d,file in os.walk(conurl+'/history/'):
        for f in file:
            _list.append(f[:-4])
    # print(_list)
    return _list


class FinanceEnv:

    def __init__(self,start,end,method,features,lags=3,leverage=1,episodes=61,p1=0,p2=0.6,p3=0.2,p_test=0.2,offline=False):

        self.start = start
        self.end = end
        self.symbols = pd.read_csv(listurl,index_col=0)
        self.stocks = dict() # stocks: {'stock1':{'data':,'lenv':,'v_env':','t_env','agent','backtester','profit'}..}
        self.tmc = pd.DataFrame()
        self._fetch_three_major()
        
        # 篩選stock
        self.ready = list()
        self.method = method
        if offline:
            self._get_data_local()
        else:
            self._launch()
        # ML relative
        self.features = features
        self.window = window
        self.lags = lags
        self.leverage = leverage
        self.episodes = episodes
        self.p1 = p1
        self.p2 = p2
        self.p3 = p3
        self.p_test = p_test 

    class Stock:

        def __init__(self,name,symbol,tmc):

            self.no_data = True
            self.name = name
            self.symbol = str(symbol).zfill(4)+'.TW' if symbol< 1000 else str(symbol)+'.TW'
            self.history = None
            self.tmc_history = self._get_tmc(tmc)
            self._launch()

        def _launch(self):
            
            to_digit = int(self.symbol[:-3])

            if to_digit > 9999:
                return
            elif 'KY' in self.name or 'DR' in self.name:
                return
            else:
                yf.pdr_override()
                raw = web.get_data_yahoo([self.symbol])
                self.history  = raw.copy()
                
                if self.history['Close'].isnull().all():
                    print(f'{self.name} all data is NaN')
                    return 
                
                # 對數報酬率
                self.history['r'] = np.log(self.history['Close']/self.history['Close'].shift(1))
                # 策略報酬率
                self.history['s'] = self.history['Close'].rolling(window).mean()
                # 動量
                self.history['m'] = self.history['r'].rolling(window).mean()
                # 波動率
                self.history['v'] = self.history['r'].rolling(window).std()
                self.history.dropna(inplace=True)
                self.history.to_csv(conurl+'/history/'+self.symbol[:-3]+'.csv')
                self.no_data = False

                self.ticker = yf.Ticker(self.symbol)

        def _get_tmc(self,today):
            
            if not today:
                today = pd.DataFrame()
                
            if today.empty == False:
                today.index = pd.to_datetime([datetime.strftime(datetime.now(),'%Y-%m-%d')])
                try:
                    tmc_h = pd.read_csv(tmcurl,index_col=0)
                    tmc_h = tmc_h.append(today)
                except:
                    print(f'cannot get {self.name} three major history file.')
                    tmc_h = today 
                
                return tmc_h
            else:
                return pd.DataFrame()

    def _launch(self):
        _list = pd.read_csv(listurl,index_col=0)

        for i in range(len(_list)):
            s = _list.iloc[i]
            
            if self.tmc.empty == False:
                tmp = self.tmc.loc[self.tmc['symbol']==s['代號']].loc[:,col[2:]]
            else:
                tmp = None

            stock = self.Stock(s['股票名稱'],s['代號'],tmp)
            
            if stock.no_data == True:
                continue
            self.stocks[stock.symbol] = {}
            self.stocks[stock.symbol]['data'] = stock
            
            time.sleep(1)

    def _get_data_local(self):
        pass

    def _fetch_three_major(self):

        r_date = datetime.strftime(datetime.now(),'%Y%m%d')
        
        try:
            res = requests.get(f'https://www.twse.com.tw/rwd/zh/fund/T86?response=json&date={r_date}&selectType=ALLBUT0999&_=1685065571229')
            
            if res.status_code != 200:
                print(f'HTTP Error for {r_date}')
                return
        except:
            print(f'Cannot get {r_date} data..')
    
        results = res.json()
        
        if 'data' in results.keys() and 'fields' in results.keys():
            df = pd.DataFrame(results['data'],columns=results['fields'])
            df.drop(columns=drop_col,inplace=True)
            df.columns = col
            self.tmc = df.copy()
            print(r_date,'tmc done.')

    def define_ready(self):

        for i,s in self.stocks.items():

            r = self.method(s['data'])
            if r:
                self.ready.append(r)
        
        # 刻意削減,y之後再透過其他條件篩選
        self.ready = self.ready[23:26]+self.ready[31:34]
        print(self.ready)
        
    def build_env(self):
        
        for i in self.ready:

            s = self.stocks[i]
            s['l_env'] = FinanceStock(i,s['data'].history[self.features],self.features,window=self.window,lags=self.lags,leverage=self.leverage,
                                      min_performance=0.9,min_accuracy=0.475,start=self.p1,end=self.p2,mu=None,std=None,prepare_data=True)
            
            s['v_env'] = FinanceStock(i,s['data'].history[self.features],self.features,window=self.window,lags=self.lags,leverage=self.leverage,
                                      min_performance=0.9,min_accuracy=0.475,start=self.p2,end=self.p3,mu=None,std=None,prepare_data=True)
            
            s['t_env'] = FinanceStock(i,s['data'].history[self.features],self.features,window=self.window,lags=self.lags,leverage=self.leverage,
                                      min_performance=0.9,min_accuracy=0.475,start=self.p3,end=self.p_test,mu=None,std=None,prepare_data=True)
            print(s)
    def create_agent(self):

        for i in self.ready:
            set_seeds(100)
            s = self.stocks[i]
            s['agent'] = TradingBot(s['l_env'],s['v_env'])
            s['agent'].learn(self.episodes)

            print(s)
    def get_agent(self):
        
        for i in self.ready:
            set_seeds(100)
            s = self.stocks[i]
            s['agent'] = TradingBot(s['l_env'],s['v_env'])
#             self.tradingbots[symbol].learn(self.episodes)

    def train_agent(self):

        pass

    def build_backtest(self,amount=10000,ptc=0.0,ftc=0,verbose=False):

        for i in self.ready:

            s = self.stocks[i]
            print(s['t_env'].symbol)
            s['backtester'] = TBBacktesterRM(s['t_env'],s['agent'].model,amount,ptc,ftc,verbose=verbose) #amount,ptc,ftc,verbose=False
            
    def backtest(self,sl=0.0,tsl=0.0,tp=0.0,wait=5):

        for i in self.ready:
            
            s = self.stocks[i]
            s['backtester'].backtest_strategy(sl=sl,tsl=tsl,tp=tp,wait=wait)
        
            perf = (s['backtester'].current_balance/s['backtester'].initial_amount - 1)* 100
            balance = s['backtester'].current_balance
            s['profit']= {'symbol':s['data'].symbol,'balance': balance,'net_performance':perf,'numberOfTrades': s['backtester'].trades}
