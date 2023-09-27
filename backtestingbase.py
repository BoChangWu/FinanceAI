
class BacktestingBaseRM:
    def __init__(self,env,model,amount,ptc,ftc,verbose=False):
        # 相關環境
        self.env = env
        # 相關模型
        self.model = model
        # 初始餘額
        self.initial_amount = amount
        # 目前餘額
        self.current_balance = amount
        # 成比例交易成本
        self.ptc = ptc
        # 固定交易成本
        self.ftc = ftc
        # 是否顯示訊息
        self.verbose = verbose
        # 金融工具交易單位的初始值
        self.units = 0
        # 以執行交易筆數的初始值
        self.trades = 0 

    def get_date_price(self,bar):
        '''
        依給定的bar 回傳 date 與 price
        '''
        date = str(self.env.data.index[bar])[:10]
        price = self.env.data[self.env.symbol].iloc[bar]

        return date,price
    
    def print_balance(self,bar):
        '''
        依給定的bar 顯示目前現金餘額
        '''
        date,price = self.get_date_price(bar)
        print(f'{date} | current balance = {self.current_balance:.2f}')

    def calculate_net_wealth(self,price):
        '''
        以目前餘額與金融工具部位計算淨值
        '''
        return self.current_balance + self.units * price
    
    def print_net_wealth(self,bar):
        '''
        依給定的bar 顯示淨值(現金+持有部位)
        '''
        date,price = self.get_date_price(bar)
        net_wealth = self.calculate_net_wealth(price)
        print(f'{date} | net wealth = {net_wealth:.2f}')

    def set_prices(self,price):
        '''
        為績效追蹤而設定價格用以測試
        譬如追蹤停損是否達到
        '''
        # 進場價
        self.entry_price = price
        # 最低初始值
        self.min_price = price
        # 最高初始值
        self.max_price = price

    def place_buy_order(self,bar,amount=None,units=None,gprice=None):
        '''
        依特定的bar 以及 amount 或 units 下單買進
        '''
        date,price = self.get_date_price(bar)

        if gprice is not None:
            price = gprice
        
        if units is None:
            units = int(amount/price)

        self.current_balance -= (1 + self.ptc) * units * price + self.ftc
        self.units += self.units
        self.trades +=1
        self.set_prices(price)

        if self.verbose:
            print(f'{date} | buy {units} units for {price:.4f}')
            self.print_balance(bar)

    def place_sell_order(self,bar,amount=None,units=None,gprice=None):
        '''
        依特定的bar 以及 amount或units 下單賣出
        '''
        date,price = self.get_date_price(bar)

        if gprice is not None:
            price = gprice

        if units is None:
            units = int(amount / price)

        self.current_balance += (1-self.ptc) * units * price - self.ftc
        self.units -= units
        self.trades += 1
        self.set_prices(price)

        if self.verbose:
            print(f'{date} | sell {units} units for {price:.4f}')
            self.print_balance(bar)

    def close_out(self,bar):
        '''
        依給定的bar 將未平倉部位平倉
        '''
        date,price = self.get_date_price(bar)
        print(50*'=')
        print(f'{date} | ***CLOSING OUT***')

        if self.units < 0:
            # 空頭部位平倉
            self.place_buy_order(bar,units=-self.units)
        else:
            # 多頭部位平倉
            self.place_sell_order(bar,units=self.units)

        if self.verbose:
            print(f'{date} | current balance ={self.current_balance:.2f}')

        perf = (self.current_balance / self.initial_amount-1 ) * 100
        print(f'{date} | net performance[%] = {perf:.4f}')
        print(f'{date} | number of trades[#] = {self.trades}')
        print(50*'=')


