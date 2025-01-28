# 14장 군집분석 : k-평균군집

# k-평균군집을 수행하는 R 함수는 다음과 같다.
### {stats}kmeans()함수, {flexclust}kcca()함수, {flexclust}cclust()함수, {cclust}cclust()함수, {amap}Kmeans()함수 등이 있다.
### 계층적 군집과는 달리 k-평균군집은 군집의 수를 미리 정해주어야 한다.
### {Nbclust}패키지를 통해 적절한 군집의 수에 대한 정보를 얻을 수 있다.
### 군집 수에 따른 집단-내 제곱합(wss)의 그래프를 그려보는 것도 군집 수를 정하는데 도움이 된다.


# wssplot() 사용자 지정함수
### 임의로 선택되는 초깃값의 따라 결과가 달라지는 것을 없애기 위해서  set.seed()를 사용
## nstart= 옵션은 다중 초깃값에 대해 k-평균군집을 수행하고 그 가운데 최적의 결과를 제시(종종 nstart=25를 추천)
### data : 수치형
### nc : 고려할 군집의 최대 수
### seed : 난수발생 초깃값
wssplot <- function(data, nc=15, seed=1234){
  wss <- (nrow(data)-1)*sum(apply(data,2,var))
  for (i in 2:nc){
    set.seed(1234)
    wss[i] <- sum(kmeans(data, centers=i)$withinss)
  }
  plot(1:nc, wss, type="b", xlab="Number if Clusters", ylab="Within groups sum of squares")
}


# 데이터 선언
### 178개 이탈리안 와인에 대해 13가지의 화학적 성분을 측정한 자료이다.
### UCI Machine Learning Repository에서 wine 데이터셋 다운로드
# install.packages("rattle")
data(wine, package="rattle")
head(wine)


# 군집의 수 결정 - wssplot() 함수 사용
### 변수의 측정 단위가 매우 다르므로 군집분석을 수행하기 전에 scale() 함수를 이용하여 표준화를 수행하고
### 적절한 군집의 수를 정하기 위해 앞서 소개한 wssplot()함수를 수행한다.
### (해석) 군집 수 3에서 오차제곱합이 크게 감소되었음을 확인 할 수 있다.
df = scale(wine[-1])
wssplot(df)


# 군집의 수 결정 - {Nbclust}패키지의 Nbclust()함수 사용
### (해석) 최적의 군집수를 정하기 위해 사용되는 지수(총30개 중 여기서는 26개의 지수가 계산됨) 가운데
### 15개의 지수가 3을 최적의 군집 수로 투표한 결과를 보여준다.
# install.packages("NbClust")
library(NbClust)
set.seed(1234)
nc <- NbClust(df, min.nc=2, max.nc=15, method="kmeans")
table(nc$Best.n[1,])
barplot(table(nc$Best.n[1,]), xlab="Number of Clustsers", ylab="Number of Criteria", main="Number of Clusters Choosen by 26 Criteria")


# 군집화 - kmeans()함수 사용
### 군집의 수를 3으로 하여 kmeans() 함수를 수행한 결과는 다음과 같다.
### 각 군집의 크기와 중심값을 보여준다.
set.seed(1234)
fit.km <- kmeans(df, 3, nstart=25)
fit.km$size
fit.km$centers
### 군집결과의 시각화는 plot() 함수를 이용한다.
plot(df, col=fit.km$cluster)
points(fit.km$centers, col=1:3, pch=8, cex=1.5)


# 군집결과의 요약 - (표준화된 자료에 대한) 군집 결과를 원자료의 단위로 전환
### 각 군집별로 변수의 요약값을 측정단위의 척도로 나타내면 다음과 같다.
aggregate(wine[-1], by=list(cluster=fit.km$cluster), mean)
### k-평균군집의 결과에 대한 정오분류표를 제시
ct.km <- table(wine$Type, fit.km$cluster)
ct.km


# 군집 결과의 성능: 일치도 지수(ARI)
### {flexclust}패키지의 randlndex() 함수를 이용하면 실제 와인의 종류(Type)와 군집 간의 일치도를 나타내는 수
### 정된 랜드 지수(ARI)를 구할 수 있다.
### 여기서 '수정된'의 의미는 우연에 의해 발생되는 경우를 고려한 값이다.
### 이 지수는 -1(완전불 일치)과 1(완벽한 일치) 사이의 값을 가진다.
# install.packages("flexclust")
library(flexclust)
randIndex(ct.km)


# k-평균군집를 수행하는 R함수 
### {flexclust}패키지의 kcca() 함수는 k-평균군집을 수행한다.
### kcca() 함수의 적용결과는 다음의 함수 등을 통해 시각화 할 수 있다.
### {flexclust}패키지의 image() 함수, {graphics}패키지의 barplot() 함수,
### {lattice}패키지의 barchart()함수, {flexclust}패키지의 stripes() 함수


# 데이터 선언
### 서로 다른 4개의 이변량 정규분포로부터 발생된 난수로 구성된 자료이다.
# install.packages("flexclust")
library(flexclust)
data("Nclus")
plot(Nclus)


# k-평균군집 수행 - kcca() 함수 사용
### family = 옵션을 이용하여 "kmeans", "kmedians", "angle", "jaccard", "ejaccard" 방법을 이용할 수 있다.
cl <- kcca(Nclus, k=4, family=kccaFamily("kmeans"))


# 군집 결과의 시각화
image(cl)
points(Nclus)
### (해석) 각 군집의 (변수별) 중심이 전체 군집의 중심(상자 안의 점)으로부터 얼마나 벗어나 있는지를 나타낸다.
barplot(cl)
### (해석) 줄무늬를 이용하여 각 군집 내의 자료들이 해당 군집의 평균으로부터 얼마나 떨어져 있는지를 나타낸다.
stripes(cl)


# {cclust}패키지의 cclust() 함수를 이용하여 k-평균군비을 수행한다.
### cclust() 함수는 볼록한 군집을 수행하는 함수로, {flexclust}패키지의 cclust() 함수와 기능이 똑같다.
### 에제5와 동일한 자료로 분석을 진행한다.
### method = 옵션에는 "kmeans", "hardcl", "neuralgas"가 있다
### "kneams"는 고전적인 kmeans알고리즘을 사용하며
### "hardcl"은 hard competitive learning 방법을
### "neuralgas"은 이와 유사한 neural gas 알고리즘을 사용한다.
install.packages("cclust")
library(cclust)
cl.1 <- cclust(Nclus, 4, iter.max=20, method="kmeans")
plot(Nclus, col=cl.1$cluster)
points(cl.1$center, col=1:4, pch=8, cex=1.5)


# {cluster}의 clusplot() 함수는 2차원의 군집 그래프를 제공
### clusplot을 이용하면 군집의 반경과 관계까지 확인하여 볼 수 있다.
library(cluster)
clusplot(Nclus, cl.1$cluster)