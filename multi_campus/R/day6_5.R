###############################################################################
## dplyr패키지를 활용한 데이터다루기: 변수변환/리코딩으로 요약/파생변수 만들기
# - mutate(), recode(), if_else()
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
## 데이터셋에 변수간 연산을 통한 새로운 변수컬럼을 추가(mutate)하기
# - 데이터셋에 들어 있는 변수컬럼이나 별도의 데이터를 활용해 
#   새로운 변수컬럼(요약변수, 파생변수)을 만들어 추가함 

# ------------------------------------------------------
## 1캐럿당 가격($)에 대한 별도 변수컬럼 추가 

## 기본 달러$ 또는 대괄호[] 연산자 사용 필터링 방식
diamonds$ppc <- diamonds$price / diamonds$carat 
diamonds

## dplyr::mutate() 기능함수 이용방식
diamonds <- mutate(diamonds, ppc2 = price/carat)
diamonds

diamonds %<>% mutate(ppc3 = price/carat)
diamonds
# - 양방향/할당 파이프연산자 %<>% 이용

###############################################################################
## 연속변수 구간범위지정을 통한 변수리코딩으로 새로운 변수컬럼 추가(mutate) 하기

## 연속변수 변수리코딩을 위한 간단 데이터셋 준비
data("diamonds")
dd <- select(diamonds, carat, cut)

dd
summary(dd$carat)
# - dd데이터셋에 있는 carat 변수컬럼을 적당한 구간으로 변수리코딩할 예정
# -  carat의 값이 1.0이하이면 --> low로 리코딩
# -  carat의 값이 1.0보다 크고, 3.0보다 이하이면 --> middle로 리코딩
# -  carat의 값이 3.0보다 크면 --> high로 리코딩

# ------------------------------------------------------
## 기본 달러$ 또는 대괄호[] 연산자 사용 변수리코딩
dd$cr.grd[dd$carat <= 1.0] <- "low" 
dd$cr.grd[dd$carat > 1.0 & dd$carat <= 3.0] <- "middle" 
dd$cr.grd[dd$carat > 3.0] <- "high" 

dd # 추가된 파생변수 확인
table(dd$cr.grd, useNA = "always")
# - useNA="always" 옵션을 통해서 결측치(NA) 항목도 빈도테이블에 나옴

# ------------------------------------------------------
## base::cut() 함수이용 변수리코딩

dd$cr.grd2 <- cut(dd$carat,
                  breaks = c(-Inf, 1, 3, Inf),
                  include.lowest = FALSE, right = TRUE, 
                  labels = c("low", "middle", "high")) 

dd # 추가된 파생변수 확인
table(dd$cr.grd, useNA = "always")
table(dd$cr.grd2, useNA = "always")
# - useNA="always" 옵션을 통해서 결측치(NA) 항목도 빈도테이블에 나옴

# ------------------------------------------------------
## dplyr::mutate() 기능함수 이용 변수리코딩
dd %<>% mutate(cr.grd3 = cut(dd$carat,
                             breaks = c(-Inf, 1, 3, Inf),
                             include.lowest = FALSE, right = TRUE, 
                             labels = c("low", "middle", "high")
)
)
library(magrittr)
dd # 추가된 파생변수 확인
table(dd$cr.grd, useNA = "ifany")
table(dd$cr.grd2, useNA = "ifany")
table(dd$cr.grd3, useNA = "ifany")
# - useNA="ifany" 옵션을 통해서 결측치(NA) 항목이 존재하면 빈도테이블에 나오며,
#   결측치(NA) 항목이 존재하지 않으면 빈도테이블에 나오지 않음

###############################################################################
## 범주형변수 항목선택을 통한 변수리코딩으로 새로운 변수컬럼 추가(mutate) 하기

## 연속변수 변수리코딩을 위한 간단 데이터셋 준비
data("diamonds")
dd <- select(diamonds, carat, cut)

dd
table(dd$cut)
summary(dd$cut)
# - dd데이터셋에 있는 cut 변수컬럼 범주항목들을 적당히 묶어서 변수리코딩
# -  cut의 값이 Fair, Good, Very Good이면 --> Normal로 리코딩
# -  cut의 값이 Premium     Ideal이면 --> Special로 리코딩

# ------------------------------------------------------
## 기본 달러$ 또는 대괄호[] 연산자 사용 변수리코딩
dd$cut.grd[dd$cut %in% c("Fair", "Good", "Very Good")] <- "Normal" 
dd$cut.grd[dd$cut %in% c("Premium", "Ideal")] <- "Special" 

dd # 추가된 파생변수 확인
table(dd$cut.grd, useNA = "always")
# - useNA="always" 옵션을 통해서 결측치(NA) 항목도 빈도테이블에 나옴

# ------------------------------------------------------
## car::recode() 함수이용 변수리코딩
install.packages("car")
library(car)

dd$cut.grd2 <- car::recode(dd$cut, 
                           "c('Fair', 'Good', 'Very Good')='Normal'; 
                           c('Premium', 'Ideal')='Special'"
)

dd # 추가된 파생변수 확인
table(dd$cut.grd, useNA = "always")
table(dd$cut.grd2, useNA = "always")
# - useNA="always" 옵션을 통해서 결측치(NA) 항목도 빈도테이블에 나옴

# ------------------------------------------------------
## doBy::recodeVar() 함수이용 변수리코딩
# install.packages("doBy")
library(doBy)

dd$cut.grd3 <- recodeVar(dd$cut, 
                         src=list(c("Fair", "Good", "Very Good"),
                                  c("Premium", "Ideal")), 
                         tgt=list("Normal","Special"))


dd # 추가된 파생변수 확인
table(dd$cut.grd, useNA = "always")
table(dd$cut.grd2, useNA = "always")
table(dd$cut.grd3, useNA = "always")
# - useNA="always" 옵션을 통해서 결측치(NA) 항목도 빈도테이블에 나옴

# ------------------------------------------------------
## dplyr::mutate() + dplyr::recode() 기능함수 이용 변수리코딩
dd %<>% mutate(cut.grd4 = dplyr::recode(dd$cut, 
                                        "Fair" = "Normal",
                                        "Good" = "Normal",
                                        "Very Good" = "Normal",
                                        "Premium" = "Special",
                                        "Ideal" = "Special"
)
)

dd # 추가된 파생변수 확인
table(dd$cut.grd, useNA = "ifany")
table(dd$cut.grd2, useNA = "ifany")
table(dd$cut.grd3, useNA = "ifany")
table(dd$cut.grd4, useNA = "ifany")
# - useNA="ifany" 옵션을 통해서 결측치(NA) 항목이 존재하면 빈도테이블에 나오며,
#   결측치(NA) 항목이 존재하지 않으면 빈도테이블에 나오지 않음

# ------------------------------------------------------
## dplyr::mutate() + dplyr::if_else() 기능함수 이용 변수리코딩
dd %<>% mutate(cut.grd5 = 
                 if_else(dd$cut %in% c("Fair", "Good", "Very Good"),
                         "Normal", "Special"
                 )
)

dd # 추가된 파생변수 확인
table(dd$cut.grd, useNA = "ifany")
table(dd$cut.grd2, useNA = "ifany")
table(dd$cut.grd3, useNA = "ifany")
table(dd$cut.grd4, useNA = "ifany")
table(dd$cut.grd5, useNA = "ifany")
# - useNA="ifany" 옵션을 통해서 결측치(NA) 항목이 존재하면 빈도테이블에 나오며,
#   결측치(NA) 항목이 존재하지 않으면 빈도테이블에 나오지 않음

### End of Source #############################################################
