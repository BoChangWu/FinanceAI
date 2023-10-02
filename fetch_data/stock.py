import requests
import numpy as np
import pandas as pd
import yfinance as yf
# from datetime import datetime
from bs4 import BeautifulSoup
from pylab import plt,mpl
from selenium import webdriver
from selenium.common.exceptions import TimeoutException
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from time import sleep
# os.environ['PYTHONHASHSEED'] = '0'
plt.style.use('seaborn')
mpl.rcParams['savefig.dpi'] = 300
mpl.rcParams['font.family'] = 'serif' 

class Stock:
    def __init__(self,symbol):
        
        self.symbol = symbol
        self.ticker = yf.Ticker(symbol)

    # *** 以下為理解Ticker attributes 所建立，可以直接使用Ticker裡面的Attribute ***
    def _history(self) -> pd.DataFrame:
        '''
        歷史資交易資訊
        '''

        return self.ticker.history(period='max')
    
    def _history_metadata(self) -> dict:

        return self.ticker.history_metadata
    
    def _dividends(self) -> pd.DataFrame:
        '''
        股息
        '''
        
        return pd.DataFrame(self.ticker.actions['Dividends'])
    
    def _stock_splits(self) -> pd.DataFrame:
        '''
        股票分割紀錄
        '''
        return pd.DataFrame(self.ticker.actions['Stock Splits'])
    
    def _capital_gains(self) -> list:
        '''
        資本利得
        etf 或 基金才有
        '''
        return self.ticker.capital_gains
    
    def _share_counts(self) -> pd.DataFrame:
        '''
        發放股數紀錄
        '''
        date = str(self.ticker.history(period='max').index[0])[:10]
        return self.ticker.get_shares_full(start=date)
    
    def _income_stmt(self) -> pd.DataFrame:
        '''
        收益表/損益表
        '''
        return self.ticker.income_stmt
    
    def _balance_sheet(self) -> pd.DataFrame:
        '''
        資產負債表
        '''
        return self.ticker.balance_sheet
    
    def _major_holders(self) -> pd.DataFrame:
        '''
        持有狀況
        '''
        return self.ticker.major_holders
    
    def _earnings_dates(self) -> pd.DataFrame:
        '''
        收益日
        '''
        return self.ticker.earnings_dates
    
    def _isin(self) -> str:
        '''
        國際證券識別編碼(ISIN)
        '''
        return self.ticker.isin
    
    # *************************************************************************
    
    def news(self):
        '''
        抓取新聞資訊
        '''
        headers = {
            'user-agent': "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36"
        }
        options = webdriver.ChromeOptions()
        options.add_argument("--start-maximized")
        options.add_argument("--incognito")
        options.add_argument("--disable-popup-blocking ")

        driver = webdriver.Chrome(options=options)
        titles = []
        urls = []
        dates = []
        df = pd.DataFrame()
        
        # Crawl
        # Visit
        driver.get(f'https://tw.stock.yahoo.com/quote/{self.symbol}')

        # Scroll
        innerHeightOfWindow = 0
        totalOffset = 0
        
        while totalOffset <= innerHeightOfWindow:
            totalOffset += 300
            js_scroll = '''(
                function (){{
                    window.scrollTo({{
                        top:{}, 
                        behavior: 'smooth' 
                    }});
                }})();'''.format(totalOffset)
            
            driver.execute_script(js_scroll)
            
            sleep(1)
            
            innerHeightOfWindow = driver.execute_script(
                'return window.document.documentElement.scrollHeight;'
            )
            
            sleep(1)
            
            print("innerHeightOfWindow: {}, totalOffset: {}".format(innerHeightOfWindow, totalOffset))
        
        # Get url
        news_div = driver.find_elements(
        By.CSS_SELECTOR,"div.Cf")

        for element in news_div:
            print("="*30)
            
            # print(element.text)
            news = element.find_elements(By.TAG_NAME,"h3")
            
            
            for n in news:
                link = n.find_element(By.TAG_NAME,"a")
                a = link.get_attribute('href')
                
                
                if  'beap.gemini' not in a:
                    print(a)
                    urls.append(a) 

        # Get title,date
        for url in urls:
            res = requests.get(url,headers=headers)

            soup = BeautifulSoup(res.text)

            title = soup.find("h1",{"data-test-locator":"headline"})
            titles.append(title.text)
            date_data = soup.find("div",{"class":"caas-attr-time-style"})
            date_time = date_data.find("time")
            date = date_time.attrs['datetime'].split('T')[0]
            dates.append(date)    
        
        # To DataFrame
        df['title'] = titles
        df['url'] = urls
        df['date'] = dates
    
        # Save CSV 
        df.to_csv(f'{self.symbol[:4]+self.symbol[5:]}_news.csv')
    
        # Close driver
        driver.quit()

    def history_close(self) -> pd.DataFrame:
        '''
        回傳收盤價
        視覺化走勢圖、技術分析、機器學習等功能會使用
        '''
        return pd.DataFrame(self._history()['Close'])
    
    def plot_price_trend(self):
        '''
        視覺化歷史走勢
        '''
        self.history_close().plot()