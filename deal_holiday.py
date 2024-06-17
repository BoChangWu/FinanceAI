import pandas as pd
from datetime import datetime ,date

# 讀取下載的csv檔案, skiprows 如果是[0,4] 則跳過指定的列, 若 = 6 代表跳過 0-6列 
# utf-8 無法讀檔, 因此使用big5
def deal_holiday():
    x = pd.read_csv('./holidaySchedule_112.csv',encoding='big5',skiprows=[0])

    # 加上年分
    convert_today = date.today().strftime('%Y')


    # 修改 '                日期' 欄位變成 '日期'
    x.rename(columns={'                日期': '日期'},inplace=True)
    print(x)
    # 針對日期apply 將年分加入原先的日期
    x['日期'] = x['日期'].apply(lambda x : convert_today+'年'+x)
    print(x)
    # 把年月日修改成 '/'
    x['日期'] = x['日期'].apply(lambda x: x.replace('年','/'))
    x['日期'] = x['日期'].apply(lambda x: x.replace('月','/'))
    x['日期'] = x['日期'].apply(lambda x: x.replace(' ',''))
    x['日期'] = x['日期'].apply(lambda x: x.replace('"',''))
    x['日期'] = x['日期'].apply(lambda x: x.replace('日',''))
    x['日期'] = x['日期'].apply(lambda x: x[:-2])
    x['日期'] = x['日期'].apply(lambda x: x.replace('(',''))

    # 儲存成excel
    x['日期'].to_csv('./holiday.csv',columns=['日期'])


