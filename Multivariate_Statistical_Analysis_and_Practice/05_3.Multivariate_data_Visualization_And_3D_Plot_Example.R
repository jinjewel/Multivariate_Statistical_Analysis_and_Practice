### 3~5장 연습문제

### 1번
## 데이터 생성
library(HSAUR2)
str(household)

## (a) 평행좌표그림을 통해 비교
# {lattice}패키지의 parallelplot()함수를 이용
library(lattice)
parallelplot(~ household[,1:4]|household$gender)
# (해석) : 여성보다 남성의 가계 지출이 다양하고 많음을 보여준다.
# (해석) : 특히, 음식 품목에서 여성과 남성간의 차이가 큼을 볼 수 있다.

## (b) 상자그림을 통해 비교
# y축을 고정시키지 않고 그린 상자그림 비교 
par(mfrow=c(1,2))
boxplot(household[1:20,1:4], main="female")
boxplot(household[21:40,1:4], main="male")

# y축을 고정시키고 그린 상자그림 비교 
par(mfrow=c(1,2))
boxplot(household[1:20,1:4], ylim=c(0,6000), main="female")
boxplot(household[21:40,1:4], ylim=c(0,6000), main="male")
par(mfrow=c(1,1))
# (해석) : y축을 고정시키지 않았을 때는 대충 남자가 더 지출이 많아 보이는 것을 알 수 있었다.
# (해석) : y축을 고정시키고 비교해봤을 때, 지출 내용이랑 가격의 폭은 남자가 더 다양하지만
# (해석) : 음식 품목에서 여성의 이상치 값이 더 많은 것까지 확인할 수 있었다.


## (c) 별그림을 그려 비교
# 평범한 별그림 
stars(household[,1:4], col.line=1:nrow(household[,1:4]),main="1~20 : female, 21~40 : male")
# (해석) : 초반 데이터(여성)에 비해서 후반 데이터(남성)의 넓이가 더 크다.

# 나이팅게일 차트
# key.loc=c(14, 1.5) : 우측 하단에 원형으로 되어있는 설명부를 표시한다.
# draw.segments = TRUE : 각 데이터에 색상을 지정한다.
stars(household[,1:4], key.loc=c(14, 1.5), draw.segments = TRUE)
# (해석) : 초반 데이터(여성)에 비해서 후반 데이터(남성)의 넓이가 더 크다.

# 레이더플롯
stars(household[,1:4], location=c(0, 0), col.lines=household$gender, key.loc=c(0,0))
# (해석) : 검정(여성)보다 대체적으로 회색(남성)일때 값들이 크다.



## (d) 버블차트를 그려 비교
par(mfrow=c(2,2))
symbols(household$housing, squares=household$gender, fg=household$gender)
symbols(household$food, squares=household$gender, fg=household$gender)
symbols(household$goods, squares=household$gender, fg=household$gender)
symbols(household$service, squares=household$gender, fg=household$gender)
# (해석) : 모든 변수에서 검정(여성)데이터보다 남성(빨강)데이터가 더 큰 값을 보인다.
par(mfrow=c(1,1))



### 2번
## 데이터 생성
library(HSAUR2)
str(heptathlon)



## (a) 적절한 시각화를 통한 자료 분석
# matplot() 함수사용
par(mfrow=c(1,2))
matplot(heptathlon[,1:7])
matplot(heptathlon[,1:8])
par(mfrow=c(1,1))
# (해석) : 대체적으로 hurdles, shot데이터를 제외한 모든 변수들의 값 범위가 나뉘어져 있다.

# 평행좌표그림
library(lattice)
parallelplot(heptathlon[,1:8], horizontal.axis=F)
# (해석) : hurdles, highjump, run800m 데이터는 한쪽에 몰려있다.
# (해석) : 그에 비해 shot, run200m, longjump, javelin 데이터는 전체적으로 퍼져있다.



## (b) 시각화를 통한 상관분석을 실시
# 상관분석 실시
round(cor(heptathlon),2)
# (해석) : javelin 변수가 다른 변수들과 대부분 상관이 없다고 보인다.



## (c) 다변량 이상치를 식별하라
library(MVA)
stalac(heptathlon)
# (해석) : Dimitrova(BUL)와 Launa(PNG) 두 변수가 이상치를 식별되었다.



## (d) 다변량 정규성을 검토
# 그림으로 정규성 검토
D2 <- mahalanobis(heptathlon, colMeans(heptathlon), cov(heptathlon))
qqplot(qchisq(ppoints(100), df=ncol(heptathlon)), D2) # 변수가 7개라 df=7로 설정
abline(0, 1, col="gray")
# (해석) : 자료가 직선에 떨어져 있으므로 정규분포를 따르지 못한다고 할 수 있다.

# 검정으로 정규성 검토
library(mvnormtest)
mshapiro.test(t(as.matrix(heptathlon)))
# (해석) : P-value 값이 매우 작으므로 귀무가설 (H0 : heptathlon은 정규분포를 따른다)을 기각



### 3번
## 데이터 생성
library(HSAUR2)
str(CHFLS)



## (a) 지역별로 여성과 배우자 소득의 자료를 시각화를 통해 비교
income <- CHFLS[,c("R_region","R_income","A_income")]
library(lattice)
parallelplot(~ income[,2:3]|income$R_region)
# (해석) : 대체적으로 inlands에 살고있는 사람들의 소득이 적고
# (해석) : 여성과 배우자 사이의 소득차이가 가장 적다.



## (b) 여성의 학력별로 여성과 배우자 소득 간의 관련성에 대한 시각화 분석
# 데이터 생성
edu <- CHFLS[,c("R_edu","R_income","A_income")]
str(edu)

# parallelplot()함수를 이용한 그림
library(lattice)
parallelplot(~ edu[,2:3]|edu$R_edu)

# 학력별 여성과 배우자 각각의 소득 분산의 동질성 검정 수행
bartlett.test(edu$R_income ~ edu$R_edu, data=Elementary_edu[,1:2]) 
# (해석) : p값이 매우작아서 귀무가설(학력별 여성의 소득은 모두 같다)을 기각한
bartlett.test(edu$A_income ~ edu$R_edu, data=Elementary_edu[,c(1,3)]) 
# (해석) : p값이 매우작아서 귀무가설(학력별 배우자의 소득은 모두 같다)을 기각한

# 학력에 따른 데이터 분류
Elementary_edu <- edu[edu$R_edu=='Elementary school',]
Junior_high_edu <- edu[edu$R_edu=='Junior high school',]
Senior_high_edu <- edu[edu$R_edu=='Senior high school',]
Junior_college_edu <- edu[edu$R_edu=='Junior college',]
Never_attended_edu <- edu[edu$R_edu=='Never attended school',]
University_edu <- edu[edu$R_edu=='University',]

# 학력별 여성과 배우자 사이의 관련성 검정
cor(Elementary_edu$R_income, Elementary_edu$A_income)
cor(Junior_high_edu$R_income, Junior_high_edu$A_income)
cor(Senior_high_edu$R_income, Senior_high_edu$A_income)
cor(Junior_college_edu$R_income, Junior_college_edu$A_income)
cor(Never_attended_edu$R_income, Never_attended_edu$A_income)
cor(University_edu$R_income, University_edu$A_income)
# (해석) : 각 학력별로 여성과 배우자 사이의 상관계수를 보아 관련이 높은 관계는 없다고 볼 수 있다.



## (c) 배우자에 교육수준에 따라 여성과 배우자의 소득의 상관성을 시각화
in_ed <- CHFLS[,c("A_edu","R_income","A_income")]
library(lattice)
parallelplot(~ in_ed[,2:3]|in_ed$A_edu)
# (해석) : 학력이 높은 순서대로 여성과 배우자의 소득이 많아지며
# (해석) : 대부분의 학력에서 여성보다 배우자의 소득이 대체적으로 높은 것을 볼수 있다.




### 4번
rm(list=ls())
## 데이터 생성
library(HSAUR2)
heptathlon_sub <- heptathlon[,c('longjump','hurdles')]
str(heptathlon_sub)

## (a) 두 변수 간의 산점도를 그리고 이변량 정규분포를 적합
# 두 변수의 산점도
plot(heptathlon_sub$longjump, heptathlon_sub$hurdles)
# 두 변수의 이변량 정규분포
install.packages("mvtnorm")
library(mvtnorm)
dmvnorm(heptathlon_sub, colMeans(heptathlon_sub), cov(heptathlon_sub))



## (b) 적합된 이변량 정규분포를 산점도 위에 추가
norm2_function <- function(x,y){
  dmvnorm(cbind(x,y), mean=c(mean(heptathlon_sub$longjump), mean(heptathlon_sub$hurdles)), cov(heptathlon_sub))
}
contour(x_lim, y_lim, outer(x_lim, y_lim, norm2_function), add=T, col='purple')



## (c) 이변량 상자그림을 통해 이상치에 속하는 선수를 판별
library(MVA)
bvbox(heptathlon_sub,xlab="longjump",ylab="hurdles")




## (d) 적합된 이변량 정규분포의 밀도함수
persp(x_lim, y_lim, outer(x_lim, y_lim, norm2_function), theta=15, phi=30, xlab="longjump", ylab="hurdles", zlab="fun(longjump,hurdles)")










