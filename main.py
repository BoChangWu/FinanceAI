import time
import json
from datetime import datetime
from stock_data_fetch import *
from technical_analysis import *
from update_machine import *

from is_open import is_open

from environment import FinanceStock
from tradingbot import TradingBot,plot_treward,plot_performance,set_seeds
from backtester import TBBacktesterRM

# StockEnv
from StocksEnv import FinanceEnv
from technical_analysis import strategy_1
from finance import Finance,Stock,get_major
f = open('setting.json')
setting = json.load(f)
# start = f"{setting['Base']['last_year']}-01-01"
start = setting['TA']['period'][0]
end = setting['TA']['period'][1]
h_url = setting['Base']['consitution_url']
p_weight = setting['Base']['portfolio_weight']
tmc_url = setting['Base']['threeMajor_url']
features = setting['Base']['features_fix']
check_time = setting['Base']['check_time']
# if no data #######
# get_history(h_url)

# short = ShortTerm(start,end)
# long = LongTerm(start,end)
# v_list = short.pick_stock(p_weight['Risky'])
# s_list = long.pick_stock(p_weight['Stable'])
# print(v_list)
# print(s_list)
# p_list = v_list + s_list


# now = datetime.strftime(datetime.now(),'%Y-%m-%d')
# m = Stocks('2023-01-01',now,features)

# print([ (i,s.bband) for i,s in m.stocks.items()])

# m.define_ready()

# print(m.ready)

# port = Portfolio(p_list)
# port.bolling_band()
# port.plot_bolling_band(start,end)

# tm = ThreeMajor(tmc_url)
# tm.history()

# listen = Update_Machine(daily=[tm])

# listen.daily_listening(datetime(2023,1,15,15,00,00))

# tm.daily_data(datetime.now())


# StocksEnv
# a = FinanceEnv('2023-01-01',now,strategy_1,features)

# a.define_ready()
# a.build_env()
# a.create_agent()
# a.build_backtest()
# a.backtest()

# 看盤、選股
# a= Finance(total_amount=100000)
# a.select_stocks(2)
# 操盤
# 分析

# 就單一股票觀察
hour,minute = check_time.split(':')
hour = int(hour)
minute = int(minute)
a = Stock(symbol='2330.TW',amount=1000000)
a.backtest(sl=0.015)

now_time = datetime.now()
tmc = []

while now_time.hour != 0:

    t = datetime.now()
    # print(t.hour,hour,t.minute,minute)
    if t.hour == hour and t.minute == minute:
        
        if is_open():
            
            if datetime.strftime(datetime.now(),'%Y%m%d') not in tmc:
                print('update tmc..')
                tmc.append(get_major())

            a.update_state()
        else:
            print('not open.')

    a.start()
    
    time.sleep(5)

    now_time = datetime.now()
