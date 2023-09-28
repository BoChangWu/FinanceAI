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
env = test_env
tb = TBBacktesterRM(env,agent.model,10000,0.0,0,verbose=False)
# 無任何風險衡量指標而回測交易機器人的績效
tb.backtest_strategy(sl=None,tsl=None,tp=None,wait=5)
# 使用 SL單回測交易機器人績效(無保證)
tb.backtest_strategy(sl=None,tsl=None,tp=None,wait=10,guarantee=False)
# 使用 SL單回測交易機器人績效(有保證)
tb.backtest_strategy(sl=0.3,tsl=None,tp=None,wait=5,guarantee=True)
# 回測有TSL單的交易機器人績效
tb.backtest_strategy(sl=None,tsl=0.015,tp=None,wait=5)
# 使用TP單回測交易機器人績效(無保證)
tb.backtest_strategy(sl=None,tsl=None,tp=0.015,wait=5,guarantee=False)
# 使用TP單回測交易機器人績效(有保證)
tb.backtest_strategy(sl=None,tsl=None,tp=0.015,wait=5,guarantee=True)
# SL 結合 TP
tb.backtest_strategy(sl=0.015,tsl=None,tp=0.0185,wait=5)
# TSL 結合 TP
tb.backtest_strategy(sl=None,tsl=0.02,tp=0.02,wait=5)

