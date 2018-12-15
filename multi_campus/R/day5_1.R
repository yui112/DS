########################################################################
## 사용자정의함수만들기: 나만의 기술통계분석함수

## 간단 내장데이터 로딩

install.packages("MASS")
library(MASS)
# - MASS패키지에 내장된 Animals 데이터 이용

library(help = MASS) # 패키지 관련 도움말 뷰어
help(package = MASS) # 패키지 관련 알파벳 순서 도움말
data(package = "MASS") # 패키지내 예제데이터 목록 조회

data(Animals, packages = "MASS") # 패키지내 특정 예제데이터 메모리로딩
help(Animals) # 특정 예제데이터 코딩북 도움말 확인

Animals # 특정 예제데이터 내용조회

## summary() 이용 요약
summary(Animals)

########################################################################

## 사용자정의함수를 이용한 기술통계요약정보
detail <- function(x) {
  
  ## 왜도와 첨도를 구하는 별도 패키지 인스톨체크와 로딩
  if (!require(moments)) {install.packages('package')}
  library(moments)
  
  ## 나만의 기술통계분석
  a1 <- length(x)
  a2 <- mean(x)
  a3 <- median(x)
  a4 <- var(x)
  a5 <- sd(x)
  a6 <- min(x)
  a7 <- max(x)
  a8 <- quantile(x, 1/4)
  a9 <- quantile(x, 3/4)
  a10 <- skewness(x)
  a11 <- kurtosis(x)
  
  ## 기술통계분석 결과모음
  final <- list(갯수 = a1, mymean = a2, mymedian = a3,
                  분산 = a4, 표준편차 = a5, myMin = a6, MAX = a7,
                  Qu1 = a8, Qu3 = a9, 왜도 = a10, 첨도 = a11)
  
  ## 최종 리턴값
  return(final)
}

detail(Animals$body)
detail(Animals$brain)

### End of Code ########################################################