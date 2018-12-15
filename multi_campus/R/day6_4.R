###############################################################################
## dplyr패키지를 활용한 데이터다루기: 레코드 필터링/슬라이싱
# - filter() & slice()
###############################################################################
# - ggplot2 패키지에 내장된 diamonds 데이터셋 활용

## ggplot2 패키지 설치 및 로딩
# install.packages("ggplot2")
library(ggplot2)

## ggplot2 패키지에 대한 도움말
library(help = ggplot2) # 간단 도움말 뷰어 오픈
help(package = ggplot2) # 알파벳순서 도움말 탭 오픈
data(package = "ggplot2") # 해당 패키지에 들어 있는 예제데이터셋 목록확

## --------------------------------------
## 데이터셋 로딩 & 탐색

data(diamonds)
head(diamonds)

help(diamonds)

## diamonds 코딩북
# 다이아몬드 등급 결정기준 4C: carat, cut, color, clarity
# carat: 무게/순도를 의미함 --> 순금의 1/24을 1캐럿으로 나타냄 
# cut: 커팅품질(다이아몬드의 광채를 결정함) --> Fair, Good, Very Good, Premium, Ideal
# color: 색상 --> J(worst) to D(best)
# clarity: 투명도 --> I1(worst), SI1, SI2, VS1, VS2, VVS1, VVS2, IF(best)

# table: 다이아몬드의 제일 상단 평면의 폭 --> 43 ~ 95
# price: 다이아몬드의 가격 --> $326 ~ $18,823

# x: 길이(mm) 다이아몬드를 위에서 보았을 때 상대적으로 기다란 가로특성 --> 0 ~ 10.74
# y: 폭(mm) 다이아몬드를 위에서 보았을 때 상대적으로 짧은 세로특성 --> 0 ~ 58.9
# z: 깊이(mm) --> 0 ~ 31.8 
#    - 적정한 깊이(빛이 위쪽으로 반사), 너무 높거나 낮은 깊이는 빛반사가 떨어짐
# depth: x(길이mm)와 y(폭mm) 대비 z(깊이mm)의 비율을 계산한 값

# ------------------------------------------------------
## 속도 문제가 있는 경우 10% 정도 샘플링을 통해서 진행
# choice <- sample(1:NROW(diamonds), NROW(diamonds)*0.1, replace = FALSE)
# choice
# NROW(choice)
# diamonds <- diamonds[choice, ]
# ------------------------------------------------------

## 데이터 구조파악 & 기술통계
library(psych)
psych::headTail(diamonds)

library(dplyr)
glimpse(diamonds)

library(Hmisc)
Hmisc::describe(diamonds)

###############################################################################
## 데이터셋에 있는 특정 관찰치를 필터링(filtering)하기
# - 행/로우(row), 관찰치/관측치(observation), 레코드(record), 
#   사례/케이스(case)를 대상으로 
#   조건을 지정해 특정 관찰치를 부분추출함

# ------------------------------------------------------
## (A-1) 특정 일치조건 1개 지정 필터링

## 기본 달러$ 또는 대괄호[] 연산자 사용 필터링 방식
diamonds[diamonds$cut == "Ideal", ] 

## dplyr::filter() 기능함수 이용방식
filter(diamonds, cut == "Ideal")
diamonds %>% filter(cut == "Ideal")

# ------------------------------------------------------
## (A-2) 특정 일치조건 1개 제외 필터링

## 기본 달러$ 또는 대괄호[] 연산자 사용 필터링 방식
diamonds[diamonds$cut != "Ideal", ] 

## dplyr::filter() 기능함수 이용방식
filter(diamonds, cut != "Ideal")
diamonds %>% filter(cut != "Ideal")

# ------------------------------------------------------
## (B-1) 특정 일치조건 2개 지정 필터링

## 기본 달러$ 또는 대괄호[] 연산자 사용 필터링 방식
diamonds[diamonds$cut %in% c("Ideal", "Good"), ] 
diamonds[diamonds$cut == "Ideal" | diamonds$cut == "Good", ] 

## dplyr::filter() 기능함수 이용방식
filter(diamonds, cut %in% c("Ideal", "Good"))
filter(diamonds, cut == "Ideal" | cut == "Good")

diamonds %>% filter(cut %in% c("Ideal", "Good"))
diamonds %>% filter(cut == "Ideal" | cut == "Good")

# ------------------------------------------------------
## (B-2) 특정 일치조건 2개 제외 필터링

## 기본 달러$ 또는 대괄호[] 연산자 사용 필터링 방식
diamonds[diamonds$cut != "Ideal" & diamonds$cut != "Good", ] 

## dplyr::filter() 기능함수 이용방식
filter(diamonds, cut != "Ideal" & cut != "Good")
diamonds %>% filter(cut != "Ideal" & cut != "Good")

# ------------------------------------------------------
## (C-1) 특정 비교조건 1개 지정 필터링

## 기본 달러$ 또는 대괄호[] 연산자 사용 필터링 방식
diamonds[diamonds$price >= 1000, ] 

## dplyr::filter() 기능함수 이용방식
filter(diamonds, price >= 1000)
diamonds %>% filter(price >= 1000)

# ------------------------------------------------------
## (C-2) 특정 비교조건 and 이용 복합조건 지정 필터링

## 기본 달러$ 또는 대괄호[] 연산자 사용 필터링 방식
diamonds[diamonds$carat > 2 & diamonds$price < 14000, ] 

## dplyr::filter() 기능함수 이용방식
filter(diamonds, carat > 2, price < 14000)
filter(diamonds, carat > 2 & price < 14000)

diamonds %>% filter(carat > 2, price < 14000)
diamonds %>% filter(carat > 2 & price < 14000)

# ------------------------------------------------------
## (C-3) 특정 비교조건 or 이용 복합조건 지정 필터링

## 기본 달러$ 또는 대괄호[] 연산자 사용 필터링 방식
diamonds[diamonds$carat < 1 | diamonds$carat > 5, ] 

## dplyr::filter() 기능함수 이용방식
filter(diamonds, carat < 1 | carat > 5)
diamonds %>% filter(carat < 1 | carat > 5)

###############################################################################
## 데이터셋에 있는 특정 관찰치를 슬라이싱(Slicing)하기
# - 행/로우(row), 관찰치/관측치(observation), 레코드(record), 
#   사례/케이스(case)를 대상으로 
#   행번호 범위를 지정해 특정 관찰치를 부분추출함

# ------------------------------------------------------
## (A-1) 특정 일치행 1개범위 지정 슬라이싱

## 기본 달러$ 또는 대괄호[] 연산자 사용 슬라이싱 방식
diamonds[5, ] 

## dplyr::slice() 기능함수 이용방식
slice(diamonds, 5)
diamonds %>% slice(5)

# ------------------------------------------------------
## (A-2) 특정 일치행 1개범위 제외 슬라이싱

## 기본 대괄호[] 연산자 사용 슬라이싱 방식
diamonds[-5, ] 

## dplyr::slice() 기능함수 이용방식
slice(diamonds, -5)
diamonds %>% slice(-5)

# ------------------------------------------------------
## (B-1) 특정 일치행 복수범위 지정 슬라이싱

## 기본 대괄호[] 연산자 사용 슬라이싱 방식
diamonds[c(2, 7, 3:5), ] 

## dplyr::slice() 기능함수 이용방식
slice(diamonds, c(2, 7, 3:5))
diamonds %>% slice(c(2, 7, 3:5))

# ------------------------------------------------------
## (B-2) 특정 일치행 복수범위 제외 슬라이싱

## 기본 대괄호[] 연산자 사용 슬라이싱 방식
diamonds[-c(2, 7, 3:5), ] 

## dplyr::slice() 기능함수 이용방식
slice(diamonds, -c(2, 7, 3:5))
diamonds %>% slice(-c(2, 7, 3:5))

### End of Source #############################################################




