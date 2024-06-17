import setting
import os
import talib
import json
import numpy as np
import pandas as pd
import numpy as np
import pandas as pd
import yfinance as yf
import matplotlib.pyplot as plt
import pandas_datareader.data as web
import matplotlib
from datetime import datetime
matplotlib.rc('font', family='Microsoft JhengHei')

# get setting 
f = open('setting.json')
setting = json.load(f)
conurl = setting['Base']['consitution_url']
window = setting['Base']['window']
year = setting['Base']['last_year']

def strategy_1(data,timeperiod=20,std=2,show=False):
    '''
    bolling 買點 + 
    '''
    # symbol = data.symbol
    history = data.history
    upperband,middleband,lowerband = talib.BBANDS(history['Close'],timeperiod=timeperiod,nbdevup=std,nbdevdn=std,matype=0)

    cross_lower = np.where((history['Close']>lowerband) & (history['Close'].shift(1)<lowerband),1,0)
    if cross_lower[-1] == 1:
        print(f'股價由下往上穿越下線：股價可能短期會反轉')
        return data.symbol

    cross_middle = np.where((history['Close']>middleband) & (history['Close'].shift(1)<middleband),1,0)
    if cross_middle[-1] == 1:
        print(f'股價由下往上穿越中線：股價可能會加速向上，是買進訊號。')
        return data.symbol

    middle_upper = np.where((history['Close']>middleband) & (history['Close']<upperband),1,0)
    if middle_upper[-window:].all() == 1:
        print(f'股價在中線與上線之間：代表目前為多頭行情。')
        return None
    
    ### GO SHORT ###
    under_upper = np.where((history['Close']<upperband) & (history['Close'].shift(1)>upperband),1,0)
    if under_upper[-1] == 1:
        print(f'股價由上往下跌破上線：暗示上漲趨勢結束，是賣出的訊號。')
        return None

    under_middle = np.where((history['Close']<middleband) & (history['Close'].shift(1)> middleband) ,1,0)
    if under_middle[-1] == 1:
        print(f'股價由上往下跌破中線：股價可能會下跌，是賣出訊號。')
        return None

    middle_lower = np.where((history['Close']>lowerband)&(history['Close']<middleband),1,0)
    if middle_lower[-window:].all() == 1:
        print(f'股價在中線與下線之間：代表目前為空頭行情。')
        return None

    '''
    start: 'yyyy-mm-dd'

    end: 'yyyy-mm-dd'
    '''
    # if show:
    #     fig,axs = plt.subplots(len(self.values),1,figsize=(30,100))
        
    #     index = 0
    #     for i,k in self.values.items():

    #         axs[index].set_title(i)
    #         axs[index].plot(k['upperband'][self.start:self.end],label='upper',color='b',linestyle='--')
    #         axs[index].plot(k['middleband'][self.start:self.end],label='middle',color='g',linestyle='--')
    #         axs[index].plot(k['lowerband'][self.start:self.end],label='lower',color='b',linestyle='--')
    #         axs[index].plot(k['close'][self.start:self.end],label='close',color='r',linestyle='solid')
    #         index += 1

    #     plt.show()
    

class Portfolio():
    
    def __init__(self,symbols,start='2000-01-01',end=datetime.strftime(datetime.now(),'%Y-%m-%d')):
        self.start = start
        self.end = end
        self.symbols = symbols
        self.data = dict()

        self._get_data()
        self.bbands = Bbands(self.data,self.start,self.end)
        self.trend = Trend_Form(self.data)

    def _get_data(self):
        
        for symbol in self.symbols:

            self.data[symbol] = pd.read_csv(f"{conurl}/history/{symbol[:-3]}.csv",index_col=0)            

    
class Trend_Form():
    
    def __init__(self,data,start,end):
        
        self.data = data
        self.start = start
        self.end = end

class Bbands:

    def __init__(self,data,start,end,no_data=False):
        
        if no_data == False:

            try:
                self.values = data['Close'].copy()
            except:
                print('data:',data)
            self.start = start
            self.end = end
            self.focus = False
            self._bolling_band()

        else:
            return

    def _bolling_band(self):
        
        if self.values.isnull().all():
            return
        else:
            self.values['upperband'],self.values['middleband'],self.values['lowerband'] = talib.BBANDS(self.values,timeperiod=20,nbdevup=2,nbdevdn=2,matype=0)
        
            
    def bolling_check(self,window=2):
        
        ### GO LONG ###
        self.values['cross_lower'] = np.where((self.values['close']>self.values['upperband'],self.values['middleband'],self.values['lowerband']['lowerband']) & (self.values['close'].shift(1)<self.values['lowerband']),1,0)
        if self.values['cross_lower'][-1] == 1:
            print(f'股價由下往上穿越下線：股價可能短期會反轉')
            self.focus = True

        self.values['cross_middle'] = np.where((self.values['close']>self.values['middleband']) & (self.values['close'].shift(1)<self.values['middleband']),1,0)
        if self.values['cross_middle'][-1] == 1:
            print(f'股價由下往上穿越中線：股價可能會加速向上，是買進訊號。')
            self.focus = True

        self.values['middle_upper'] = np.where((self.values['close']>self.values['middleband']) & (self.values['close']<self.values['upperband']),1,0)
        if self.values['middle_upper'][-window:] == [1]*window:
            print(f'股價在中線與上線之間：代表目前為多頭行情。')
        
        ### GO SHORT ###
        self.values['under_upper'] = np.where((self.values['close']<self.values['upperband']) & (self.values['close'].shift(1)>self.values['upperband']),1,0)
        if self.values['under_upper'][-1] == 1:
            print(f'股價由上往下跌破上線：暗示上漲趨勢結束，是賣出的訊號。')
            self.focus = True

        self.values['under_middle'] = np.where((self.values['close']<self.values['middleband']) & (self.values['close'].shift(1)> self.values['middleband']) ,1,0)
        if self.values['under_middle'][-1] == 1:
            print(f'股價由上往下跌破中線：股價可能會下跌，是賣出訊號。')
        
        
        self.values['middle_lower'] = np.where((self.values['close']>self.values['lowerband'])&(self.values['close']<self.values['middleband']),1,0)
        if self.values['middle_lower'][-window:] == [1]*window:
            print(f'股價在中線與下線之間：代表目前為空頭行情。')

        return self.focus
            
    def plot_bolling_band(self):
        '''
        start: 'yyyy-mm-dd'

        end: 'yyyy-mm-dd'
        '''
        fig,axs = plt.subplots(len(self.values),1,figsize=(30,100))
        
        index = 0
        for i,k in self.values.items():

            axs[index].set_title(i)
            axs[index].plot(k['upperband'][self.start:self.end],label='upper',color='b',linestyle='--')
            axs[index].plot(k['middleband'][self.start:self.end],label='middle',color='g',linestyle='--')
            axs[index].plot(k['lowerband'][self.start:self.end],label='lower',color='b',linestyle='--')
            axs[index].plot(k['close'][self.start:self.end],label='close',color='r',linestyle='solid')
            index += 1

        plt.show()
        # plt.xlabel("Day") 
        # plt.ylabel("Bollinger Band")