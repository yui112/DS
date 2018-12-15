#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Oct  1 13:28:57 2018

@author: yunsungsong
"""

linear regression의 조건

1. 선형적
2. 동질성
3. 다변수 정규성
4. 독립성 오차
5. 다공존성의 결여

Building model

1. All in
     - priority knowledge

2. Backward elimination 역방향 제거
    - select a signification level to stay in the model
    - fit the full modelk with all possible predictions
    - consider the predictor with the highest p-values
        if P<sl, go to step 4, otherwise go to fin:
3. remove the predictor
4. fit the model without this variable

 2번과 4번까지는 fit model이 나올때까지 반복한다.
