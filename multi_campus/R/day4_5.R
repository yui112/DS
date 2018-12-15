# 상용분석솔루션 SPSS, SAS 파일 로딩
#############################################################################

## 현재 작업경로 확인
getwd()

## 현재 작업경로에 있는 파일 목록 확인
dir()
list.files()

## 현재 작업경로에 있는 폴더 목록 확인
list.dirs()

## 특정파일 목록만 조회
list.files(pattern = ".sav") 
list.files(pattern = ".sas") 

#############################################################################
## (1) foreign 패키지 이용

install.packages("foreign")
library(foreign)
# - SAS파일 로딩을 위해서는 해당PC에 SAS솔루션이 설치되어 있어야 함 
# - SPSS는 그냥 로딩 가능
# - foreign패키지 사용시 data.frame 형식으로 로딩됨

# ------------------------------------
## SPSS의 .sav 파일 로딩
ex_spss <- read.spss("ex_spss.sav", 
                     to.data.frame = T, 
                     # 데이터프레임형식으로 로딩, F이면 행렬형식으로
                     use.value.labels = FALSE
                     # 각 요소값으로 로딩, T이면 레이블을 로딩
) 

# ------------------------------------
## 간단내용 & 구조 조회
install.packages("psych")
library(psych)                     
psych::headTail(ex_spss)  

str(ex_spss)
class(ex_spss); mode(ex_spss)

library(dplyr)
glimpse(ex_spss)

#############################################################################
## (2) sas7bdat 패키지 이용

list.files(pattern = ".sas") # .sas 관련 파일 목록만 조회

## SAS가 PC에 설치되어 있지않아도 SAS파일 로딩이 가능한 전용 패키지 인스톨
install.packages("sas7bdat")
library(sas7bdat)

ex_sas <- read.sas7bdat("ex_sas.sas7bdat")

# ------------------------------------
## 간단내용 & 구조 조회
library(psych)                     
psych::headTail(ex_sas)  

str(ex_sas)
class(ex_sas); mode(ex_sas)

library(dplyr)
glimpse(ex_sas)

#############################################################################
## (2) 최신 haven패키지 사용

## haven 패키지 인스톨 & 로딩
# install.packages("haven")
library(haven)

# ------------------------------------
## spss의 .sav 파일로딩
spss_hv <- read_sav("ex_spss.sav")
spss_hv2 <- read_spss("ex_spss.sav")

identical(spss_hv, spss_hv2)

## 간단내용 & 구조 조회
library(psych)                     
psych::headTail(spss_hv)  

str(spss_hv)
class(spss_hv); mode(spss_hv)

library(dplyr)
glimpse(spss_hv)

# ------------------------------------
## sas의 .sas7bdat 파일로딩
sas_hv <- read_sas("ex_sas.sas7bdat")

## 간단내용 & 구조 조회
library(psych)                     
psych::headTail(sas_hv)  

str(sas_hv)
class(sas_hv); mode(sas_hv)

library(dplyr)
glimpse(sas_hv)

### End of Source ###########################################################