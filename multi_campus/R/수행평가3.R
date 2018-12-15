library(car) 
library(ggplot2) 
library(MASS) 

data(Prestige, package = "carData") # 특정 데이터셋 로딩
help("Prestige") # 코딩북 확인

#Prestige 데이터셋 간단조회, 구조파악, 간단 기술통계분석
print(head(Prestige, n = 10))
ls(Prestige)
ncol(Prestige)
nrow(Prestige)
str(Prestige)


subset.data <- subset(Prestige, select = c("education", "income", "women", "prestige"))

# 기초통계 요약
str(subset.data)

print(summary(subset.data))
# 다중회귀분석 실시
prestige.mod1 <- lm(income ~ education + prestige + women, data= Prestige)

summary(prestige.mod1)

#유의하지 않은 변수 제거
prestige.mod2 <- step(prestige.mod1, direction  =  "both") # 단계적 방법 
summary(prestige.mod2)

## 회귀분석 모델진단 그래프: 멀티캔버스
par(mfrow = c(2, 3))

plot(prestige.mod2, which = c(1:6))

par(mfrow = c(1, 1))

##다중공선성(Multi-collinearity) 가정: 독립변수간 다중공선성 존재유무 파악
vif(prestige.mod1)
vif(prestige.mod1) > 10
vif(prestige.mod2)
vif(prestige.mod2) > 10

#install.packages("gvlma")
library(gvlma)
gvmodel <- gvlma(prestige.mod2)
summary(gvmodel)

#income 예측
new <- data.frame(education = 12, prestige = 33, women = 22)
predict(prestige.mod1, new, interval  =  "none")
