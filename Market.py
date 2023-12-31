import requests
import pandas as pd
from datetime import datetime,timedelta
from .fetch_data.stock import Stock

class Market_Data:
    def __init__(self):
        
        self.tw_stocks= dict()
        self._stocks_list_tw()
        self._to_ticker()
        self._trade_days()

    def _stocks_list_tw(self) -> None:
        '''
        取得台灣股市列表
        '''
        
        res = requests.get("https://isin.twse.com.tw/isin/C_public.jsp?strMode=2",headers=headers)

        self.data = pd.read_html(res.text)

        self.data = self.data[0]

        # 指定 df 的欄位為第一列
        self.data.columns = self.data.iloc[0,:]

        # 拿掉本來的那一列以及都是股票的那一列
        self.data = self.data.iloc[1:,:]

        # 將股票名稱與代號分割開
        self.data['代號'] = self.data['有價證券代號及名稱'].apply(lambda x: x.split()[0])

        self.data['股票名稱'] = self.data['有價證券代號及名稱'].apply(lambda x: x.split()[-1])

        # 利用 to_datetime 把無法轉成datetime 的資料化為Nan
        self.data['上市日'] = pd.to_datetime(self.data['上市日'], errors='coerce')

        # 再把上市日 = Nan 的資料去掉篩選掉非股票的雜質
        # data = data.dropna(sebset = ['上市日'])
        self.data.dropna(subset=['上市日'])

        self.data.dropna(subset=['產業別'])
        # 去掉不需要的欄位
        self.data = self.data.drop(['有價證券代號及名稱','國際證券辨識號碼(ISIN Code)','CFICode','備註'], axis=1)

        # 更換剩餘欄位順序
        self.data = self.data[['代號','股票名稱','上市日','市場別','產業別']]

        self.data = self.data.dropna(subset=['產業別'])
        self.data = self.data[self.data['代號'].str.isdigit()]

    def _to_ticker(self) -> None:

        symbols = self.data['代號'].to_list()

        for symbol in symbols:

            self.tw_stocks[symbol] = Stock(symbol+'.TW')

    def _trade_days(self,set_date=None,choose_type=None) -> None:
        '''
        e.g.
        set_date: '20230526'

        '''
        
        date = datetime.now()
        select_type = 'ALLBUT0999'
        if set_date:
            r_date = set_date
        else:
            r_date = datetime.strftime(date-timedelta(days=1),'%Y%m%d')

        if choose_type:
            r_type = choose_type
        else:
            r_type = select_type

        res = requests.get(f'https://www.twse.com.tw/rwd/zh/fund/T86?response=json&date={r_date}&selectType={r_type}&_=1685065571229')
        results = res.json()

        df = pd.DataFrame(results['data'],columns=results['fields'])

        # print(df)
        df.to_csv(f'./data/TMC_{r_type}_{r_date}.csv')