import os
import math
import random
import numpy as np 
import pandas as pd
import yfinance as yf
import pandas_datareader.data as web
from pylab import plt,mpl
os.environ['PYTHONHASHSEED'] = '0'
plt.style.use('seaborn')
mpl.rcParams['savefig.dpi'] = 300
mpl.rcParams['font.family'] = 'serif' 

# 環境觀測空間
class observation_space:
    def __init__(self,n):
        self.shape = (n,)

# 環境的動作空間
class action_space:
    def __init__(self,n):
        self.n = n
    
    def sample(self):
        return random.randint(0,self.n-1)
    

# 股市環境
class FinanceStock:
    intraday = False

    def __init__(self,symbol,data:pd.DataFrame,features,window,lags,leverage=1,min_performance=0.85,
                 min_accuracy=0.5,start=0,end=None,mu=None,std=None,prepare_data=False):
        self.symbol = symbol
        self.data = data.copy()
        self.features = features
        self.n_features = len(self.features)
        self.window = window
        self.lags = lags
        self.leverage = leverage
        self.min_performance = min_performance
        self.min_accuracy = min_accuracy
        self.start = start
        self.end = end
        self.mu = mu
        self.std = std
        self.observation_space = observation_space(self.lags)
        self.action_space = action_space(2)
        

        self._prepare_data()

    def _prepare_data(self):
        '''
        製作更多欄位作為資料
        '''
        self.data.dropna(inplace=True)

        if self.mu is None:
            self.mu = self.data.mean()
            self.std = self.data.std()

        # Z-score
        self.data_ = (self.data - self.mu) / self.std
        # 買賣信號
        

        if self.end is not None:
            self.data = self.data.iloc[:int(self.end*len(self.data))]
            self.data_ = self.data_.iloc[:int(self.end*len(self.data_))]
        # print(self.data)
    def _get_state(self,bar=None):
        '''
        取得狀態
        '''
        if bar:
            self.bar = bar

        return self.data_[self.features].iloc[self.bar-self.lags:self.bar]
    
    def seed(self,seed=100):
        '''
        設定亂數種子
        '''
        random.seed(seed)
        np.random.seed(seed)

    def reset(self):
        '''
        回歸初始設定
        '''
        self.treward = 0
        self.accuracy = 0
        self.performance = 1
        self.bar = self.lags
        state = self.data_[self.features].iloc[self.bar-self.lags:self.bar]
        # print('State',state)
        return state.values

    def step(self,action):
        correct = action == self.data['d'].iloc[self.bar]
        ret = self.data['r'].iloc[self.bar] * self.leverage
        reward_1 = 1 if correct else 0
        reward_2 = abs(ret) if correct else -abs(ret)
        self.treward += reward_1
        self.bar += 1
        self.accuracy = self.treward / (self.bar-self.lags)
        self.performance *= math.exp(reward_2)

        if self.bar >= len(self.data):
            done = True
        elif reward_1 == 1:
            done = False
        elif (self.performance < self.min_performance) and (self.bar > self.lags + 15):
            done = True
        elif (self.accuracy < self.min_accuracy) and (self.bar > self.lags + 15):
            done = True
        else:
            done = False

        state = self._get_state()
        info = {}

        return state.values,reward_1+reward_2*5,done,info