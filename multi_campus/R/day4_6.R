###################################################################################
### 파이프 연산자 %>% 관련 간단예제
###################################################################################
# - 여러 함수들을 순차적으로 연결해서 사용하도록 해주며,
#   각 함수들간에 필요한 데이터를 상호 연결/전달해 주기 위한
#   중간중간의 임시변수 사용이 필요없음

## magrittr패키지의 파이프연산자 %>% 설치 및 로딩
install.packages("magrittr")
library(magrittr)

###################################################################################
## 파이프연산자 %>%의 사용예 [1]

## (1) 작업시 필요한 함수들의 연속적 사용
x <- sin(7)
x1 <- cos(x)
x2 <- tan(x1)
x3 <- sqrt(x2)
x3
# - 4개 함수기능 사용을 위해서 개별코드라인을 작성함
# - 4개 함수기능간 데이터를 상호 연결하기 위해서 중간중간마다 임시 변수를 사용함

# ------------------------------------
## (2) 작업시 필요한 함수들의 중첩 사용
sqrt(tan(cos(sin(7))))
# - 4개 기능함수를 별로 코드라인으로 작성하지 않고 중첩방식으로 코딩함
# - 4개 함수간 데이터 상호 연결을 위한 임시변수는 불필요하지만 코딩이 복잡해짐

# ------------------------------------
## (3) 파이프연산자 %>%를 이용한 순차적 함수계산
7 %>% sin() %>% cos() %>% tan() %>% sqrt() 
# - 최초 raw데이터를 입력하고 준비되어 있는 함수들간 연산이 순차적으로 진행됨
# - 각 기능함수들간 데이터를 상호 연결하기 위한 중간중간의 임시변수 불필요

7 %>% sin %>% cos %>% tan %>% sqrt
# - 파이프 연산자에 사용하는 함수들은 괄호( )를 사용하지 않아도 됨

7 %>% sin %>% 
  cos %>% 
  tan %>% 
  sqrt
# - 파이프 연산자를 기준으로 여러줄에 걸쳐 들여쓰기 방식으로 코딩가능함

###################################################################################
## 파이프연산자 %>%의 사용예 [2] 

## flights 데이터셋 로딩

## flights 데이터셋을 보유한 기여패키지인 nycflights13 패키지 로딩
install.packages("nycflights13")
library(nycflights13)

## 해당 패키지 도움말 확인
library(help = nycflights13)
help(package = nycflights13)

# ------------------------------------
## 해당 패키지에 들어 있는 데이터셋 목록 확인
data(package = "nycflights13")

## flights 데이터셋 로딩
data(flights, package = "nycflights13")

## flights 데이터셋 도움말 확인
help(flights)
? flights

# ------------------------------------
## 일반 함수사용방식과 파이프연산자 사용방식을 병행

## flights 데이터셋 구조파악
class(flights); mode(flights)
flights %>% class; flights %>% mode 
# - flights 데이터셋은 tibble 객체유형과 data.frame 객체유형임

str(flights)
flights %>% str

dplyr::glimpse(flights)
flights %>% glimpse
# - tibble 객체유형에서의 변수컬럼별 데이터유형
#   dbl: doubles(실수)
#   chr: character(문자) 또는 strings(문자열)
#   dttm: date-times(날짜+시간)

# ------------------------------------
## flights 데이터셋 내용조회
flights

psych::headTail(flights)
flights %>% headTail

#############################################################################
## 파이프연산자 %>%의 사용예 [3] 

## 항공편 출발지(origin) 유형별 빈도수와 비율, 백분율 계산

## (1) 일반 table(), prop.table(), round() 함수의 중첩 사용
table(flights$origin)
prop.table(table(flights$origin))
round(prop.table(table(flights$origin)), 3)

# ------------------------------------
## (2) 각 기능함수간 연결변수 사용
table(flights$origin)
count <- table(flights$origin)
count

prop.table(count)
portion <- prop.table(count)
portion

round(portion, 3)
percent <- round(portion, 3)*100
percent

# ------------------------------------
## (3) 파이프 %>% 연산자를 통한 필요함수들의 순차적 이용
# install.packages("mgrittr)
library(magrittr)

percent <- function(x){x*100}

flights$origin %>% table %>% prop.table %>% round(3) %>% percent

flights$origin %>% 
  table %>% 
  prop.table %>% 
  round(3) %>%
  percent

### End of Source ###############################################

