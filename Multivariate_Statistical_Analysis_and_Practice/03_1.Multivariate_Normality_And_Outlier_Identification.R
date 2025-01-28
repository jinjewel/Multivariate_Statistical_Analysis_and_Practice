# 3장 다변량 정규분포와 응용 : 마할라노비스 제곱거리와 활용

# 카이제곱그림을 그리고, 다변량 정규성과 다변량 이상치 파악
### 데이터 생성
### {MVA}패키지를 통해서 USairpollution 데이터를 사용
### 미국의 41개 도시의 공기오염 자료이고, 
### 변수는 SO2(이산화황), temp(연평균 기온), manu(제조공장의 수), popul(인구), wind(연평균 풍속), precip(연평균 강우량), predays(연평균 강우일)이다.
library(MVA)
data(USairpollution)
str(USairpollution)
head(USairpollution)


# 마할라노비스 제곱거리 계산
### bw인수는 대역폭을 설정할 수 있으며, 대역폭이 크면 밀도 곡선이 평활해지고 작으면 과소적합(과적합)됩니다.
D2 <- mahalanobis(USairpollution, colMeans(USairpollution), cov(USairpollution))
plot(density(D2, bw=0.5)); 
### x축에 1차원 플롯을 풀롯에 추가한다.
rug(D2)


# 카이제곱 그림
### ppoint() 함수는 (난수발생에 필요한) 확률점의 수열을 발생시킴
qqplot(qchisq(ppoints(100), df=7), D2) # 변수가 7개라 df=7로 설정
abline(0, 1, col="gray")
sort(D2)


# 종유석 그림
### {MVA}패키지의 stalac()함수를 이용하여 종유석 그림을 그린다.
stalac(USairpollution)


# 이변량 자료의 이상치 탐색을 위해서는 이변량 상자그림을 이용할 수 있다.
### {MVA}패키지의 bvbox()함수를 사용하여 이변량 상자그림을 그릴 수 있다.
### {asbio}패키지의 bv.boxplot()함수를 사용하여 이변량 상자그림을 그릴 수 있다.
bvbox(USairpollution[, c("manu", "popul")]) # 평범한 이변량 상자그림
bvbox(USairpollution[, c("manu", "popul")], type="n") # 데이터 표시가 없는 이변량 상자그림
text(USairpollution[, c("manu", "popul")], labels=rownames(USairpollution)) # 데이터 표시를 데이터 이름으로 이변량 상자그림