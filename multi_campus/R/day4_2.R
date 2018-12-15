#############################################################################
### 일반 Plain Text 파일 로딩
# - 온라인 사이트에 존재하는 데이터파일 로딩 
#############################################################################

## 캘리포니아주립대학교 머신러닝 레파지토리 사이트를 이용한 데이터로딩
# the UC Irvine Machine Learning Repository
# http://archive.ics.uci.edu/ml 

## 온라인 데이터셋 주소설정
url <- "http://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data"
# - UCI MLR 사이트내에 adult.data파일이 존재하는 
#   인터넷주소를 문자열변수로 미리준비
# - 해당 온라인 파일은 header가 없는 상태임

#######################################################
## (1) 기본 패키지 활용 로딩방식
# - base패키지 중의 하나인 utils패키지에 속한 
#   read.csv()나 read.table() 함수이용
# - 파일명 자리에 대신에 plain text파일이 존재하는 
#   인터넷 주소를 대신입력함
# - data.frame 형식으로 로딩함 

## 몇가지 옵션사용 로딩
ad.url.df <- read.csv(file = url, header = FALSE, sep = ",",
                      stringsAsFactors = FALSE, 
                      strip.white = TRUE,
                      na.strings = c("", "?"))
str(ad.url.df)
class(ad.url.df); mode(ad.url.df)
# - 3가지 옵션/인수/인자 설정을 통해서 데이터로딩시 발생가능한 문제해결
# - header가 없는 온라인파일 로딩시 V1 ~ V15까지 임시변수명을 붙여줌

#############################################################################
## (2) 최신 readr 패키지 활용 로딩방식
# - read_csv(), read_delim() 함수를 이용해 온라인상에 존재하는  
#   plain text 파일을 tibble(tble_df, tbl) 형식과 data.frame 형식으로 로딩함

## 필요 패키지 설치
# install.packages("readr")
library(readr)

# ------------------------------------
## readr::read_delim() 함수 이용
ad.url.tb <- read_delim(file = url, col_names = FALSE, delim = ",",
                        trim_ws = TRUE,
                        na = c("", "?")) 
glimpse(ad.url.tb)
class(ad.url.tb); mode(ad.url.tb)
# - read_delim() 함수는 delim 옵션을 통해서 요소값을 구별하는 구분기호가
#   콤마(,), 세미콜론(;), 탭(/t) 등인 경우에 로딩이 가능함
# - stringsAsFactors = FALSE 옵션은 아예 별도옵션없이 기본으로 작동함
# - header가 없는 온라인사이트 파일 로딩시 
#   V가 아닌 X1 ~ X15까지 임시변수명을 붙여줌

# ------------------------------------
## readr::read_csv() 함수 이용
ad.url.tb <- read_csv(file = url, col_names = FALSE,
                      trim_ws = TRUE,
                      na = c("", "?"))
glimpse(ad.url.tb)
class(ad.url.tb); mode(ad.url.tb)
# - read_csv() 함수는 데이터요소값들을 구별하는 구분기호가 
#   콤마(,)로 되어 있는 파일에 특화된 로딩함수임
#   (그래서 별도의 delim = ","라는 구분이 없음)
# - 구분기호가 세미콜론(;)이나 탭(/t)로 되어 있는 파일로딩시 오류가 발생함
# - header가 없는 온라인사이트 파일 로딩시 
#   V가 아닌 X1 ~ X15까지 임시변수명을 붙여줌

#############################################################################
## (3) 최신 data.table 패키지 활용 로딩방식
# - fread() 함수를 이용해 온라인상에 존재하는  
#   plain text 파일을 data.table 형식과 data.frame 형식으로 로딩함

## 필요 패키지 설치
# install.packages("data.table")
library(data.table)

# ------------------------------------
# data.tabble::fread() 함수 이용
ad.url.dt <- fread(input = url, header = FALSE, sep = ",", 
                   stringsAsFactors = FALSE, 
                   strip.white = TRUE, 
                   na.strings = c("", "?"))

glimpse(ad.url.dt)
class(ad.url.dt); mode(ad.url.dt)
# - header가 없는 온라인사이트 파일 로딩시 V1 ~ V15까지 임시변수명을 붙여줌

#############################################################################
## 임시로 부여된 변수컬럼에 정식 변수컬럼명 반영 
# - Census Income 데이터셋 관련 웹사이트에 있는
#   Attribute Information(속성정보),
#   즉 조작적정의(코딩북) 내용을 참조해 변경

# - 온라인사이트에서 다운로드 받은 
#   ad.url.df(임시변수 V1 ~ V15), 
#   ad.url.tb(임시변수 X1 ~ X15), 
#   ad.url.dt(임시변수 V1 ~ V15) 객체 중에서
#   tibble 형식인 ad.url.tb 객체를 이용(다른 객체를 사용해도 동일) 

# ------------------------------------
## plyr 패키지의 rename()를 이용한 변수컬럼 변경
# install.packages("plyr")
library(plyr)

ad.url.tb <- rename(ad.url.tb, c(X1 = "age",
                                 X2 = "workclass",
                                 X3 = "fnlwgt",
                                 X4 = "education",
                                 X5 = "education-num",
                                 X6 = "marital-status",
                                 X7 = "occupation",
                                 X8 = "relationship",
                                 X9 = "race",
                                 X10 = "sex",
                                 X11 = "capital-gain",
                                 X12 = "capital-loss",
                                 X13 = "hours-per-week",
                                 X14 = "native-country",
                                 X15 = "Salary-level"
)
)

colnames(ad.url.tb) # colnames() 함수로 변수컬럼명 변경내용 확인
glimpse(ad.url.tb) # 내부구조정보로 변수컬럼명 변경내용 확인

# ------------------------------------
## 일부 변수컬럼명만 선별 변경
ad.url.tb <- rename(ad.url.tb, c(workclass = "wclass")) 
# - 기본은 old_name = "new_name" 구조로 
#   new_name 양쪽에는 따옴표로 묶어주어야 함

ad.url.tb <- rename(ad.url.tb, c("marital-status" = "mt_status")) 
# - old_name에 마이너스(-) 등의 기호가 있는 경우 따옴표 필요함

colnames(ad.url.tb) # names() 함수로 변수컬럼명 변경내용 확인
glimpse(ad.url.tb) # 내부구조정보로 변수컬럼명 변경내용 확인

# ------------------------------------
## 2개 이상의 변수컬럼에 대해 동시에 변수컬럼명 변경
ad.url.tb <- rename(ad.url.tb, c(occupation="ocp",
                                 "capital-gain" = "cap_gain",
                                 "capital-loss" = "cap_loss"
)
)

colnames(ad.url.tb) # names() 함수로 변수컬럼명 변경내용 확인
glimpse(ad.url.tb) # 내부구조정보로 변수컬럼명 변경내용 확인

### End of Source ###########################################################


ad.url.df <- rename(ad.url.df, c(V1 = "age",
                                 V2 = "workclass",
                                 V3 = "fnlwgt",
                                 V4 = "education",
                                 V5 = "education-num",
                                 V6 = "marital-status",
                                 V7 = "occupation",
                                 V8 = "relationship",
                                 V9 = "race",
                                 V10 = "sex",
                                 V11 = "capital-gain",
                                 V12 = "capital-loss",
                                 V13 = "hours-per-week",
                                 V14 = "native-country",
                                 V15 = "Salary-level"
)
)

ad.url.dt <- rename(ad.url.dt, c(V1 = "age",
                                 V2 = "workclass",
                                 V3 = "fnlwgt",
                                 V4 = "education",
                                 V5 = "education-num",
                                 V6 = "marital-status",
                                 V7 = "occupation",
                                 V8 = "relationship",
                                 V9 = "race",
                                 V10 = "sex",
                                 V11 = "capital-gain",
                                 V12 = "capital-loss",
                                 V13 = "hours-per-week",
                                 V14 = "native-country",
                                 V15 = "Salary-level"
)
)


ad.url.df <- rename(ad.url.df, c(workclass = "wclass")) 
ad.url.df <- rename(ad.url.df, c(occupation="ocp",
                                 "capital-gain" = "cap_gain",
                                 "capital-loss" = "cap_loss",
                                 "marital-status" = "mt_status"
)
)

ad.url.dt <- rename(ad.url.dt, c(workclass = "wclass")) 
ad.url.dt <- rename(ad.url.dt, c(occupation="ocp",
                                 "capital-gain" = "cap_gain",
                                 "capital-loss" = "cap_loss",
                                 "marital-status" = "mt_status"
)
)
