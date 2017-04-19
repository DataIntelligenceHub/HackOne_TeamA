#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Apr 19 12:30:40 2017

@author: abdullah
"""
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score
from ml_metrics import quadratic_weighted_kappa
from sklearn.ensemble import GradientBoostingClassifier, GradientBoostingRegressor
#%%
# load data
dataset = pd.read_csv("/media/sf_windows_share/Documents/LI/train/CleanData.csv",index_col=0)
#dataset.dropna(how='any',thresh=len(list(dataset))/4,inplace=True)
dataset.fillna(-1, inplace=True)
#%%_col_
# split data into X and y
X = dataset
Y = dataset.loc[:,['Response']]
X=pd.get_dummies(X,'Product_Info_2')
X.drop(['Response','Medical_History_30','Id'],axis=1,inplace=True)
#%%
# split data into train and test sets
seed = 6
test_size = 0.20
X_train, X_test, y_train, y_test = train_test_split(X, Y, test_size=test_size, random_state=seed)
y_test=pd.to_numeric(y_test.Response,errors='coerce')
# fit model no training data
model = GradientBoostingRegressor(max_depth=8, learning_rate=0.1,
                     subsample=0.6,n_estimators=150)#min_child_weight=35, silent=True,missing=-1,colsample_bytree=0.3 
model.fit(X_train, y_train)
# make predictions for test data
y_pred = model.predict(X_test)
predictions = [round(value) for value in y_pred]
# evaluate predictions
accuracy = accuracy_score(y_test, predictions)
kappa = quadratic_weighted_kappa(y_test, predictions)
print("Accuracy: %.2f%%" % (accuracy * 100.0))
print("kappa: %.2f%%" % (kappa * 100.0))
