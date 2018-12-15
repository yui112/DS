#############################################################################
### 일반 Plain Text 파일 로딩
# - R패키지내 예제데이터셋 로딩
#############################################################################

## R base 패키지 목록 확인
getOption("defaultPackages")

## 현재 메모리 로딩패키지 목록 확인
search() 

# ------------------------------------
## 예제데이터셋을 보유하고 있는 datasets패키지 
library(help = datasets)
help(package = datasets)
# - dataset 패키지에 대한 도움말 확인

data(package = "datasets")
# - datasets패키지에 들어 있는 예제데이터 목록만 추출

data(mtcars)
# - mtcars라는 예제데이터셋 메모리로 로딩

data(mtcars, package = "datasets")
# - mtcars라는 예제데이터셋을 datasets라는 패키지에서 가져와
#   메모리로 로딩하라는 명시적 표현

#############################################################################
## Adult 데이터셋 로딩

## adult 데이터셋을 보유한 기여패키지인 arules 패키지 로딩
# install.packages("arules")
library(arules)

## 해당 패키지 도움말 확인
library(help = arules)
help(package = arules)

# ------------------------------------
## 해당 패키지에 들어 있는 데이터셋 목록만 확인
data(package = "arules")

## adult 데이터셋 로딩
data(AdultUCI, package = "arules")

## adult 데이터셋 도움말 확인
help(AdultUCI)
? AdultUCI

# ------------------------------------
## adult 데이터셋 구조파악
str(AdultUCI)
class(AdultUCI); mode(AdultUCI)
glimpse(AdultUCI)

## adult 객체유형 변경
library(dplyr)
AdultUCI.tibble <- as_tibble(AdultUCI)

str(AdultUCI.tibble)
class(AdultUCI.tibble); mode(AdultUCI.tibble)
glimpse(AdultUCI.tibble)

### End of Source ###########################################################