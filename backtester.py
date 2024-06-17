import numpy as np
import pandas as pd
from backtestingbase import BacktestingBaseRM

class TBBacktesterRM(BacktestingBaseRM):
    def _reshape(self,state):
        '''
        重塑狀態物件
        '''
        return np.reshape(state,[1,self.env.lags,self.env.n_features])
    
    def backtest_strategy(self,sl=None,tsl=None,tp=None,wait=4,guarantee=False):
        '''
        交易機器人績效的事件式回測
        其中包含停損、追蹤停損與停利
        '''
        self.units = 0
        self.position = 0
        self.trades = 0
        self.sl = sl
        self.tsl = tsl
        self.tp = tp
        self.wait = 0
        self.current_balance = self.initial_amount
        self.net_wealths = list()

        for bar in range(self.env.lags,len(self.env.data)):
            self.wait = max(0,self.wait-1)
            date,price = self.get_date_price(bar)

            if self.trades == 0:
                print(50*'=')
                print(f'{date} | *** START BACKTEST ***')
                self.print_balance(bar)
                print(50*'=')

            # 停損單
            if sl is not None and self.position != 0:
                rc = (price - self.entry_price) / self.entry_price

                if self.position == 1 and rc < -self.sl:

                    print(50*'-')
                    if guarantee:
                        price = self.entry_price * (1 - self.sl)
                        print(f'*** STOP LOSS (LONG | {-self.sl:.4f}) ***')

                    else:
                        print(f'*** STOP LOSS (LONG | {rc:.4f}) ***')

                    self.place_sell_order(bar,units=self.units,gprice=price)
                    self.wait = wait
                    self.position = 0 

                elif self.position == -1 and rc > self.sl:

                    print(50*'-')
                    if guarantee:
                        price = self.entry_price * (1 + self.sl)
                        print(f'*** STOP LOSS (LONG | -{-self.sl:.4f}) ***')

                    else:
                        print(f'*** STOP LOSS (LONG | -{rc:.4f})')

                    self.place_buy_order(bar,units=-self.units,gprice=price)
                    self.wait = wait
                    self.position = 0

            # 追蹤停損單
            if tsl is not None and self.position != 0:
                
                self.max_price = max(self.max_price,price)
                self.min_price = min(self.min_price,price)
                rc_1 = (price - self.max_price) / self.entry_price
                rc_2 = (self.min_price - price) / self.entry_price
                
                if self.position == 1 and rc_1 < -self.tsl:
                    
                    print(50*'-')
                    print(f'*** TRAILING SL (LONG | {rc_1:.4f}) ***')
                    self.place_sell_order(bar,units=self.units)
                    self.wait = wait
                    self.position = 0
                    
                elif self.position == -1 and rc_2 > -self.tsl:
                    
                    print(50*'-')
                    print(f'*** TRAILING SL (LONG | {rc_2:.4f}) ***')
                    self.place_buy_order(bar,units=-self.units)
                    self.wait = wait
                    self.position = 0 
            
            # 停利單
            if tp is not None and self.position != 0:
                
                rc = (price - self.entry_price) / self.entry_price
                
                if self.position == 1 and rc > self.tp:
                    
                    print(50*'-')
                    
                    if guarantee:
                        
                        price = self.entry_price * (1+ self.tp)
                        print(f'*** TAKE PROFIT (LONG | {self.tp:.4f}) ***')
                        
                    else:
                        print(f'*** TAKE PROFIT (LONG | {rc:.4f}) ***')
                        
                    self.place_sell_order(bar,units=self.units,gprice=price)
                    self.wait=wait
                    self.position = 0
                    
                elif self.position == -1 and rc < -self.tp:
                    
                    print(50*'-')
                    
                    if guarantee:
                        
                        price = self.entry_price * (1 - self.tp)
                        print(f'*** TAKE PROFIT (LONG | {self.tp:.4f}) ***')
                        
                    else:
                        print(f'*** TAKE PROFTY (LONG | {-rc:.4f}) ***')
                        
                    self.place_buy_order(bar,units=-self.units,gprice=price)
                    self.wait = wait
                    self.position = 0
            
            state = self.env._get_state(bar)
            action = np.argmax(self.model.predict(self._reshape(state.values))[0,0])
            position = 1 if action == 1 else -1
            
            if self.position in [0,-1] and position == 1 and self.wait == 0 :
                
                if self.verbose:
                    print(50*'-')
                    print(f'{date} | *** GOING LONG ***')
                    
                if self.position == -1:
                    
                    self.place_buy_order(bar-1,units=-self.units)
                    
                self.place_buy_order(bar-1,amount=self.current_balance)
                
                if self.verbose:
                    self.print_net_wealth(bar)
                    
                self.position = 1
                
            elif self.position in [0,1] and position == -1 and wait == 0:
                
                if self.verbose:
                    print(50*'-')
                    print(f'{date} | *** GOING SHORT ***')
                    
                if self.position == 1:
                    self.place_sell_order(bar-1,units=self.units)
                
                self.place_sell_order(bar-1,amount=self.current_balance)
                
                if self.verbose:
                    
                    self.print_net_wealth(bar)
                    
                self.position = -1
            
            self.net_wealths.append((date,self.calculate_net_wealth(price)))
        
        self.net_wealths = pd.DataFrame(self.net_wealths,columns=['date','net_wealth'])
        self.net_wealths.set_index('date',inplace=True)
        self.net_wealths.index = pd.DatetimeIndex(self.net_wealths.index)
        self.close_out(bar)