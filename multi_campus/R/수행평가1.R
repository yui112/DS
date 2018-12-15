library(datasets)

#데이터로드
data(mtcars)

## datasets 패키지 내 mtcars 데이터셋 로딩과 코딩북 확인
data(mtcars , package = "datasets")
help(mtcars , package = "datasets")

#데이터 체크
View(mtcars)

head(mtcars)
#간략학 통계분석
summary(mtcars)

mtcars$mpg

mtcars$am

# install.packages("psych")
library(psych)
psych::describe(mtcars$am)

rbind(manual=summary(mtcars[mtcars$am==1,"mpg"]), automatic=summary(mtcars[mtcars$am==0,"mpg"]))

#정규성 검증.
SWam1<-shapiro.test(mtcars[mtcars$am==1,"mpg"])
SWam2<-shapiro.test(mtcars[mtcars$am==0,"mpg"])
cbind(p.value.manual=SWam1$p.value,p.value.automatic=SWam2$p.value)
#가설을 리젝트 할 수 없으무로 티테스트를 사용

Ttest<-t.test(mpg~am,mtcars,alternative="less",paired=FALSE,var.equal=FALSE)
Ttest$p.value

#p_value가 0.05보다 적으므로 우리는 null hypothesis를 리젝트한다.

library(ggplot2)

ggplot(mtcars, aes(x=factor(am), y=mpg)) + geom_boxplot()



