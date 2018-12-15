######################################################################
## 데이터 순환사용(interation) purrr 패키지의 map() 계열 함수
######################################################################
# - base패키지의 apply(), sapply(), lapply() 함수와 용도가 비슷함

## 간단 리스트 형식 데이터 생성
ex <- list(A = matrix(1:12, 3), B = 1:5, 
           C = matrix(1:4, 2), D = rep(c(2, 4), 3))
ex
# - 전형적인 리스트 형식객체임

######################################################################
## 리스트 형식에 대한 데이터순환사용 (1)

## 전통적 lapply() & sapply() 함수사용
lapply(ex, sum)
# - 각 리스트항목에 접근해 sum함수를 적용한 결과를 리스트형식으로 만들어줌

sapply(ex, sum)
# - 각 리스트항목에 접근해 sum함수를 적용한 결과를 벡터형식으로 만들어줌

# --------------------------------------
## 데이터 순환사용 purr패키지 사용
## install.packages("purrr")
library(purrr)

map(ex, sum)
# - 리스트객체인 ex의 각 리스트항목에 접근해 sum함수를 적용(mapping)해서
#   그 결과를 리스트 형식으로 만들어 줌
# - 출력결과가 lapply()와 비슷함

identical(map(ex, sum), lapply(ex, sum))

# --------------------------------------
map_df(ex, sum)
# - 리스트객체인 ex의 각 리스트항목에 접근해 sum함수를 적용(mapping)해서
#   그 결과를 데이터프레임 형식으로 만들어 줌

map_int(ex, sum)
# - ex리스트 객체의 각 리스트항목에 sum을 적용한 결과, 
#   실수형 합이 계산되는데 정수로 반환받을 수 없어 에러발생

map_dbl(ex, sum)
# - ex리스트 객체의 각 리스트항목에 sum을 적용한 결과, 
#   실수형 합이 계산되므로 그대로 실수벡터형으로 반환받을 수 있음

map_chr(ex, sum)
# - ex리스트 객체의 각 리스트항목에 sum을 적용한 결과, 
#   실수형 합이 계산되는데 이를 강제로 문자벡터형식으로 변환해 출력해 줌

map_lgl(ex, sum)
# - ex리스트 객체의 각 리스트항목에 sum을 적용한 결과, 
#   실수형 합이 계산되는데 논리형으로 받환받을 수 없어 에러발생

# --------------------------------------
map_int(ex, NROW)
# - ex리스트 객체의 각 리스트항목에 NROW() 함수를 적용한 결과, 
#   각 리스트항목에 속한 요소갯수를 산출해 숫자벡터형식으로 반환해줌

map_lgl(ex, is.numeric)
# - ex리스트 객체의 각 리스트항목에 numeric() 함수를 적용한 결과, 
#   각 리스트항목에 속한 요소들이 숫자인지를 파악해 
#   논리벡터 형식으로 반환해줌

map_if(ex, is.matrix, function(x) {x * 2}) # 익명/무명 함수방식
map_if(ex, is.matrix, ~ .x * 2) # 관계식(formula) 설정방식
# - ex리스트 객체의 각 리스트항목에 is.matrix() 함수를 적용한 결과, 
#   각 리스트항목 중에서 행렬(매트릭스) 형식에만 곱하기 2를 하고
#   그대로 리스트 형식으로 반환해줌

map_if(ex, is.vector, function(x) {x * 3}) # 익명/무명 함수방식
map_if(ex, is.vector, ~ .x * 3) # 관계식(formula) 설정방식
# - ex리스트 객체의 각 리스트항목에 is.vector() 함수를 적용한 결과, 
#   각 리스트항목 중에서 벡터형식에만 곱하기 3을 하고
#   그대로 리스트 형식으로 반환해줌

##################################################
## 리스트 형식에 대한 데이터순환사용 (2)
# - 리스트데이터에 결측치(NA)가 포함되어 있는 경우

ex$A 
# - ex리스트객체에서 A라는 리스트항목을 출력

ex$A[2, 3] 
# - ex리스트객체에서 A라는 리스트항목 중 2행, 3열에 있는 요소를 출력 

ex$A[2, 3] <- NA
# - ex리스트객체에서 A라는 리스트항목 중 2행, 3열에 있는 요소에 NA를 입력 

ex$A 
# - ex리스트객체에서 A라는 리스트항목을 출력해 NA입력부분 반영여부 확인

# --------------------------------------
ex$D
ex$D[5]
ex$D[5] <- NA
ex$D
# - 리스트객체ex에서 D라는 리스트항목의 5번째 요소값에 대해서 
#   NA처리 후 반영여부를 확인

ex
# - 전체적인 NA반영 현황 재확인

# --------------------------------------
## 리스트객체에 NA값이 포함되어 있는 리스트항목이 존재하는 경우
lapply(ex, sum)
# - 각 리스트항목에 접근해 sum함수를 적용한 결과를 리스트형식으로 만들어줌
# - 리스트항목 B, C를 활용해서 정상적으로 합계 출력됨
# - NA요소를 가지고 있는 A와 D 리스트 항목에 대한 합계계산 결과는 NA로 출력됨

lapply(ex, sum, na.rm = TRUE)
# - ex리스트객체의 각 리스트항목에 접근해 sum() 적용시 NA요소가 있을 경우
#   이를 제외하고 sum() 함수를 적용하도록 na.rm = TRUE 옵션을 사용함

lapply(ex, function(x) {sum(x, na.rm = TRUE)})
# - 익명/무명함수(the anonymous functions)라고 부르는 형식을 이용해 
#   sum() 함수 적용시 na.rm = TRUE 옵션을 반영해 NA요소에 대해 제외시킴

# --------------------------------------
sapply(ex, sum)
sapply(ex, sum, na.rm = TRUE)
sapply(ex, function(x) {sum(x, na.rm = TRUE)})
# - sapply() 함수사용시 리스트객체에 접근해 각 리스트항목별로 
#   sum()함수를 적용하고 이를 숫자벡터로 반환함

# --------------------------------------
## purrr패키지의 map() 계열 함수이용

map(ex, sum)
map(ex, sum, na.rm = TRUE)
map(ex, function(x) {sum(x, na.rm = TRUE)})

map_df(ex, sum)
map_df(ex, sum, na.rm = TRUE)
map_df(ex, function(x) {sum(x, na.rm = TRUE)})

map_int(ex, sum)
map_int(ex, sum, na.rm = TRUE)
map_int(ex, function(x) {sum(x, na.rm = TRUE)})

map_dbl(ex, sum)
map_dbl(ex, sum, na.rm = TRUE)
map_dbl(ex, function(x) {sum(x, na.rm = TRUE)})

map_chr(ex, sum)
map_chr(ex, sum, na.rm = TRUE)
map_chr(ex, function(x) {sum(x, na.rm = TRUE)})

map_lgl(ex, sum)
map_lgl(ex, sum, na.rm = TRUE)
map_lgl(ex, function(x) {sum(x, na.rm = TRUE)})

map_if(ex, is.matrix, function(x) {x * 2})
map_if(ex, is.matrix, ~.x * 2)

map_if(ex, is.vector, function(x) {x * 3})
map_if(ex, is.matrix, ~.x * 3)


### End of Source ####################################################