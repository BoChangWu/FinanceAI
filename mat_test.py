import matplotlib.pyplot as plt
import yfinance as yf
import pandas_datareader.data as web
import pandas as pd

data = pd.read_csv('./data/stocks/history/2330.csv',index_col=0)
print(data.index)
data = data['2023-01-01':]
plt.ion() # 動態更新開關

class DynamicUpdate():
    #Suppose we know the x range
    min_x = 0
    max_x = len(data['Close'])

    def on_launch(self):
        #Set up plot
        self.figure, self.ax = plt.subplots(figsize=(100,80))
        
        self.lines, = self.ax.plot([],[],'-')
        
        # plt.xticks(data.index.to_list())
        #Autoscale on unknown axis and known lims on the other
        self.ax.set_autoscaley_on(True)
        self.ax.set_xlim(self.min_x, self.max_x)
        #Other stuff
        self.ax.grid()
        ...

    def on_running(self, xdata, ydata,bar_data):
        #Update data (with the new _and_ the old points)
        self.lines.set_xdata(xdata)
        self.lines.set_ydata(ydata)
        self.ax.bar(len(xdata),bar_data/10**6,0.8,0)
        #Need both of these in order to rescale
        self.ax.relim()
        self.ax.autoscale_view()
        #We need to draw *and* flush
        self.figure.canvas.draw()
        self.figure.canvas.flush_events()

    #Example
    def __call__(self):
        import numpy as np
        import time
        self.on_launch()
        xdata = []
        ydata = []
    
        for i in range(len(data['Close'])):
            
            xdata.append(i)
            # print(xdata)
            ydata.append(data.iloc[i]['Close'])
            # print(ydata)
            self.on_running(xdata, ydata,data.iloc[i]['Volume'])
            time.sleep(1)
        return xdata, ydata

d = DynamicUpdate()
d()
plt.ioff()