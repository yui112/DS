########################################################################
### 사용자 정의함수 만들기(User defined function)
########################################################################

## 간단한 사용자 정의함수 만들기

say.hello <- function() { 
  print("Hello, World!")
}
# - 사용자정의함수에 특별한 인수설정없음 
# - say.hello() 괄호안에 아무것도 안넣으면, 준비되어 있는 코드 실행
# - say.hello() 괄호안에 어떤 것을 넣으면, 
#               이를 받아주는 인수가 코딩되어 있지 않으므로 에러발생

say.hello() 
# - 특별한 인수를 입력하지 않아도 정해져 있는 함수기능이 실행됨

say.hello("aaa") 
# - 에러발생: 사용자정의함수에 어떤 값을 받아들이는 인수설정 코드가 없으므로 

say.hello(bbb)
# - 에러발생: 사용자정의함수에 어떤 값을 받아들이는 인수설정 코드가 없으므로 

## 이렇게 해도 출력이 됨(1)
say.hello <- function() { 
  "Hello, World!!!!!!!!" # 이 값이 유일한 리턴값이므로 출력됨
}

say.hello()

## 이렇게 해도 출력이 됨(2)
say.hello <- function() { 
  "Hello, World!!!!!!!!"
  print("Hello, World!22222") # 이 값이 마지막 실행결과값이므로 리턴됨 
}

say.hello()

########################################################################
## 또다른 사용자 정의함수 만들기

## sprintf(): 문자열과 변수를 결합해 하나의 문자열로 만들어 줌
# - 사용자정의함수 본문에 사용해 인수값 변화에 따라 
#   약속된 문장이 출력되도록 하는데 편리함

sprintf("Hello, %s!", "Jared") 
# - %s 코드는 변수값을 받는 부분
# - 뒤에 있는 "Jared"가 %s에 들어갈 변수값임

sprintf("Hello %s, today is %s.", "Jared", "Sunday")
# - 2개의 %s 코드 모두 변수값을 받는 부분
# - 뒤에 있는 "Jared"가 첫번째 %s에 들어가고, 
#   "Sunday"가 두번째 %s에 들어가는 변수값임

# --------------------------------------------------
## 사용자정의함수(1): 인수 1개설정

hello.person <- function(name) {
  print(sprintf("Hello, %s!", name))
}
# - name이라는 인수를 사용자정의 함수에 설정함

hello.person("Jared")
# - 괄호안에 "Jared"

hello.person 
# - 괄호가 없어서 함수코드가 그대로 출력됨

hello.person() 
# - 약속된 name인수에 입력된 값이 없어서 에러발생

hello.person(2321) 
# - 숫자가 입력됐지만 name인수의 입력값으로 인식해 작동함

hello.person("!@$!@$@") 
# - 여러 기호들을 입력했지만 name인수의 입력값으로 인식해 작동함

# --------------------------------------------------
## 여러작업을 순차적으로 진행할 때 관련 함수들의 사용방식

# i) 함수에 함수를 중첩시킴 
hello.friend <- function(name) {
  print(sprintf("Hello, %s!", name))
}

hello.friend("마이클")

# ii) 함수작업을 임시변수에 넘겨받아 그 다음작업에 활용
hello.friend <- function(name) {
  result <- sprintf("Hello, %s!", name)
  print(result)
}

hello.friend("마이클")

# iii) magrittr패키지의 %>% 파이프연산자 이용
library(magrittr)

hello.friend <- function(name) {
  sprintf("Hello, %s!", name) %>% 
    print
}

hello.friend("마이클")

# --------------------------------------------------
## 사용자정의함수(2): 인수 2개설정

hello.person2 <- function(first, last) {
  print(sprintf("Hello, %s %s!", first, last))
}
# - 사용자정의함수에 first와 last라는 인수 2개를 설정함

## 사용자정의함수 사용시 인수입력에 따라 정상/오류 결과 
hello.person2()
hello.person2("Jared") 
hello.person2("Lander")
hello.person2("Jared", Lander) 
hello.person2(Jared, "Lander") 
hello.person2(Jared, Lander)  

hello.person2("Jared", "Lander")
hello.person2("Lander", "Jared")

hello.person2(first = "Jared", last = "Lander")
hello.person2(last = "Lander", first = "Jared")

hello.person2(first = "Jared", "Lander")
hello.person2("Jared", last = "Lander")

hello.person2(last = "Lander", "Jared")
hello.person2("Lander", first = "Jared")

hello.person2(fir = "Jared", l = "Lander")
hello.person2(f = "Jared", "Lander")
hello.person2("Jared", la = "Lander")

hello.person2(123, "Lander") 
# - 2개 인수중 어느 하나를 숫자로 입력하면 문자로 변환됨

hello.person2(123, 2234) 
# - 2개 인수 모두 숫자입력했지만 sprint에 의해서 문자열로 바뀜

# --------------------------------------------------
## 사용자정의함수(3): 인수 2개설정 & 디폴트 인수1개설정

hello.person3 <- function(first, last = "Doe") {
  print(sprintf("Hello, %s %s!", first, last))
}

hello.person3()
hello.person3("Jared")
hello.person3("Lander")

hello.person3("Jared", "Lander")
hello.person3("Lander", "Jared")

hello.person3(first = "Jared", last = "Lander")
hello.person3(first = "Jared")
hello.person3(fir = "Jared")
hello.person3(last = "Lander")
hello.person3(l = "Lander")

# --------------------------------------------------
## 사용자정의함수(4): 인수 2개설정 & 미정의 인수 1개 설정

hello.person3("Jared", "Lander", extra = "Goodbye")
hello.person3("Jared", "Lander", "Goodbye")

hello.person4 <- function(first, last = "Doe", ...) {
  print(sprintf("Hello, %s %s!", first, last))
}

hello.person4("Jared", "Lander", extra = "Goodbye")
hello.person4("Jared", "Lander", "Goodbye")

# --------------------------------------------------
## 현재까지 생성되어 메모리에 로딩된 사용자정의함수 조회
ls() # 메모리상의 전체 객체목록 조회
ls(pattern = "hello") 
# - 메모리상의 전체 객체목록 중 "hello"라는 이름을 가진 객체만 출력

########################################################################
## 사용자정의함수의 자동화 사용(1)

## do.call 함수의 이용
do.call("hello.person2", args = list(first = "Jared", last = "Lander"))
do.call(hello.person2, args = list(first = "James", last = "Bond"))

## 학생명부 데이터프레임 생성
f.name <- c("John", "Ang", "Bull", "David", "Janice", 
            "Cheryl", "Reuven", "Greg", "Joel", "Mary")
l.name <- c("Da", "ela", "winkle", "Jones", "Markhammer",
            "Cushing", "Ytzrhak", "Knox", "England", "Rayburn")
math <- c(502, 600, 412, 358, 495, 512, 410, 625, 573, 522)
science <- c(95, 99, 80, 82, 75, 85, 80, 95, 89, 86)
english <- c(25, 22, 18, 15, 20, 28, 15, 30, 27, 18)
roster <- data.frame(f.name, l.name, math, science, english, 
                     stringsAsFactors=FALSE)
roster


## 학생성명들을 성과 이름으로 분리한 데이터를 입력해 사용자정의함수를 자동반복시
do.call(hello.person2, 
        args = list(first = roster$f.name, 
                    last = roster$l.name))

########################################################################
## 사용자정의함수의 자동화 사용(2)

# 일련의 데이터와 원하는 R함수를 인수값으로 입력하면 계산이 되도록 
calc <- function(x, func = mean) {
  do.call(func, args = list(x))
}

calc(1:10)
calc(1:10, mean)
calc(1:10, sum)
calc(1:10, sd)

### End of Code ########################################################
