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
'''
可以加入volume(成交量)與three major(三大法人買賣超) 作為篩選投資組合的條件，法人資訊還須花時間爬取
'''
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

class Stocks:
    def __init__(self,start,end,features,offline=False):
        manage_stock_list()
        self.start = start
        self.end = end
        self.features = features
        self.symbols = pd.read_csv(listurl,index_col=0)
        self.stocks = dict()
        self.tmc = pd.DataFrame()
        self._fetch_three_major()
        self.ready = list()
        
        if offline:
            self._get_data_local()
        else:
            self._launch()
    
    class Stock:

        def __init__(self,name,symbol,tmc,start,end):
            self.no_data = True
            self.name = name
            self.symbol = str(symbol).zfill(4)+'.TW' if symbol< 1000 else str(symbol)+'.TW'
            self.history = None
            
            self.tmc_history = self._get_tmc(tmc)
            self._launch()

            if self.no_data == False:
                # 布林通道class
                self.bband = Bbands(self.history,start,end,self.no_data)
            else:
                self.bband = None
                return
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

            stock = self.Stock(s['股票名稱'],s['代號'],tmp,self.start,self.end)
            
            if stock.no_data == True:
                continue
            
            self.stocks[stock.symbol] = stock
            
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

            if s.bband:
                s.bband.bolling_check()
                if s.bband.ready == True:
                    self.ready.append(s.symbol)
        
# 短期操作相關資料
class ShortTerm():

    def __init__(self,start,end,standard='0050.TW'):
        self.start = start
        self.end = end
        self.standard = standard
        self.stocks = manage_stock_list()
        self.data = dict()
        # self._data = dict()
        self._get_data()

    def _get_data(self) -> None:
        
        for s in self.stocks:
            
            symbol = str(s)+'.TW'
            
            try:
                self.data[symbol] = pd.read_csv(f"{conurl}/history/{str(s)}.csv",index_col=0)
                # self._data[symbol] = self.data[symbol]['Close']
            except:

                print()
        

    def pick_stock(self,num) -> list:

        '''
        先看volume
        再看v
        '''
        volumes = pd.DataFrame()
        volatilities = pd.DataFrame()
        signal = pd.DataFrame()
        picked = list()
        # 0050報酬率與波動率計算
        
        stv = self.data[self.standard]['v'].mean()
        
        # 選擇成交量(個股平均成交量大於總平均成交量)
        for i,k in self.data.items():
            # print(i,k)
            volumes = volumes.append([[i,k['Volume'][self.start:self.end].mean()]])
        
        volumes.columns = ['symbol','volume']
        # print(volumes)
        vol_mean = volumes['volume'].mean()  
        volumes = volumes.loc[volumes['volume']>vol_mean]

        # 波動率(選擇大於0050波動率的)
        
        for i in volumes['symbol'].to_list():
            
            vm = self.data[i]['v'].mean()

            if  vm > stv:
                tmp = volumes.loc[volumes['symbol'] == i]
                # print('a',a['volume'].values)
                volatilities = volatilities.append([[i,vm,tmp['volume'].values[0]]])

        volatilities.columns = ['symbol','v','vol']
        # 依照成交量的大小排序後取前n多的股票
        # print(volatilities['vol'])
        volatilities.sort_values(by='vol',ascending=False)
        picked = volatilities['symbol'][:num].to_list()

        return picked

    def listening(self):
        pass
        
# 長期投資相關資料
class LongTerm():

    def __init__(self,start,end,v=(0.005,0.018),pe=(10,20),rg=-0.1,oc=0,fc=0,standard='0050.TW'):
        self.stocks = manage_stock_list()
        self.stocks_dict = dict()
        self.data = None
        self.v = v
        self.pe = pe
        self.rg= rg
        self.oc= oc
        self.fc = fc
        self.standard = standard
        self._get_data()
       
    def _get_data(self) -> None:

        target = f'market-{year}.csv'

        for s in self.stocks:

            self.stocks_dict[s+'.TW'] = yf.Ticker(s+'.TW')

        for r,d,files in os.walk(conurl):
            
            for f in files:
                if f == target:
                    self.data = pd.read_csv(conurl+'/'+target)
                    print(f'Found market data : {target}')
                    return
        
        
        self._build_data(save_data=True)

    def _build_data(self,save_data=False) -> None:

        self.data = pd.DataFrame()
        index = 0

        for i,k in self.stocks_dict.items():
            i = ''.join(k if k!='*' else '' for k in i)
            info = None
            
            try:
                info = k.info
            except:
                print(f'{k} cannot get info')
                index+=1
                continue
        
            if info:
                
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
                    self.data = self.data.append([[i,symbol,price,_m['r'],_m['s'],_m['m'],_m['v'],_m['PE'],
                                                    growth,operatingCashflow,freeCashflow,value]])
                
                
                    print(f"{i}({info['symbol']}) Done.")

            index+=1
            if index % 10 == 0:
                time.sleep(5)

        self.data.columns = ['name','symbol','currentPrice','r','s','m','v',
                            'PE','revenueGrowth','operatingCashflow','freeCashflow','marketValue']
        if save_data:
            self.data.to_csv(f"{conurl}/market-{year}.csv")

    def pick_stock(self,num) -> list:

        '''
        透過本益比與0050為基準去看波動率篩選
        檢查營運現金流量與自由現金流量
        最後用市值排名
        '''
        yf.pdr_override()
        raw = web.get_data_yahoo(['0050.TW'])
        role_model = pd.DataFrame(raw['Close'])

        role_model['r'] = np.log(role_model['Close'] / role_model['Close'].shift(1))
        role_model['v'] = role_model['r'].rolling(window).std()
        role_model.dropna(inplace=True)
        role_model = role_model[year+'-01-01':year+'-12-31']
        
        # 穩定股
        # 波動率落在0.006~0.018之間
        s_stocks=self.data.loc[(self.data['v']>=self.v[0])&(self.data['v']<self.v[1])]
        # 本益比落在10~20之間
        s_stocks = s_stocks.loc[(s_stocks['PE']>=self.pe[0])&(s_stocks['PE']<=self.pe[1])]
        # 營收成長大於-0.1
        s_stocks = s_stocks.loc[s_stocks['revenueGrowth']>-self.rg]
        # 營運現金流大於0
        s_stocks = s_stocks.loc[s_stocks['operatingCashflow']>self.oc]
        # 自由現金流大於0
        s_stocks = s_stocks.loc[s_stocks['freeCashflow']>=self.fc]
        # 依照市值大小順序排列
        s_stocks = s_stocks.sort_values('marketValue',ascending=False)
        # print(s_stocks)
        return s_stocks['symbol'][:num].to_list()

    def listening(self):
        pass

class Intraday_WriteOff:
    
    def __init__(self):
        pass

    def listening(self):
        pass

    def plot_k(self):
        pass



    