# 1장 다변량 분석 기초 : 결측값 대치

# airquality 자료에 대해 결측값 대치를 수행한다.
### {mice} 패키지는 결측값에 대해 특별히 고안된 분포로부터 타당한 자료를 추출하여 대치값으로 사용 
dim(airquality) # 핼, 열의 수
air <- airquality[, 1:4] # 변수 4개(Ozone, Solar.R, Wind, Temp)로 제한
air[11:15, 3] <- NA # 결측값 추가
air[51:55, 4] <- NA # 결측값 추가
summary(air) # 결측값 추가
dim(air) # 핼, 열의 수


# {mice}패키지의 md.pattern() 함수를 사용하여 변수별 결측값의 수와 결측값의 형태를 파악
### 왼쪽 숫자 : 각 패턴이 바료에 몇 개 있는지
### 오른족 숫자 : 각 패턴에서 결측값 수
### 아래 숫자 : 각 변수의 결측값 수
library(mice)
md.pattern(air) # missing data pattern


# {VIM} 패키지를 사용하여 aggr(), marginplot() 함수를 사용하여 결측값 패턴을 시각화 하는데 유용하다.
### aggr() 함수 : 결측(/대치)값에 대한 집계를 제공
### col=c('1번','2번') : 참(1)일 때 1번 색상, 거짓(2)일 때 2번 색상
library(VIM)
aggr(air, col=c('skyblue','red'), numbers=TRUE, sortVars = TRUE, labels=names(air), cex.axis=.7, gap=3, 
     ylab=c("Percentage of missing", "Missing Pattern"))


# marginplot() 함수 : 변수 쌍에 대한 산점도와 함께 결측(/대치) 값에 대한 정보를 마진에 그림으로 제공
marginplot(air[c(1,2)])


# {mice}패키지의 mice()함수를 이용하여 다변량 자료의 결측값에 대해 다중 대치 수행
### m = 5 : 다중 대치 수를 5개로 지정
### mathod = "pmm", "logreg", "ployreg", "plor"
### pmm : 수치형 변수의 경우 디폴트
### logreg : 이진(수준이 2개인) 변수에 대한 디폴트
### ployreg : 요인(수준이 3개 이상인) 변수에 대한 디폴트
### plor : 2개 이상의 순서형 변수에 대한 디폴트
library(mice)
air.m <- mice(air, m=5, maxit=50, meth='pmm', seed=200)
ls(air.m) # air.m 값이 가지고 있는 $ 메소드를 보여준다.
summary(air.m)


# complete() 함수를 이용하여 결측값 대치 후 완비 자료 출력(5개중 첫 번째 사용)
air.com <- complete(air.m, 1)
summary(air.com)


# 원 자료와 대치된 자료의 분포 비교하는 방법 소개. 
xyplot(air.m, Ozone ~ Wind+Temp+Solar.R, pch=18, cex=1)
densityplot(air.m)
stripplot(air.m, pch=20, cex=1.2)


# 다중 대치에 의한 여러 개의 완비 데이터 셋별로 특정모형 적합한 뒤, 이를 결합하는 방법 제시.
fit1 <- with(air.m, lm(Temp ~ Ozone+Solar.R+Wind))
summary(pool(fit1))
air.m2 <- mice(air, m=50, seed=500)
fit2 <- with(air.m2, lm(Temp ~ Ozone+Solar.R+Wind))
summary(pool(fit2))