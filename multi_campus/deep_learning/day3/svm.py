#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Oct  2 13:02:30 2018

@author: yunsungsong
"""

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt


dataset = pd.read_csv('Position_Salaries.csv')
dataset.columns

feature_list = ['Level']
target_name = ['Salary']

X = dataset[feature_list].values
y = dataset[target_name].values

from sklearn.preprocessing import StandardScaler
sc_X = StandardScaler()
sc_y = StandardScaler()
X = sc_X.fit_transform(X)
y = sc_y.fit_transform(y)

from sklearn.svm import SVR
regressor = SVR(kernel= 'rbf')
regressor.fit(X, y)

#Predicting a new result
y_pred = regressor.predict(100)
y_pred = sc_y.inverse_transform(y_pred)

# Visualising the SVR results
plt.scatter(X, y, color = 'red')
plt.plot(X, regressor.predict(X), color ='blue')
plt.title('Truth or Bluff (svr)')
plt.xlabel('position level')
plt.ylabel('salary')
plt.show()

# # Visualising the SVR results (for higher resolution and smother curve)
X_grid = np.arange(min(X), max(X), 0.01)

# choice of 0.01 instead of 0.1 step because the data is feature scaled
X_grid = X_grid.reshape((len(X_grid), 1))
plt.scatter(X, y, color = 'red')
plt.plot(X_grid, regressor.predict(X_grid), color = 'blue')
plt.title('Truth or Bluff(SVR)')
plt.xlabel('position level')
plt.ylabel('salary')
plt.show()























