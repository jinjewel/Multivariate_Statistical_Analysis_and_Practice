# 4장 고전적 다변량 분석에 대한 가정 검토 : 다변량 정규성 검정

# 변수에 대한 정규성 검정을 수행한다.
### install.packages("MVA") 
library(MVA) # USairpollution 데이터 때문에
data(USairpollution)


# Q-Q플롯 즉, qqnorm()함수, qqline()함수를 사용하여 검정
### {MVA}패키지에 USairpollution자료 중 SO2 데이터를 사용
### 점들이 직선으로부터 크게 멋어나므로 정규성을 만족하지 않는다.
qqnorm(USairpollution$SO2) # USairpollution의 SO2 데이터를 사용
qqline(USairpollution$SO2) # 이 직선과 가까이 있으면 정규분포와 비슷하다고 볼 수 있다.


# shapiro.test()함수를 사용하여 Shapiro-Wilk 정규성 검정을 수행, 입력자료는 수치형 벡터이다.
### p-value(9.723e-06)가 매우 작으므로 귀무가설(정규분포를 따른다.)을 기각한다.
### 그 외 정규성 검정을 위한 여러 함수는 {nortest}패키지에서 제공된다.
shapiro.test(USairpollution$SO2) 


# 다변량 정규성데 대한 Shapiro-Wilk 검정
### {mvnormtest}패키지의 mshapiro.test()함수를 사용하여 다변량 Shapiro-Wilk 검정
### p-value(2.025e-09)가 매우 작으므로 귀무가설(다변량 정규분포를 따른다.)를 기각한다.
# install.packages("mvnormtest") 
library(mvnormtest) # mshapiro.test 함수 사용 
mshapiro.test(t(as.matrix(USairpollution))) 


# 다변량 정규성 검정
### X가 정규분포가 N(mu, sigma)를 따를 때, x와 mu사이의 마할라노비스 제곱거리는 자유도가 p인 카이제곱분포를 따른다.
### 이 사실을 이용하여 다변량 정규성을 평가하는 Q-Q 플롯, 즉 카이제곱그림을 사용
x <- as.matrix(USairpollution) # n x p 수치형 행렬로 선언
n <- nrow(x) # 행의 개수
p <- ncol(x) # 열의 개수
d <- mahalanobis(x, colMeans(x), cov(x)) # 마할라노비스 제곱거리
qqplot(qchisq(ppoints(n),df=p), d, main="QQ Plot Assessing Multivariate Normality", ylab="Mahalanobis D2")
abline(a=0, b=1)