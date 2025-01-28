# 10장 인자분석 : 구조방정식모형과의 비교

# 데이터 불러오기
### biology(BIO), geology(GEO), chemistry(CHEM), algebra(ALG), calculus(CALC), statistics(STAT) 6과목
### 각 항목은 1(아주 싫어함)부터 5(아주 좋아함)의 값을 가진다.
subjects <- read.csv("C:/Users/User/Desktop/다변량통계 분석 및 실습/다변량 R 실습자료/subjects.csv", head=T)
head(subjects, 3)


# 상관계수 행렬 
options(digits=3) # 출력되는 소수점 자리수를 3개로 지정한다.
corMat <- cor(subjects) # 상관행렬 구하기
corMat


# 구조방정식 모형과의 비교
### [예제1]의 자료에 대해 SEM 모형의 적합 결과를 소개하면 다음과 같다.
### {sem}패키지를 이용하여 SEM 모형을 적합한다.
### 이 모형은 두 개의 미 관측 잠재변수(F1, F2)가 있어, 6개의 변수에 영향을 미치는 구조이다.
### X1, X2, X3에 미치는 F1의 부하는 lam1, lam2, lam3이고, X4, X5, X6에 미치는 F2의 부하는 lam4, lam5, lam6이다.
### 양방향 화살표는 두 잠재변수 간의 공분산을 나타난다.(F1F2)
### e1 ~ e6는 잔차분산(두 잠재변수에 의해 설명되지 않는 관측변수의 분산)을 나타낸다.
### F1과 F2의 분산을 1로 고정하여, 모수들의 크기가 의미를 가지도록 한다.(이로써 F1F2가 두 잠재변수 간의 상관 계수가 된다.)
### {sem}패키지는 관측변수의 공분산을 요구한다.
### specifyModel() 함수를 이용하여 CFA 모형을 구체적으로 지정한다.
### 형식은 화살표 지정, 모수명, 초깃값으로 구성된다.
### 초깃값에서 NA는 분석자가 특별히 지정하지 않음을 나타낸다.
### F1과 F2의 분산은 1로 고정한다.(두번째 열은 NA임)
# install.packages("sem")
library(sem)
names(subjects) <-c("X1", "X2", "X3", "X4", "X5", "X6")
names(subjects)
mydata.cov <- cov(subjects)
model.mydata <- specifyModel()
### 아래의 있는 15개의 줄을 콘솔창에 입력
# F1 ->  X1, lam1, NA
# F1 ->  X2, lam2, NA
# F1 ->  X3, lam3, NA
# F2 ->  X4, lam4, NA
# F2 ->  X5, lam5, NA
# F2 ->  X6, lam6, NA
# X1 <-> X1, e1,   NA
# X2 <-> X2, e2,   NA
# X3 <-> X3, e3,   NA
# X4 <-> X4, e4,   NA
# X5 <-> X5, e5,   NA
# X6 <-> X6, e6,   NA
# F1 <-> F1, NA,    1
# F2 <-> F2, NA,    1
# F1 <-> F2, F1F2, NA
### SEM 모형 적합 : 아래 sem()함수에서 인수는 차례대로 모형, 공분산행렬, 자료수임
mydata.sem <- sem(model.mydata, mydata.cov, nrow(subjects))
## 결과 출력(fit indices, paramters, hypothesis tests)
summary(mydata.sem)
### 표준화 계수(부하) 출력
### 위의 결과를 [예제1]의 인자분석 결과와 비교하여 설명하면 다음과 같다. 
### 결과에서 1~3열(lam1~lam3)과 4~6열(lam4~lam6)의 추정치는 회전 후 PA1, PA2 부하(량)와 유사하고, 
### 7열~12열(e1~e6)의 추정치는 특정분산과 유사함을 알 수 있다. 
stdCoef(mydata.sem)