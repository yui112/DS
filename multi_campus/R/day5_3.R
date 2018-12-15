######################################################################
### apply() 함수 사용예
######################################################################

# 사용목적: 특정 데이터셋 대해 가로방향(행단위)으로, 
#           또는 세로방향(열단위)으로 필요한 함수를 일괄 적용해줌

# ---------------------------------------
## 간단 데이터 생성
m <- matrix(1:9, nrow = 3)
m

## 행렬데이터에 대한 가로 & 세로 방향 연산
rowSums(m) 
# - 행렬데이터 m객체에 대해 가로방향으로 각 행(row)별로 합(sum)을 구함
colSums(m) 
# - 행렬데이터 m객체에 대해 세로방향으로 각 열(col)별로 합(sum)을 구함

# ---------------------------------------
## apply() 함수를 이용한 가로 & 세로 방향 연산
apply(m, 1, sum) 
# - m객체에 들어 있는 데이터에 대해서 가로방향(인수 1)으로 
#   sum()함수를 한줄 한줄 적용한 결과

apply(m, 2, sum)
# - m객체에 들어 있는 데이터에 대해서 세로방향(인수 2)으로 
#   sum()함수를 한칸 한칸 적용한 결과

# - rowSums() vs. apply() 
# - rowSums는 가로방향으로 총합만 구할수 있음
# - apply()는 가로/세로방향으로 다양한 함수를 사용할 수 있음

# ---------------------------------------
## 가로방향 연산결과에 대한 동일성 검토
identical(rowSums(m), apply(m, 1, sum))

str(rowSums(m)) # 데이터유형은 숫자, 객체형식은 실수벡터(num)임
str(apply(m, 1, sum)) # 데이터유형은 숫자, 객체형식이 정수(int)임

# - rowSums()와 apply() 산출결과의 형식은 달라도 숫자내용은 동일하며
#   실수, 정수간 서로 형식 변환이 가능하므로 문제없음

rowSums(m) %>% as.integer %>% str # 실수벡터(num)를 정수벡터(int)로 변환
apply(m, 1, sum) %>% as.numeric %>% str # 정수벡터(int)를 실수벡터(num)로 변환

# ---------------------------------------
## apply() 함수 적용시 데이터셋에 NA가 있는 경우 
m[2, 1] <- NA
m

colSums(m) # 사칙연산에서 NA가 있으면 결과도 NA로 나옴
colSums(m, na.rm = TRUE) # NA를 제외한 실제 데이터만 갖고 사칙연산수행

apply(m, 2, sum) # 사칙연산에서 NA가 있으면 결과도 NA로 나옴
apply(m, 2, sum, na.rm = TRUE)  # NA를 제외한 실제 데이터만 갖고 사칙연산수행

######################################################################
## 학생명부 데이터프레임 생성을 통한 apply() 함수 적용예

student <- c("John Davis","Angela Williams","Bullwinkle Moose",
             "David Jones","Janice Markhammer", "Cheryl Cushing",
             "Reuven Ytzrhak", "Greg Knox","Joel England","Mary Rayburn")
math <- c(502, 600, 412, 358, 495, 512, 410, 625, 573, 522)
science <- c(95, 99, 80, 82, 75, 85, 80, 95, 89, 86)
english <- c(25, 22, 18, 15, 20, 28, 15, 30, 27, 18)

## data.frame 객체형태로 가공
roster.df <- data.frame(student, math, science, english, 
                        stringsAsFactors=FALSE)
roster.df
str(roster.df)

## tibble 객체형태로 가공
install.packages("tibble")
library(tibble)

roster.tb <- tibble(student, math, science, english)
str(roster.tb)

## 또는 data.frame객체를 tibble 객체로 변환
roster <- as_tibble(roster.df)
roster
str(roster)

# ---------------------------------------
## 학생명부 데이터에 apply() 함수를 바로 적용한 경우
apply(roster[2:4], 1, mean)
# - roster를 가로방향으로, 각 행별로, 각 레코드별로, 각 관찰치별로 
#   개별 학생들의 평균성적 도출
# - 각 과목별 스케일(단위 & 범위)가 달라 바람직하지 않음

apply(roster[2:4], 2, mean)
# - roster df를 세로방향으로, 각 열별로, 각 변수컬럼별로, 각 피처별로 
#   개별 과목들의 평균성적 도출
# - 각 과목별 평균점수를 구했으나 스케일이 달라 상호비교 어려움

######################################################################
## 학생명부 데이터에 스케일링(scailing) 실시후 평균점수 산출
# - 스케일링: 동시에 사용할 변수들의 단위와 범위가 다를 때 
#   비례축소/크기변환을 통해 표준화 하는 방법
# - math: 700점만점, science: 100점만점(현행유지), english: 30점만점

## 모든 과목을 100점 만점으로 표준화

# install.packages("magrittr") 
library(magrittr)
# - 파이프 %>% 연산자 사용을 위한 패키지 로딩

roster$math100 <- round((roster$math * 100) / 700, 1)
roster$eng100 <- ((roster$english * 100) / 30) %>% signif(1)
# - Math 700점 만점, Science 100점 만점, English 30점 만점으로 가정
# - science과목은 100점 만점 기준으로 수집된 데이터로 간주해 스케일링 작업없음

head(roster) 
head(roster[c(3, 5, 6)])
# - 100점만점 기준으로 스케일링된 결과확인

# ---------------------------------------
## 100점만점 스케일링된 학생명부 데이터에 
# - apply() 함수를 적용해 개인별 성적평균과 표준편차 계산

roster$st.avg <- apply(roster[c(3, 5, 6)], 1, mean) %>% round(1) 
roster$st.sd <- apply(roster[c(3, 5, 6)], 1, sd) %>% round(1)
# - roster df를 가로방향으로, 각 행별로, 
#   개별 학생들의 평균성적과 표준편차 도출

roster
roster[-c(2, 4)]

install.packages("dplyr")
library(dplyr)
# - 데이터셋 처리패키지 기능 중 정렬(arrange) 기능사용을 위한 패키지 로딩

arrange(roster, desc(st.avg), desc(st.sd))
roster %>% arrange(desc(st.avg), desc(st.sd))
# - 학생들의 성적평균(st.avg)를 1순위로 내림차순 정렬
# - 학생들의 성적표준편차(st.sd)를 2순위로 내림차순 정렬

# ---------------------------------------
## 과목별 평균점수 산출
sj.avg <- apply(roster[c(3, 5, 6)], 2, mean) %>% round(1)
sj.avg
sj.sd <- apply(roster[c(3, 5, 6)], 2, sd) %>% round(1)
sj.sd

## 과목별 성적산출 결과취합
tibble(sj.avg, sj.sd)
result <- tibble(names(sj.avg), sj.avg, sj.sd) 
result

arrange(result, desc(sj.avg), desc(sj.sd))
# - 학생들의 성적평균(st.avg)를 1순위로 내림차순 정렬
# - 학생들의 성적표준편차(st.sd)를 2순위로 내림차순 정렬

### End of Source ####################################################
