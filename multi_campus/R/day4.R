setwd("C:/Rtest")
getwd()
#############################################################################
### 일반 Plain Text 파일 로딩
# - header가 없는 경우, 데이터셋 이외에 별도 설명문구가 들어 있는 경우
#############################################################################

## (1) 기본 패키지 활용 로딩방식
# - base패키지 중의 하나인 utils패키지에 속한 
#   read.csv()나 read.table() 함수를 이용해
#   .csv, .txt 파일을 data.frame 형식으로 로딩함 

## 기본 로딩
ad.df.nohd <- read.csv(file = "adult_noheader.csv", 
                       header = FALSE, sep = ",",
                       stringsAsFactors = FALSE, 
                       strip.white = TRUE,
                       na.strings = c("", "?"),
                       skip = 3)
# - adult_noheader.csv 파일에는 상단에 2줄정도 데이터셋 설명이 있고
#   3번째줄은 공백라인, 4번째 줄부터 헤더없이 데이터가 나옴
# - header = FALSE, skip = 3이라는 옵션사용
library(dplyr)
glimpse(ad.df.nohd)

# - header가 없는 파일 로딩시 V1 ~ V15까지 임시변수명을 붙여줌

#############################################################################
## (2) 최신 readr 패키지 활용 로딩방식
# - read_csv(), read_delim() 함수를 이용해 
#   .csv, .txt 파일을 tibble(tble_df, tbl) 형식과 data.frame 형식으로 로딩함

## 필요 패키지 설치
# install.packages("readr")
library(readr)

# ------------------------------------
## readr::read_delim() 함수 이용
ad.tb.nohd <- read_delim(file = "adult_noheader.csv", 
                         col_names = FALSE, delim = ",",
                         trim_ws = TRUE,
                         na = c("", "?"),
                         skip = 3) 
glimpse(ad.tb.nohd)
# - header가 없을 때 V가 아닌 X1 ~ X15까지 임시변수명을 붙여줌

# ------------------------------------
## readr::read_csv() 함수 이용
ad.tb.nohd <- read_csv(file = "adult_noheader.csv", col_names = FALSE,
                       trim_ws = TRUE,
                       na = c("", "?"),
                       skip = 3)
glimpse(ad.tb.nohd)
# - header가 없을 때 V가 아닌 X1 ~ X15까지 임시변수명을 붙여줌

#############################################################################
## (3) 최신 data.table 패키지 활용 로딩방식
# - fread() 함수를 이용해 
#   .csv, .txt 파일을 data.table 형식과 data.frame 형식으로 로딩함

## 필요 패키지 설치
# install.packages("data.table")
library(data.table)

# ------------------------------------
# data.tabble::fread() 함수 이용
ad.dt.nohd <- fread(input = "adult_noheader.csv", header = FALSE, sep = ",", 
                    stringsAsFactors = FALSE, 
                    strip.white = TRUE, 
                    na.strings = c("", "?"),
                    skip = 3)

glimpse(ad.dt.nohd)
# - 동일하게 header가 없는 파일 로딩시 V1 ~ V15까지 임시변수명을 붙여줌

#############################################################################
## 변수명 작성 & 변경
# - 앞에서 헤더가 없는채로 로딩한 3개 객체중 
#   tibble 객체형식인 ad.tb.nohd를 이용(3개중 아무거나 사용해도 동일함) 

## (1) 기본 base 패키지에 있는 함수이용 변수명 작성 & 변경
# - base::names(), base::colnames() 둘다 사용가능

## 전체변수명 일괄변경
names(ad.tb.nohd) 
# - 현재 변수명 일괄 조회

names(ad.tb.nohd) <- c("age", "workclass", "fnlwgt", "education", 
                       "education-num", "marital-status", "occupation", 
                       "relationship", "race", "sex", "capital-gain", 
                       "capital-loss", "hours-per-week", "native-country", 
                       "income")
# - 임시변수컬럼의 순서와 새로운 변수컬럼명의 순서가 일치되어야 함

## 일괄반영된 변수컬럼명 확인
names(ad.tb.nohd)
glimpse(ad.tb.nohd)

## 일부 변수명 변경
names(ad.tb.nohd)[c(2, 4)] <- c("wclass", "edu")
# - 원래 변수컬럼의 순서와 새로운 변수컬럼명의 순서가 일치되어야 함

## 일부 변경된 변수컬럼명 확인
names(ad.tb.nohd)
glimpse(ad.tb.nohd)

##################################################
## (2) 최신 패키지 사용 함수이용 변수명 작성 & 변경

## header가 없는 파일 재로딩

## readr::read_csv() 함수 이용
ad.tb.nohd <- read_csv(file = "adult_noheader.csv", col_names = FALSE,
                       trim_ws = TRUE,
                       na = c("", "?"),
                       skip = 3)
glimpse(ad.tb.nohd)
# - header가 없을 때 V가 아닌 X1 ~ X15까지 임시변수명을 붙여

# ------------------------------------
## dplyr 패키지의 rename()을 이용한 변수컬럼 변경
# install.packages("dplyr")
library(dplyr)
# - 변수변환 코딩시 New Column 이름 = Old Column 이름 구조임 
# - 변수컬럼명에 양쪽에 따옴표를 붙이지 않아도 되는데, 변수컬럼명에
#   점(.)이나 언더스코어(_) 기호가 아닌 대시(-) 등이 사용될 때에는
#   따옴표로 묶어 주어야 함
# - 2개이상 변수를 동시에 변경하더라고 c()함수를 사용하지 않아도 됨

# ------------------------------------
## 전체변수명 일괄변경
ad.tb.nohd <- dplyr::rename(ad.tb.nohd, 
                            age = X1, 
                            workclass = X2, 
                            fnlwgt = X3, 
                            education = X4, 
                            "education-num" = X5, 
                            "marital-status" = X6, 
                            occupation = X7, 
                            relationship = X8, 
                            race = X9, 
                            sex = X10, 
                            "capital-gain" = X11,
                            "capital-loss" = X12, 
                            "hours-per-week" = X13, 
                            "native-country" = X14, 
                            income = X15)
# - rename()이라는 함수는 여러패키지에서 사용하는 함수명이라
#   dplyr::rename()으로 명시적으로 코딩하는 것이 좋음

names(ad.tb.nohd)
colnames(ad.tb.nohd)
glimpse(ad.tb.nohd)
# - 변경된 변수컬럼명 확인

# ------------------------------------
## 일부 변수명 변경
ad.tb.nohd <- dplyr::rename(ad.tb.nohd, edu = education)
ad.tb.nohd <- dplyr::rename(ad.tb.nohd, edu_num = "education-num") 
# 변수명 중에 대시(-)기호를 사용한 것이 있어서 따옴표로 묶어줌

names(ad.tb.nohd)
colnames(ad.tb.nohd)
glimpse(ad.tb.nohd)
# - 변경된 변수컬럼명 확인

# ------------------------------------
## 2개 이상의 변수컬럼에 대해 동시에 변수컬럼명 변경
ad.tb.nohd <- dplyr::rename(ad.tb.nohd, 
                            relate = relationship,
                            "h-per-w" = "hours-per-week",
                            nt_country = "native-country",
                            Salary.level = "income")

names(ad.tb.nohd)
colnames(ad.tb.nohd)
glimpse(ad.tb.nohd)
# - 변경된 변수컬럼명 확인

### End of Source ###########################################################

ad.dt.nohd <- dplyr::rename(ad.dt.nohd, 
                            age = V1, 
                            workclass = V2, 
                            fnlwgt = V3, 
                            education = V4, 
                            "education-num" = V5, 
                            "marital-status" = V6, 
                            occupation = V7, 
                            relationship = V8, 
                            race = V9, 
                            sex = V10, 
                            "capital-gain" = V11,
                            "capital-loss" = V12, 
                            "hours-per-week" = V13, 
                            "native-country" = V14, 
                            income = V15)
ad.df.nohd

