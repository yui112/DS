###############################################################################
##### 집계(aggretation)의 의미
# - 주어진 로데이터를 인덱싱이나 필터링을 통해서 
#   서브셋을 만드는 것을 알고 있을 때,
#   이 서브셋별로 특성분석을 위한 기술통계분석을 의미함
###############################################################################


## 집계함수 설정 방식은 2가지가 있음
# 1. 인수설정 방식: aggregate, tapply
# 2. formular 빙식: aggregate, doBy::summaryBy

###############################################################################
## 1. 인수설정방식에 대한 예제: mtcars 데이터셋을 이용 
###############################################################################

options(digits=4)
# - 요약그룹 비교를 평균값을 가지고 하므로 출력수치를 4자리 정도로 해서 
#   모든 변수값들이 소수점이 출력될 수 있도록 함

data(mtcars) # datasets 패키지에 있는 mtcars 데이터셋 메모리로 로딩
help(mtcars) # mtcars에 대한 도움말(조작적정의, 코딩북) 확인

str(mtcars)
head(mtcars)

###############################################################################
### stats::aggregate() 이용 ==> stats는 기본 내장로딩 패키지

## aggregate() 모든 인수 사용
aggregate(x=mtcars, 
          by=list(mtcars$cyl), 
          FUN=mean, na.rm=TRUE) 
# - x옵션: mtcars 데이터프레임의 모든 변수컬럼 데이터를 대상으로 
#   요약집계하겠다는 의미
# - 이로인해 불필요한 변수컬럼에 대해서도 요약집계 통계치가 나와서 다소 불편함
#   특히 그룹변수로 사용한 cyl이 나시 요약집계 테이블에 나와서 불편함
# - by옵션: mtcars 데프에서 1개 변수를 집계그룹 기준변수로 선정함
#   aggregate()에서는 요약집계 기준변수가 1개이든 2개이든 by=list()로 설정해야 함
# - FUN옵션: 평균함수를 mtcars 데프의 모든 변수컬럼에 적용(결측치 제외)

# ------------------------------------------------------
## aggregate() 인수 없이 사용 
aggregate(mtcars[c(1, 3:6)], list(mtcars$cyl), mean, na.rm=TRUE) 
# - mtcars 데프에서 보고싶은 요약집계 변수컬럼 5개를 인덱싱해서 준비함
#   요약집계된 통계치 산정결과가 보다 심플해서 해석하기 용이함
# - mtcars 데프에서 1개 변수를 집계그룹 기준변수로 선정함
#   그러나 요약집계에 사용한 기준변수의 변수컬럼명이 Group.1이라서 구체화할 필요가 있음
# - 산술평균 함수를 보고싶은 요약집게 변수컬럼 5개에 동시적용함 

aggregate(mtcars[c(1, 3:6)], list(CylType=mtcars$cyl), mean, na.rm=TRUE)
# - 집계그룹 기준변수로 선정된 1개 변수컬럼에 별도의 요약집계 그룹명칭을 부여함
# - 어떤 변수컬럼을 요약집계 기준변수로 사용했는지 그룹명칭이 있어 이해하기 용이해짐 

aggregate(mtcars[c(1, 3:6)], 
          list(Cyl.Type=mtcars$cyl, Gear_Type=mtcars$gear),
          mean, na.rm=TRUE)
# - 집계그룹 기준변수로 cyl을 1순위로, gear를 2순위로 선정해 보다 다차원적인 분석이 됨
#   요약집계를 위한 그룹명칭은 자유롭게 설정가능함
# - 요약집계 기준변수 2개를 복합적으로 사용한 결과,
#   cyl 4, 6, 8기통 X gear 3, 4, 5단 = 9개의 요약집계그룹이 나와야 함
# - 요약집계 테이블에는 cyl 8기통 X gear 4단 스펙을 가진 차종은 없는 것으로 판단됨
# ==> 이를 통해 aggregate()는 복합 요약집계 기준변수를 통해 다중 결과변수들 간의
#     요약집계 그룹별 분석결과를 확인할 수 있음

result <- aggregate(mtcars[c(1, 3:6)], 
                    list(Cyl.Type=mtcars$cyl, Gear_Type=mtcars$gear),
                    mean, na.rm=TRUE)

View(result)

# ------------------------------------------------------
aggregate(mtcars[c(1, 3:6)], 
          list(Cyl.Type=mtcars$cyl, 
               Gear_Type=mtcars$gear,
               Autotype=mtcars$am),
          mean, na.rm=TRUE)
# - 3중 복합 요약집계 기준변수 설정도 잘 작동함

result2 <- aggregate(mtcars[c(1, 3:6)], 
                     list(Cyl.Type=mtcars$cyl, 
                          Gear_Type=mtcars$gear,
                          Autotype=mtcars$am),
                     mean, na.rm=TRUE)
# - 3중 복합 요약집계 기준변수 설정도 잘 작동함

View(result2)

###############################################################################
### base::tapply() 이용 집계작업

tapply(X = mtcars$mpg, INDEX = list(mtcars$cyl), FUN = mean, na.rm=T)
# - INDEX 옵션에 설정해주는 기준변수가 1개이므로 그냥 INDEX=abc#gender라고 해도 됨
# - tapply() 괄호안에 매번 abc$ 붙이는 것을 해소하려면, with({})을 사용하면 됨
# - with(mtcars, {tapply(X = price, INDEX = list(gender), FUN = mean)})

# ------------------------------------------------------
mtcars$cyl2 <- factor(mtcars$cyl, levels=c(4, 6, 8), labels=c("4기통", "6기통", "8기통"))
# - cly변수를 팩터화해 4="4기통", 6="6기통", 8="8기통"으로 레이블을 붙임

tapply(mtcars$mpg, mtcars$cyl2, mean, na.rm=T)
# - cyl 유형별 연비(mpg) 특성을 평균값을 통해 비교해 봄
# - tapply()의 인수명을 생략했고, 요약집계 기준변수도 1개라서 list() 표시 마저도 없애 간략화 함

# ------------------------------------------------------
mtcars$gear2 <- factor(mtcars$gear, levels=c(3, 4, 5), labels=c("3단", "4단", "5단"))
# g- ear변수를 팩터화해 3="3단", 4="4단", 5="5단"으로 레이블을 붙임

tapply(mtcars$mpg, list(mtcars$cyl2, mtcars$gear2), mean, na.rm=T)
# - 요약집계 변수로 1순위 cyl2, 2순위 gear2를 설정해서 요약집계 함
# - cyl2 4, 6, 8기통 X gear2 3, 4, 5단 간 복합 요약집계 그룹을 만들어 교차테이블 형식으로 분석함
# - 이 교차테이블에서도 8기통 X 4단 그룹은 NA로 나타나 해당 스펙 차종은 없는 것으로 판단됨
# - 이 구문도 with(mtcars, {})를 통해 간단하게 표현할 수 있음
# - with(mtcars, {tapply(mpg, list(cyl2, gear2), mean, na.rm=T)})

result <- tapply(mtcars$mpg, list(mtcars$cyl2, mtcars$gear2), mean, na.rm=T)
View(result)

# ------------------------------------------------------
mtcars$am2 <- factor(mtcars$am, levels=c(0, 1), labels=c("수동", "자동"))
# - am변수를 팩터화해 0="수동", 1="자동"으로 레이블을 붙임

tapply(mtcars$mpg, list(mtcars$cyl2, mtcars$gear2, mtcars$am2), mean, na.rm=T)
# - 요약집계 기준변수로 1순위 cyl2, 2순위 gear2, 3순위 am2를 설정해 3중 복합 요약집계를 실시함
# - 기존의 cyl2 X gear2간의 교차테이블이 am=수동 레이어(층)과 am=자동 레이어로 3차원으로 나타남
# - 분석결과 am=수동층에서는 모든 cyl 유형별로 gear가 5단인 스펙을 가진 차량은 없은 것으로 조사됨
# - 분석결과 am=자동층에서는 모든 cyl 유형별로 gear가 3단인 스펙을 가진 차량은 없는 것으로 조사됨
# - 간단히 with(mtcars, {tapply(mpg, list(cyl2, gear2, am2), mean)})

# ==> 이를 통해 tapply()는 단일 요약집계 기준변수를 통해 다중 결과변수들 간의
#     요약집계 그룹별 분석결과를 확인할 수 있음

### End of Source #############################################################


