"""
handling dataset
making dataset
데이터셋 불러오기
missing data 처리
category 처리
train & test 분리
scaling하기
"""

import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

dataset = pd.read_csv('50_Startups.csv')
X = dataset.iloc[:, :-1].values
y = dataset.iloc[:, 4].values


from sklearn.preprocessing import Imputer
from sklearn.linear_model import LinearRegression

imputer = Imputer(missing_values='NaN', strategy='mean', axis=0)
imputer = imputer.fit(X[:, 1:3])
#X[:, 1:] = imputer.fit(X[:, 1:])
#X[:, 1:] = imputer.transform(X[:, 1:])
X[:, 1:3] = imputer.transform(X[:, 1:3])

from sklearn.preprocessing import LabelEncoder, OneHotEncoder
# 독립변수 전처리
labelEncoder_X = LabelEncoder()
X[:, 3] = labelEncoder_X.fit_transform(X[:, 3])
onehotencoder = OneHotEncoder(categorical_features=[3])
X = onehotencoder.fit_transform(X).toarray()
# 종속변수 전처리
labelEncoder_y = LabelEncoder()
y = labelEncoder_y.fit_transform(y)

#avoiding the dummy variable trap

X = X[:,1:]

#spliting the dataset into the training set and test set

from sklearn.cross_validation import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.2, random_state = 0)

#fitting multiple linear regression to the Train set

#from sklearn.linear_model import LinearRegression

regression = LinearRegression()
regression.fit(X_train, y_train)
y_pred = regression.predict(X_test)

#Building the optimal model using backward Elimination

import statsmodels.formula.api as sm

X = np.append(arr = np.ones((50,1)).astype(int), values = X, axis =1)
X_opt = X[:,[0,1,2,3,4,5]]
regression_OLS = sm.OLS(endog = y, exog = X_opt).fit()
regression_OLS.summary()


















