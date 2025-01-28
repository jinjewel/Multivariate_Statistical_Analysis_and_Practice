# 4장 고전적 다변량 분석에 대한 가정 검토 : 분산과 공분산의 동질성 검정

# {datasets}InsectSprays 자료에 대해 분산의 동질성 검정
### 데이터 생성
### {datasets}패키지의 InsectSprays 자료 사용
### InsectSprays 데이터 : 벌레를 잡는데 사용하는 스프레이의 데이터 셋
head(InsectSprays)
summary(InsectSprays)


# 상자그림 사용
### 자료에 대한 기초분석을 수행
boxplot(count ~ spray, data=InsectSprays) # C가 효율이 가장 낮다는 것을 알 수 있음.


# 평균-표준편차그림 사용
### 상자그림의 대안적인 유용한 그림으로 '평균-표준편차그림'을 사용
### {plotrix}패키지의 plotCI()함수를 이용하여 '평균-표준편차그림'을 수행
# install.packages("plotrix")
library(plotrix)
### InsectSprays데이터에서 count를 spray별로 mean을 구하여 이어붙여(with함수) 반환한다.
means <- with(InsectSprays, tapply(count, spray, mean))
### InsectSprays데이터에서 count를 spray별로 sd을 구하여 이어붙여(with함수) 반환한다.
stds <- with(InsectSprays, tapply(count, spray, sd))
plotCI(1:6, means, stds, xlab="spray")
lines(1:6, means)


# 분산의 동질성 검정
### bartlett.test()함수는 K-표본에서 분산의 동질성에 대해 모수적 검정을 제공
### fligner.test()함수는 비모수적 검정을 제공한다.
### p값(9.085e-05)이 매우작아서 귀무가설(그룹별 분산은 모두 같다)을 기각한다.
bartlett.test(count ~ spray, data=InsectSprays) 
### p값(0.01282)이 작아서 귀무가설(그룹별 분산은 모두 같다)을 기각한다.
fligner.test(count ~ spray, data=InsectSprays) 


# 분산의 동질성 검정
### {HH}패키지의 hov()함수를 사용하여 분산의 동질성 검정을 제공
### 중앙값의 절대편차에 대해 일원배티법을 적용하는 F검정을 사용한다.
# install.packages("HH")
library(HH) # hov함수 사용
hov(count ~ spray, data=InsectSprays)
hovPlot(count ~ spray, data=InsectSprays)