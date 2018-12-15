#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Oct  1 15:03:46 2018

@author: yunsungsong
"""

import pandas as pd
import numpy as np

dataset = pd.read_csv('50_Startups.csv')
X = dataset.iloc[:, :-1].values
y = dataset.iloc[:, 4].values

from sklearn.preprocessing import LabelEncoder, OneHotEncoder
labelEncoder_X = LabelEncoder()
X[:, 3] = labelEncoder_X.fit_transform(X[:, 3])
onehotencoder = OneHotEncoder(categorical_features=[3])
X = onehotencoder.fit_transform(X).toarray()

X = X[:,1:]

from sklearn.cross_validation import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.2, random_state = 0)

from sklearn.linear_model import LinearRegression

regression = LinearRegression()
regression.fit(X_train, y_train)

y_pred = regression.predict(X_test)

import statsmodels.formula.api as sm

X = np.append(arr = np.ones((50,1)).astype(int), values = X, axis =1)
X_opt = X[:,[0,1,2,3,4,5]]
regression_OLS = sm.OLS(endog = y, exog = X_opt).fit()
regression_OLS.summary()

X = np.append(arr = np.ones((50,1)).astype(int), values = X, axis =1)
X_opt = X[:,[0,1,3,4,5]]
regression_OLS = sm.OLS(endog = y, exog = X_opt).fit()
regression_OLS.summary()

X = np.append(arr = np.ones((50,1)).astype(int), values = X, axis =1)
X_opt = X[:,[0,3,4,5]]
regression_OLS = sm.OLS(endog = y, exog = X_opt).fit()
regression_OLS.summary()


X = np.append(arr = np.ones((50,1)).astype(int), values = X, axis =1)
X_opt = X[:,[0,3,5]]
regression_OLS = sm.OLS(endog = y, exog = X_opt).fit()
regression_OLS.summary()

X = np.append(arr = np.ones((50,1)).astype(int), values = X, axis =1)
X_opt = X[:,[0,3]]
regression_OLS = sm.OLS(endog = y, exog = X_opt).fit()
regression_OLS.summary()