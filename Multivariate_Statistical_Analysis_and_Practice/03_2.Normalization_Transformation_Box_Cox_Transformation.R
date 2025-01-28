# 3장 다변량 정규분포와 응용 : 정규화변환_ 박스콕스변환

# 박스-콕스 정규화 변환
x <- rexp(1000) # 지수분포로부터 난수발생
par(mfrow=c(1,2))
hist(x) # histgram 그림
qqnorm(x) # 정규확률그림
par(mfrow=c(1,1))


# 박스-콕스 정규화를 위한 로그-가능도 프로파일
### {MASS}패키지의 boxcox()함수를 이용하여 람다를 추정하는 그래프를 출력
library(MASS)
boxcox(x~1) # 로그-가능도 프로파일, 람다를 추정하는 그래프 출력


# 박스-콕스 변환의 모수 추정
### {car}패키지의 box.car.power()함수를 이용하여 박스-콕스 변환의 모수 추정.
### {car}패키지의 powerTransform()함수를 이용하여 박스-콕스 변환의 모수 추정.
library(car)
p <- powerTransform(x) # 박스-콕스 변환의 모수 추정.
p
names(p) # p에서 사용할수 있는 메소드 출력


# 박스-콕스 정규화 변화
### {car}패키지의 box.car()함수를 이용하여 박스-콕스 변환
##3 {car}패키지의 bcPower()함수를 이용하여 박스-콕스 변환
y <- bcPower(x, p$lambda) # 박스-콕스 변환
par(mfrow=c(1,2))
hist(y)
# 변환된 자료는 정규분포를 따르게 되었고, qqplot를 적합해본 결과 정규화가 잘 됬음을 확인 가능하다.
qqnorm(y)
par(mfrow=c(1,1))