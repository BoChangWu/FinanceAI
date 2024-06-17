from datetime import datetime
import time
'''
更新各種class
'''

class Update_Machine():

    def __init__(self,per_second=None,per_hour=None,daily=None,monthly=None,yearly=None):
        
        # 要更新的按照頻率放入以下變數
        self.per_second = per_second
        self.per_hour = per_hour
        self.daily = daily
        self.monthly = monthly
        self.yearly = yearly
    
    def daily_listening(self,update_time:datetime):
        
        if self.daily:
            while True:
                _date = datetime.now()
                if _date.hour == update_time.hour and _date.minute == update_time.minute and _date.second == update_time.second:
                    
                    for d in self.daily:
                        d.daily_data(_date)

                print('listening..',end='\r')
                time.sleep(10)

    
    def per_second_listening(self):

        if self.per_second:
            while True:
                _date = datetime.now()
                    
                for s in self.per_second:
                    s.listening()

                print('listening..',end='\r')
                time.sleep(1)