getwd()
x <- 33
x
class(x)
num <- c(10, 23, 7)
char <- c("apple", "banana")
logic <- c(T, FALSE)
out1 <- c(char, num)
out1
f <- c("aa", "bb")
f + f
f + "cc"
f + 2
name <- c("홍길동", "Jessica", "장그래", "제인", "다니엘", "최강타")
gender <- c(1, 2, 1, 2, 1, 1) # 1: 남자, 2: 여자
job <- c("학생", "주부", "직장인", "주부", "직장인", "직장인")
age <- c(19, 55, 23, 35, 45, 32) # 연령
grade <- c("A", "C", "B", "B", "C", "A") # 회원등급
survey <- c(3, 4, 2, 5, 5, 3) # 온라인쇼핑 만족도
total <- c(34.6, 18.5, 23.7, 27.0, 13.5, 47.2) # 총구매금액
customer <- data.frame(name, gender, job, age, grade, survey, total)
class(customer); mode(customer)
customer
View(customer)
