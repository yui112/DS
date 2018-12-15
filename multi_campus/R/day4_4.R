#############################################################################
### Excel 파일 로딩 
#############################################################################

## 현재 작업경로 확인
getwd()

## 현재 작업경로에 있는 파일 목록 확인
dir()
list.files()

## 현재 작업경로에 있는 폴더 목록 확인
list.dirs()

## 엑셀파일 목록만 조회
list.files(pattern = ".xlsx") 

# ------------------------------------
## 엑셀로딩용 최신 패키지 설치
install.packages("readxl")
library(readxl)
# - 기존의 xlsx, XLConnect 패키지는 자바기반으로 만들어져 있어
#   패키지 설치와 로딩, 실제 엑셀파일 로딩시 에러가 많이 발생함

# ------------------------------------
## 엑셀파일에 존재하는 시트명 조회
excel_sheets("adult.xlsx")

#############################################################################
## (1) adult_header_yes시트 로딩
# - 엑셀시트 1번째 행이 변수컬럼으로 구성되어
#   raw데이터가 2번째 행부터 시작되는 경우

## 목표시트 로딩
ad.xl <- read_excel(path = "adult.xlsx", sheet = "adult_header_yes",
                    col_names = TRUE, 
                    trim_ws = TRUE, 
                    na = c("", "?"))

# ------------------------------------
## 내부구조파악
str(ad.xl)
class(ad.xl); mode(ad.xl)
# - readr::read_excel() 함수로 로딩시 최신 데이터셋 포맷인
#   tibble(tbl_df, tbl) 형식과 기존 포맷인 data.frame형태로 로딩됨

library(dplyr)
glimpse(ad.xl)

# ------------------------------------
## 전체내용 조회
ad.xl
# - ad.xl에 들어 있는 데이터포맷이 tibble형식이라 
#   콘솔창 범위만큼 변수가 출력되고, 레코드도 10개로 출력됨

## 간단내용 조회
head(ad.xl)
tail(ad.xl)

library(psych)
headTail(ad.xl)

#############################################################################
## (2) audlt_header_no시트 로딩
# - 엑셀시트 1번째 행에 변수컬럼이 없고 
#   raw데이터부터 시작되는 경우

## 목표시트 로딩
ad.xl.nohd <- read_excel(path = "adult.xlsx", sheet = "adult_header_no",
                         col_names = FALSE, 
                         trim_ws = TRUE, 
                         na = c("", "?"))

# ------------------------------------
## 내부구조파악
str(ad.xl.nohd)
# - readr::read_excel() 함수로 로딩시 최신 데이터셋 포맷인
#   tibble(tbl_df, tbl) 형식과 기존 포맷인 data.frame형태로 로딩됨

library(dplyr)
glimpse(ad.xl)

##################################################
## 1) 기본 base 패키지에 있는 함수이용 변수명 작성 & 변경
# - base::names(), base::colnames() 둘다 사용가능

## 전체변수명 일괄변경
names(ad.xl.nohd)
names(ad.xl.nohd) <- c("age", "workclass", "fnlwgt", "education", 
                       "education-num", "marital-status", "occupation", 
                       "relationship", "race", "sex", "capital-gain", 
                       "capital-loss", "hours-per-week", "native-country", 
                       "income")
# - 임시변수의 순서와 새로운 변수명의 순서가 일치되어야 함

str(ad.xl.nohd)

## 일부 변수명 변경
names(ad.xl.nohd)[c(2, 4)] <- c("wclass", "edu")
str(ad.xl.nohd)

##################################################
## 2) 최신 패키지 사용 함수이용 변수명 작성 & 변경

## header가 없는 시트 재로딩
ad.xl.nohd <- read_excel(path = "adult.xlsx", sheet = "adult_header_no",
                         col_names = FALSE, 
                         trim_ws = TRUE, 
                         na = c("", "?"))

str(ad.xl.nohd)

# ------------------------------------
## dplyr 패키지의 rename()을 이용한 변수컬럼 변경
# install.packages("dplyr")
library(dplyr)
# - 변수변환 코딩시 New Column = Old Column 구조이며, 
#   기본적으로 따옴표와 c()함수 사용이 불필요함

# ------------------------------------
## 전체변수명 일괄변경
ad.xl.nohd <- dplyr::rename(ad.xl.nohd, 
                            age = X__1, 
                            workclass = X__2, 
                            fnlwgt = X__3, 
                            education = X__4,  
                            "education-num" = X__5, 
                            "marital-status" = X__6, 
                            occupation = X__7, 
                            relationship = X__8, 
                            race = X__9, 
                            sex = X__10, 
                            "capital-gain" = X__11,
                            "capital-loss" = X__12, 
                            "hours-per-week" = X__13, 
                            "native-country" = X__14, 
                            income = X__15)

str(ad.xl.nohd)

# ------------------------------------
## 일부 변수명 변경
ad.xl.nohd <- dplyr::rename(ad.xl.nohd, edu = education)
ad.xl.nohd <- dplyr::rename(ad.xl.nohd, edu_num = "education-num") 
# 변수명 중에 대시(-)기호를 사용한 것이 있어서 따옴표로 묶어줌

str(ad.xl.nohd) # 내부구조정보로 변수컬럼명 변경내용 확인

# ------------------------------------
## 2개 이상의 변수컬럼에 대해 동시에 변수컬럼명 변경
ad.xl.nohd <- dplyr::rename(ad.xl.nohd, 
                            relate = relationship,
                            "h-per-w" = "hours-per-week",
                            nt_country = "native-country",
                            Salary.level = "income")

names(ad.xl.nohd) # names() 함수로 변수컬럼명 변경내용 확인
str(ad.xl.nohd) # 내부구조정보로 변수컬럼명 변경내용 확인

#############################################################################
## (3) adult_comment 시트 로딩
# - 실제 raw데이터 주변에 관련 설명이나 다른 내용들이 존재해
#   raw데이터 로딩범위를 별도로 지정해 주어야 하는 경우

## 목표시트 로딩
ad.xl.cmt <- read_excel(path = "adult.xlsx", sheet = "adult_comment",
                        col_names = TRUE, 
                        trim_ws = TRUE, 
                        na = c("", "?"),
                        range = "C4:Q32565")

# ------------------------------------
## 내부구조파악
str(ad.xl.cmt)
# - readr::read_excel() 함수로 로딩시 최신 데이터셋 포맷인
#   tibble(tbl_df, tbl) 형식과 기존 포맷인 data.frame형태로 로딩됨

library(dplyr)
glimpse(ad.xl.cmt)

### End of Source ###########################################################