import os
import time
import talib
import traceback
import numpy as np
import pandas as pd
import yfinance as yf
import tensorflow as tf
import pandas_datareader.data as web
from matplotlib import pyplot as plt

import matplotlib
matplotlib.rc('font', family='Microsoft JhengHei')

url = './data/stock_list.csv'
stockdata_url = './data/stocks_info/'

basics = ['totalRevenue',
          'grossMargins',
          'operatingMargins',
          'profitMargins',
          'EPS',
          'PE',
          'payoutRatio',
          'bookValuePerShare',
          'operatingCashflow',
         'freeCashflow',
          'sharesOutstanding'
         ]


# 讀取所有票資訊
def get_all_stocks_info(source,saving=False):
    stocks = pd.read_csv(source,index_col=0)
    stocks_dict = {}

    for i in range(len(stocks)):
        s = stocks.iloc[i]
        
        if s['代號'] > 9999:
            continue
        elif 'KY' in s['股票名稱']:
            continue
        symbol = str(s['代號']).zfill(4) if s['代號']< 1000 else str(s['代號'])
        stocks_dict[s['股票名稱']] = yf.Ticker(symbol+'.TW')
        
            
        if saving:
            
            stock_data=None
            info = stocks_dict[s['股票名稱']].info
            
            for r,d,f in os.walk(stockdata_url):
                if f == symbol + '.csv':
                    stock_data = pd.read_csv(stockdata_url+symbol+'.csv')

            revenue = info['totalRevenue'] if 'totalRevenue' in info.keys() else 0
            grossMargins = info['grossMargins'] if 'grossMargins' in info.keys() else 0.0
            operatingMargins = info['operatingMargins'] if 'operatingMargins' in info.keys() else 0.0
            profitMargins = info['profitMargins'] if 'profitMargins' in info.keys() else 0.0
            EPS = info['trailingEps'] if 'trailingEps' in info.keys() else 0.0
            PE = info['currentPrice']/ info['trailingEps']*100 if 'trailingEps' in info.keys() else 0.0
            payoutRatio = info['payoutRatio'] if 'payoutRatio' in info.keys() else 0
            bookValuePerShare = info['bookValue'] / info['sharesOutstanding'] if 'sharesOutstanding' in info.keys() else 0.0
            operatingCashflow = info['operatingCashflow'] if 'operatingCashflow' in info.keys() else 0
            freeCashflow = info['freeCashflow'] if 'freeCashflow' in info.keys() else 0
            sharesOutstanding = info['sharesOutstanding'] if 'sharesOutstanding' in info.keys() else 0
            
            
            if stock_data:
                stock_data.append([[revenue,grossMargins,operatingMargins,profitMargins,EPS,
                                   PE,payoutRatio,bookValuePerShare,operatingCashflow,freeCashflow,sharesOutstanding]])
                
            else:
                stock_data = pd.DataFrame([[revenue,grossMargins,operatingMargins,profitMargins,EPS,
                                   PE,payoutRatio,bookValuePerShare,operatingCashflow,freeCashflow,sharesOutstanding]])
                stock_data.columns = basics
            
            stock_data.to_csv(stockdata_url+symbol+'.csv')
         
        
        
            if i%10 == 0:
                time.sleep(1.5)
    
    return stocks_dict

stock_list = get_all_stocks_info(url,saving=False)


comp_health = pd.DataFrame()
index = 0 
window = 20
stock_csv_url= './data/stocks/'
year = '2022'


# PE = info['currentPrice']/ info['trailingEps']
# 建立market資料
def build_finance_data():
    for i,k in stock_list.items():
        i = ''.join(k if k!='*' else '' for k in i)
        info = None
        
        try:
            info = k.info
        except:
            print(f'{k} cannot get info')
            index+=1
            continue
        
        if info:
            start = year + '-01-01'
            end = year + '-12-31'
            
            symbol = info['symbol']
            growth = info['revenueGrowth'] if 'revenueGrowth' in info.keys() else 0
            operatingCashflow = info['operatingCashflow'] if 'operatingCashflow' in info.keys() else 0
            freeCashflow = info['freeCashflow'] if 'freeCashflow' in info.keys() else 0
            price = info['currentPrice'] if 'currentPrice' in info.keys() else 0
            value = info['sharesOutstanding']* price if 'sharesOutstanding' in info.keys() else 0
            
            yf.pdr_override()
            raw = web.get_data_yahoo([symbol])
            data = pd.DataFrame(raw['Close'])
            # 對數報酬率
            data['r'] = np.log(data['Close'] / data['Close'].shift(1))
            data.dropna(inplace=True)
            # 策略報酬率
            data['s'] = data['Close'].rolling(window).mean()
            # 動量
            data['m'] = data['r'].rolling(window).mean()
            # 波動率
            data['v'] = data['r'].rolling(window).std()
            data.dropna(inplace=True)
            
            if 'currentPrice' not in info.keys():
                print(f"{i}({info['symbol']}) does not have currentPrice")
            elif 'trailingEps' not in info.keys():
                print(f"{i}({info['symbol']}) does not have trailingEps")
            else:
                # 本益比計算
                data['PE'] = data['Close'].apply(lambda x: x/info['trailingEps'] if info['trailingEps']!=0 else x)
            
            if 'PE' in data.columns and len(data['PE']) > 0:
                # 儲存csv
                _m = data.mean()
                comp_health = comp_health.append([[i,symbol,price,_m['r'],_m['s'],_m['m'],_m['v'],_m['PE'],
                                                growth,operatingCashflow,freeCashflow,value]])
                
                
                print(f"{i}({info['symbol']}) Done.")
        index+=1
        if index % 10 == 0:
            time.sleep(5)

    comp_health.columns = ['name','symbol','currentPrice','r','s','m','v',
                        'PE','revenueGrowth','operatingCashflow','freeCashflow','marketValue']
    comp_health.to_csv(f"{stock_csv_url}market-{year}.csv")

# if 沒有股票的檔案
build_finance_data()
# 如果有資料
comp_health = pd.read_csv(stock_csv_url+f'market-{year}.csv',index_col=0)

# 查看0050的波動作為波動參考基準
yf.pdr_override()
raw = web.get_data_yahoo(['0050.TW'])
standard = pd.DataFrame(raw['Close'])

standard['r'] = np.log(standard['Close'] / standard['Close'].shift(1))
standard['v'] = standard['r'].rolling(window).std()
standard.dropna(inplace=True)
standard = standard[year+'-01-01':year+'-12-31']

# 風險股
# 波動率大於 0.018，略大於市場
v_stocks=comp_health.loc[comp_health['v']>0.018]
# 本益比介於0~10之間，可以相對便宜的價格購買且可較快回收本金
v_stocks = v_stocks.loc[(v_stocks['PE']<10)&(v_stocks['PE']>0)]
# 營收成長大於-0.2
v_stocks = v_stocks.loc[v_stocks['revenueGrowth']>-0.2]
# 營運現金流大於0
v_stocks = v_stocks.loc[v_stocks['operatingCashflow']>0]
# 對數報酬率大於0
v_stocks = v_stocks.loc[v_stocks['r']>0]
# 自由現金流大於0
v_stocks = v_stocks.loc[v_stocks['freeCashflow']>=0]
# 依照市值大小順序排列
v_stocks= v_stocks.sort_values('marketValue',ascending=False)

# 穩定股
# 波動率落在0.006~0.018之間
s_stocks=comp_health.loc[(comp_health['v']>=0.006)&(comp_health['v']<0.018)]
# 本益比落在10~20之間
s_stocks = s_stocks.loc[(s_stocks['PE']>=10)&(s_stocks['PE']<=20)]
# 營收成長大於-0.1
s_stocks = s_stocks.loc[s_stocks['revenueGrowth']>-0.1]
# 營運現金流大於0
s_stocks = s_stocks.loc[s_stocks['operatingCashflow']>0]
# 自由現金流大於0
s_stocks = s_stocks.loc[s_stocks['freeCashflow']>=0]
# 對數報酬率大於0
s_stocks = s_stocks.loc[s_stocks['r']>0]
# 依照市值大小順序排列
s_stocks = s_stocks.sort_values('marketValue',ascending=False)


# 組成投資組合
comb = (2,4)
comb_list = s_stocks[:comb[0]]['symbol'].to_list() + v_stocks[:comb[1]]['symbol'].to_list()

portfolio = dict()

# 開始取得投資組合的歷史資料
for c in comb_list:
    yf.pdr_override()
    raw = web.get_data_yahoo([c])
    portfolio[c] = pd.DataFrame(raw['Close'])


# 視覺化投資組合
def plot_portfolio():
    for i,k in portfolio.items():
        upperband,middleband,lowerband = talib.BBANDS(k['Close'],timeperiod=20,nbdevup=2,nbdevdn=2,matype=0)
        
        plt.figure(figsize=(10,6))

        plt.plot(upperband['2023-01-01':'2023-10-19'],
                label="upperband",color='b',
                linestyle='--')
        plt.plot(middleband['2023-01-01':'2023-10-19'],
                label="middleband",color='g',linestyle='--')
        plt.plot(lowerband['2023-01-01':'2023-10-19'],
                label="lowerband",color='b',
                linestyle='--')
        plt.plot(k['2023-01-01':'2023-10-19']['Close'],
                label='close',color='r',
                linestyle='solid',)
        plt.title(f"{i} Bollinger Band Chart") 
        plt.xlabel("Day") 
        plt.ylabel("Bollinger Band")

from environment import FinanceStock
from tradingbot import TradingBot,plot_treward,plot_performance,set_seeds
from backtester import TBBacktesterRM

symbols = comb_list
features_fix = ['r','s','m','v']


class FinEnv:
    def __init__(self,symbols,features_fix,window=20,lags=3,leverage=1,episodes=61,split=0.6,valid=0.2,test=0.2):
        self.symbols = symbols
        self.features_fix = features_fix
        self.window = window
        self.lags = lags
        self.leverage = leverage
        self.episodes = episodes
        self.start = 0
        self.split = split
        self.valid = valid
        self.test = test 
        
        self.l_envs = dict()
        self.v_envs = dict()
        self.t_envs = dict()
        self.tradingbots = dict()
        self.backtesters = dict()
        self.profits = dict()
        
        self._build_env()
#         self._build_tradingbot()
        
    def _build_env(self):
        
        for symbol in self.symbols:
            learn_env = FinanceStock(symbol,[symbol] + self.features_fix,window=self.window,lags=self.lags,leverage=self.leverage,min_performance=0.9,
                         min_accuracy=0.475,start=self.start,end=self.split,mu=None,std=None)
            
            self.l_envs[symbol] = learn_env
    
            self.v_envs[symbol] = FinanceStock(symbol,features=learn_env.features,window=learn_env.window,lags=learn_env.lags,
                         leverage=learn_env.leverage,min_performance=0.0,min_accuracy=0.0,start=self.split,
                         end=self.split+self.valid,mu=learn_env.mu,std=learn_env.std)

            self.t_envs[symbol] = FinanceStock(symbol,features=learn_env.features,window=learn_env.window,lags=learn_env.lags,
                         leverage=learn_env.leverage,min_performance=0.0,min_accuracy=0.0,start=self.split+self.valid,
                         end=self.split+self.valid+self.test,mu=learn_env.mu,std=learn_env.std)
            
    
    def _build_tradingbot(self):
        
        for symbol in self.symbols:
            set_seeds(100)
            self.tradingbots[symbol] = TradingBot(self.l_envs[symbol],self.v_envs[symbol])
            self.tradingbots[symbol].learn(self.episodes)
            
            
    def _get_tradingbot(self):
        for symbol in self.symbols:
            set_seeds(100)
            self.tradingbots[symbol] = TradingBot(self.l_envs[symbol],self.v_envs[symbol])
#             self.tradingbots[symbol].learn(self.episodes)

env = FinEnv(symbols,features_fix,leverage=2)

# if 沒有model
env._build_tradingbot()
#if 有model
env._get_tradingbot()

for s in env.symbols:
    env.backtesters[s] = TBBacktesterRM(env.t_envs[s],env.tradingbots[s].model,10000,0.0,0,verbose=True)
    env.backtesters[s].backtest_strategy(sl=0.015,tsl=None,tp=0.0185,wait=5)
    
    perf = (env.backtesters[s].current_balance/env.backtesters[s].initial_amount - 1)* 100
    balance = env.backtesters[s].current_balance
    env.profits[s] = {'symbol':s,'balance': balance,'net_performance':perf,'numberOfTrades': env.backtesters[s].trades}


for i,k in env.profits.items():
    print('-'*10)
    for m,n in k.items():
        print(m,n)
        
    print('-'*10)