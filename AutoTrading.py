import numpy as np
import pandas as pd
from backtester import TBBacktesterRM
from environment import FinanceStock
from tradingbot import TradingBot,set_seeds,plot_performance,plot_treward
from setting import symbol,features,start,split,valid,test,episodes


learn_env = FinanceStock(symbol,features,window=20,lags=3,leverage=1,min_performance=0.9,
                         min_accuracy=0.475,start=start,split=start,end=split,mu=None,std=None)

valid_env = FinanceStock(symbol,features=learn_env.features,window=learn_env.window,lags=learn_env.lags,
                         leverage=learn_env.leverage,min_performance=0.0,min_accuracy=0.0,start=split,
                         end=split+valid,mu=learn_env.mu,st=learn_env.std)

test_env = FinanceStock(symbol,features=learn_env.features,window=learn_env.window,lags=learn_env.lags,
                         leverage=learn_env.leverage,min_performance=0.0,min_accuracy=0.0,start=split,
                         end=split+valid,mu=learn_env.mu,st=learn_env.std)

set_seeds(100)
agent = TradingBot(learn_env,valid_env)
agent.learn(episodes)