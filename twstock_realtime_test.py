import twstock
import pandas as pd
import numpy as np
import requests
from multiprocessing import Process,cpu_count
import time
import matplotlib.pyplot as plt

## 整理stock_list
def clean_stock_list():
    stock_list = pd.read_csv('./data/stock_list.csv')
    print(stock_list)
    stock_list = stock_list.loc[stock_list['代號']<10000]
    print(stock_list)

    droplist = []
    for r in stock_list.iterrows():
        
        # print(type(r[1]))
        if 'KY' in r[1]['股票名稱'] or 'DR' in r[1]['股票名稱']:
            droplist.append(r[0])


    stock_list.drop(index=droplist,inplace=True)
    
    stock_list.to_csv('./data/new_stocks.csv')
    print(stock_list)
## multiprocessing ### 
def func_a(num):

    count = 0

    while count< num:
        count +=1
        print('func_a:',count)

        time.sleep(0.5)


def func_b(num):
    count = 0

    while count < num:
        count +=1
        print('func_b:',count)
        time.sleep(1.0)

def main():
    print(cpu_count())
    a = Process(target=func_a,args=(10000,))
    a.start() # start process a
    

    b = Process(target=func_b,args=(10000,))
    b.start() # start process b

    a.join() # wait until a terminate
    b.join() # wait until b terminate
    
    print('finished in: ',time.perf_counter(),'seconds')

## multiprocessing twstock 即時資訊應用

# stocks_list = ['2330','2886','0050','2379','2367','2383','2392','2430']
total = 4*30
pivot = 120

stocksList= pd.read_csv('./data/new_stocks.csv')['代號'].values.tolist()
# stocks_list = pd.read_csv('./data/new_stocks.csv')['代號'].values.tolist()
backup = list(stocksList)
# print(stocks_list)

stocks = {}
for b in backup:
    if len(str(b))>4:
        print(b)



# print(stocks)
print('Stocks:',len(stocks))

class Realtime:
    def __init__(self,stocklist):
        self.dataf = dict()
        self.stocks = dict()
        self.backup = stocklist
        self.update()
    def transfer_data(self,symbol):

        # 讀取資料
        # print('symbol',symbol)
        
        if self.stocks[symbol]['success'] == False:
            print('not success')
            return 
        
        tmp = pd.DataFrame(self.stocks[symbol])
        tmp = tmp.iloc[5:,2]
        realtime= pd.DataFrame(tmp).T
        realtime.index = [pd.to_datetime(self.stocks[symbol]['info']['time'],format='%Y-%m-%d %H:%M:%S')]
        
        if symbol in self.dataf.keys():
            # print('not firstime')
            # print(list(self.dataf.keys())[0])
            self.dataf[symbol] = pd.concat([self.dataf[symbol],realtime])
        else:
            # print('first time')
            self.dataf[symbol] = realtime
        # print(symbol,'realtime get.')
        
     
    def twstock_origin(self):
        # stocks = twstock.realtime.get(stocks_list)

        for s in list(self.stocks.keys()):
            self.transfer_data(s)

        # print('finished in: ',time.perf_counter(),'seconds')
    
    def update(self):
        self.stocks = dict()
        while len(self.backup)>0:
            tmp,self.backup = self.backup[:pivot],self.backup[pivot:]
            
            temp = twstock.realtime.get([str(s).zfill(4) for s in tmp])
            if temp['success'] == True:
                self.stocks.update(temp)
            else:
                print('Error')

            # print('Stocks:',len(stocks))
            self.stocks.pop('success',None)
            time.sleep(5)

def twstock_main():

    # 平行運算分組
    m_list = np.array(list(stocks.keys()))

    m_list = m_list.reshape((len(stocks_list)//4,4))
    m_list = m_list.tolist()

    
    
    for i in m_list:

        c1 = Process(target=transfer_data,args=(i[0],stocks))
        c2 = Process(target=transfer_data,args=(i[1],stocks))
        c3 = Process(target=transfer_data,args=(i[2],stocks))
        c4 = Process(target=transfer_data,args=(i[3],stocks))

        c1.start()
        c2.start()
        c3.start()
        c4.start()

        c1.join()
        c2.join()
        c3.join()
        c4.join()

    print('finished in: ',time.perf_counter(),'seconds')
    
if __name__ == '__main__':
    
    # main()
    # print(stocks_list)
    answer = Realtime(backup)

    for i in range(3000):
        answer.update()
        answer.twstock_origin()
        print(answer.dataf)   
        time.sleep(60)
    
    # twstock_main()
    # clean_stock_list()
    # print(stocks)


### 結論: 不需要multiproccessing