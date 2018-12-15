## party 패키지 설치 및 로딩, 패키지 내 데이터 목록조회
#install.packages("party")
library(party)
data(package = "party")

## part 패키지 내 readingSkills 데이터셋 로딩과 코딩북 확인
data(readingSkills , package = "party")
help(readingSkills , package = "party")

## readingSkills 데이터셋에 대한 간단조회, 구조파악, 간단 기술통계분석
summary(readingSkills)
str(readingSkills)
skim(readingSkills)
psych::describe(readingSkills)
Hmisc::describe(readingSkills)

## 반응변수인 nativeSpeaker의 레이블순서를 yes < no 순서로 변경
readingSkills$nativeSpeaker <- factor(c(readingSkills$nativeSpeaker), levels=c(1,2), labels=c("yes", "no"))

## 학습(트레이닝) & 검증(테스트) 데이터 70:30 비율로 추출
myseed <- 100
set.seed(myseed)

## 훈련데이터 인덱스 무작위추출
install.packages("caret")
library(caret)
trainRowNumbers <- createDataPartition(readingSkills$nativeSpeaker,
                                       p = 0.7, list = FALSE)
trainRowNumbers

## 훈련데이터셋 생성
trainData <- readingSkills[trainRowNumbers, ]
trainData
# - 훈련데이터 인덱스를 이용

## 테스트 데이터셋 생성
testData <- readingSkills[-trainRowNumbers, ]
testData

x.train  =  trainData[, 2:4]
y.train  =  trainData$nativeSpeaker

x.train
y.train

x.test  =  testData[, 2:4]
y.test  =  testData$nativeSpeaker

x.test
y.test

## 학습 & 검증 데이터 간단조회
Hmisc::describe(x.train)
Hmisc::describe(y.train)
Hmisc::describe(x.test)
Hmisc::describe(y.test)


## 학습데이터를 이용한 분류규칙 생성
library(rpart)
set.seed(1234)
install.packages("randomForest")
library(randomForest)

forest.fit <- randomForest(y.train ~ ., data = x.train,
                           na.action = na.roughfix,
                           importance = TRUE)

forest.fit
plot(forest.fit)

importance(forest.fit)
importance(forest.fit, type=1)
importance(forest.fit, type=2)
varImpPlot(forest.fit)
varImp(forest.fit)

## 분류규칙 그래프 그리기

## 분류규칙을 이용한 학습(train)데이터 분류분석
forest.pred.train <- predict(forest.fit, x.train)
forest.pred.train
forest.perf.train <- table(forest.pred.train, y.train,
                           dnn=c("TrainRule", "TrainActual"))
forest.perf.train
addmargins(table(y.train))
addmargins(forest.perf.train)

sum(forest.perf.train)
sum(diag(forest.perf.train))
sum(diag(forest.perf.train))/sum(forest.perf.train)


## 검증(test)데이터에 대한 분류분석
forest.pred.test <- predict(forest.fit, x.test)
forest.pred.test
forest.perf.test <- table(forest.pred.test, y.test,
                          dnn=c("TestPredicted", "TestActual"))
forest.perf.test

addmargins(table(y.test))
addmargins(forest.perf.test)

sum(forest.perf.test)
sum(diag(forest.perf.test))
sum(diag(forest.perf.test))/sum(forest.perf.test)


x <- sum(diag(forest.perf.train))/sum(forest.perf.train)
y <- sum(diag(forest.perf.test))/sum(forest.perf.test)

compare <- c(x, y, y - x)
names(compare) <- c("trainAccuracy", "testAccuracy", "AccuracyGap")

compare
round(compare*100, 2)
install.packages("e1071")
library(e1071)
library(caret)
confusionMatrix(forest.perf.test, positive = "yes")