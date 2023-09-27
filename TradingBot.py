import random
import numpy as np
import pandas as pd
import tensorflow as tf
from pylab import plt,mpl
plt.style.use('seaborn')
mpl.rcParams['savefig.dpi'] = 300
mpl.rcParams['font.family'] = 'serif' 
from collections import deque
from tensorflow.keras.layers import Dense,Dropout,LSTM
from tensorflow.keras.models import Sequential
from tensorflow.keras.optimizers import Adam,RMSprop
from environment import FinanceStock
from sklearn.metrics import accuracy_score



def set_seeds(seed=100):
    random.seed(seed)
    np.random.seed(seed)
    tf.random.set_seed(seed)

class TradingBot:
    def __init__(self,learn_env,valid_env=None,val=True,hidden_units=24,
                 hidden_layers=1,learning_rate=0.001,dropout=False):
        self.learn_env = learn_env
        self.valid_env = valid_env
        self.val = val
        self.epsilon = 1.0
        self.epsilon_min = 0.1
        self.epsilon_decay = 0.99
        self.learning_rate = learning_rate
        self.gamma = 0.5
        self.batch_size = 128
        self.max_treward = 0
        self.averages = list()
        self.trewards = list()
        self.performances = list()
        self.aperformances = list()
        self.vperformances = list()
        self.memory = deque(maxlen=200)
        self.train_histories = list()
        self.model = self._build_model(hidden_units,hidden_layers,learning_rate,dropout)


    def _build_model(self,hu,hl,lr,dropout):
        '''
        根據參數建立模型(DNN)
        '''
        model = Sequential()
        model.add(Dense(hu,input_shape=(self.learn_env.lags,self.learn_env.n_features),activation='relu'))
        if dropout:
            model.add(Dropout(0.3,seed=100))
        
        for _ in range(hl):
            model.add(Dense(hu,activation='relu'))
            if dropout:
                model.add(Dropout(0.3,seed=100))

        model.add(Dense(2,activation='linear'))
        model.compile(loss='mse',optimizer=RMSprop)
        return model
    
    def act(self,state):
        '''
        依 a) 探索, b) 利用 而採取行動
        '''
        if random.random() <= self.epsilon:
            return self.learn_env.action_space.sample()
        
        action = self.model.predict(state)[0,0]
        return np.argmax(action)
    
    def replay(self):
        '''
        以批量的記憶經驗重新訓練DNN模型的方法
        '''
        batch = random.sample(self.memory,self.batch_size)

        for state,action,reward,next_state,done in batch:
            if not done:
                reward += self.gamma * np.amax(self.model.predict(next_state)[0,0])
            target = self.model.predict(state)
            target[0,0,action] = reward
            h = self.model.fit(state,target,epochs=1,verbose=False)
            self.train_histories.append(h)
        
        if self.epsilon > self.epsilon_min:
            self.epsilon *= self.epsilon_decay

    def learn(self,episodes):
        '''
        訓練DQL代理人
        '''
        for e in range(1,episodes+1):
            state = self.learn_env.reset()
            state = np.reshape(state,[1,self.learn_env.lags,self.learn_env.n_features])

            for _ in range(10000):
                action = self.act(state)
                next_state,reward,done,info = self.learn_env.step(action)
                next_state = np.reshape(next_state,[1,self.learn_env.lags,self.learn_env.n_features])
                self.memory.append([state,action,reward,next_state,done])
                
                state = next_state

                if done:
                    treward = _ + 1
                    self.trewards.append(treward)
                    av = sum(self.trewards[-25:]) / 25
                    perf = self.learn_env.performance
                    self.averages.append(av)
                    self.performances.append(perf)
                    self.aperformances.append(sum(self.performances[-25:]) / 25)
                    self.max_treward = max(self.max_treward,treward)

                    templ = 'episode: {:2d}/{} | treward: {:4d} | perf: {:5.3f} | av: {:5.1f} | max: {:4d}'
                    print(templ.format(e,episodes,treward,perf,av,self.max_treward))
                    break
        
        if self.val:
            self.validate(e,episodes)
        if len(self.memory) > self.batch_size:
            self.replay()

    def validate(self,e,episodes):
        '''
        驗證DQL代理人
        '''
        state = self.valid_env.reset()
        state = np.reshape(state,[1,self.valid_env.lags,self.valid_env.n_features])

        for _ in range(10000):
            action = np.argmax(self.model.predict(state)[0,0])
            next_state,reward,done,info = self.valid_env.step(action)
            state = np.reshape(next_state,[1,self.valid_env.lags,self.valid_env.n_features])

            if done:
                treward = _ + 1
                perf = self.valid_env.performance
                self.vperformances.append(perf)

                if e % int(episodes / 6) == 0:
                    templ = 71*'='
                    templ = '\n episode: {:2d}/{} | VALIDATION | treward: {:4d} | perf: {:5.3f} | eps: {:.2f}\n'
                    templ += 71*'='
                    print(templ.format(e,episodes,treward,perf,self.epsilon))

                break

def plot_treward(agent):
    '''
    視覺化每個訓練episode總獎勵
    '''
    plt.figure(figsize=(10,6))
    x = range(1,len(agent.averages)+1)
    y = np.polyval(np.polyfit(x,agent.averages,deg=3),x)
    plt.plot(x,agent.averages,label='moving average')
    plt.plot(x,y,'r--',labl='regression')
    plt.xlabel('episodes')
    plt.ylabel('total reward')
    plt.legend()

def plot_performance(agent):
    '''
    視覺化每個episode金融毛績效
    '''
    plt.figure(figsize=(10,6))
    x = range(1,len(agent.performances)+1)
    y = np.polyval(np.polyfit(x,agent.performances,deg=3),x)
    plt.plot(x,agent.performances[:],label='training')
    plt.plot(x,y,'r--',label='regression (train)')

    if agent.val:
        y_ = np.polyval(np.polyfit(x,agent.vperformances,deg=3),x)
        plt.plot(x,agent.vperfomances[:],label='validation')
        plt.plot(x,y_,'r--',label='regression (valid)')

    plt.xlabel('episodes')
    plt.ylabel('gross performance')
    plt.legend()
    
