import pandas as pd
from datetime import datetime, date

def is_open():
    # 規定格式, 年月日間不能有符號

    # 讀取剛剛的休市日期檔ˋ
    hd = pd.read_csv('./holiday.csv')

    # 轉換為list 備用
    hd_date = pd.to_datetime(hd['日期']).to_list()

    # 獲取今天日期
    today = date.today()

    # 將日期轉成字串
    str_date = today.strftime('%Y%m%d')

    # 使用 weekday 函數判斷星期幾
    day = today.weekday()

    if day == 6 or day == 7:
        return False
        

    # Loop 國定假日的 List

    for i in hd_date:
        # 將 Timestamp 類轉為目標日期同樣字串
        i = i.strftime('%Y%m%d')
        # 檢查是否有國定假日跟目標日期一樣, 

    if str_date in hd_date:
        return False
        

    # 'Y' 代表不符合六日也非國定假日,
    else:
        return True

    