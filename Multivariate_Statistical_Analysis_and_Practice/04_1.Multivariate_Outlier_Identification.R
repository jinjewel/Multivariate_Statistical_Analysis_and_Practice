# 4장 고전적 다변량 분석에 대한 가정 검토 : 다변량 이상치 식별

# {MVA}USairpollution 자료에 대해 다변량 이상치를 탐색한다.
### 데이터 생성
### {MVA}패키지에 USairpollution자료를 사용
### install.packages("MVA") 
library(MVA) # USairpollution 데이터 때문에


# 분위수그림
### {mvoutlier}패키지의 aq.plot()함수를 사용하여 수정된 분위수그림을 그릴수 있다.
### x : 행렬 또는 데이터 프레임
### delta : 그림에 표시될 카이제곱 분위수 값 지정
### quan = MCD 추렁량에 사용되는 관측값의 비율 지정(0.5 ~ 1)
### 좌상 : 자료를 두개의 로버스트 주성분 축에 사영한 그림
### 우상 : 카이제곱분포의 분포함수(붉은선)과 카이제곱 분위수(디폴트 0.975)와 수정된 분위수에 대응하는 2개의 수직선
### 좌하 : 지정된 분위수에 의해 탐지된 이상치
### 우하 : 수정된 분위수에 의해 탐지된 이상치
# install.packages("mvoutlier")
library(mvoutlier) # aq.plot 함수
summary(USairpollution)
data(USairpollution)
aq.plot(USairpollution, delta=qchisq(0.975, df=ncol(USairpollution)), quan=1/2, alpha=0.05)
### 추가적으로 aq.plot()함수의 옵션으로 quan=1을 사용하면 3개의 도시만이 이상치로 탐지된다.
outliers <- aq.plot(USairpollution) # quan = 1/2(디폴트)
outliers # 이상치 목록
par(mfrow=c(1,1))
