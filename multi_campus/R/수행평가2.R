install.packages("arules")
install.packages("arulesSequences")

library(arules)
library(arulesSequences)
data("Groceries")


## arules 패키지 내 Groceries 데이터셋 로딩과 코딩북 확인
data(Groceries , package = "arules")
help(Groceries , package = "arules")

str(Groceries)
#데이터 요약
summary(Groceries)
#거래되는 아이템 목록
itemLabels(Groceries)[1:10]
#상대빈도수와 절대빈도수 시각화하기
#잘팔리는 탑10
par(mfrow=c(1,2))

itemFrequencyPlot(Groceries,
                  type="relative",
                  topN=10, 
                  horiz=TRUE,
                  col='steelblue3',
                  xlab='',
                  main='Item frequency, relative')

itemFrequencyPlot(Groceries,
                  type="absolute",
                  topN=10,
                  horiz=TRUE,
                  col='steelblue3',
                  xlab='',
                  main='Item frequency, absolute')

#안팔리는 아이템 10가지
#그래프가 크므로 오류가 날경우 확대하세요~
par(mar=c(2,10,2,2), mfrow=c(1,2))

barplot(sort(table(unlist(LIST(Groceries))))[1:10]/9835,
        horiz=TRUE,
        las=1,
        col='steelblue3',
        xlab='',
        main='Frequency, relative')

barplot(sort(table(unlist(LIST(Groceries))))[1:10],
        horiz=TRUE,
        las=1,
        col='steelblue3',
        xlab='',
        main='Frequency, absolute')

##지지도 0.03, 신뢰도 0.1로 설정한 연관규칙
itemsets <- apriori(Groceries,
                    parameter = list(support=.03, conf = 0.1),
                                     control=list(verbose=T))


summary(itemsets)
inspect(itemsets)


inspect(sort(itemsets, by='support', decreasing = T)[9:46])

quality(itemsets)$lift <- interestMeasure(itemsets, measure='lift', Groceries)
inspect(sort(itemsets, by ='lift', decreasing = T)[9:46])

#지지도 0.03, 신뢰도 0.1, 우유로 시작하는 연관규칙
rules2 <- apriori (data=Groceries, parameter=list (supp=0.03,conf = 0.1), appearance = list (lhs="whole milk"), control = list (verbose=T)) # get rules that lead to buying 'whole milk'
summary(rules2)
inspect(rules2)

rules_conf <- sort (rules2, decreasing= F)
inspect(head(rules_conf))

