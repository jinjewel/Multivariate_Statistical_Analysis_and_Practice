# 14장 군집분석 : 계층적 군집
rm(list=ls())

# 데이터 선언
### USArrests자료는 미국 50개 주에서 1973년에 발생한 폭행, 살인, 강간 범죄를 주민 100,000명당 
### 체포된 사람의 통계자료이다. 주별 전체 인구에 대한 고시의 인구 비율을 함께 제공한다.
data(USArrests)
str(USArrests)


# 계층적 군집 수행
### dist()함수는 거리 또는 비 유사성 행렬을 제공하는 함수로 method를 통해 다양한 거리를 정의할 수 있다.
### method= 옵션에는 "euclidean", "maximum", "manhattan", "binary", "minkowski" 등이 있다.
### hclust()함수는 계층적 군집분석을 수행하는 함수로 method= 옵션을 통해 병합 방법을 지정할 수 있다.
### method= 옵션에는 "ward", "single", "complete", "average", "centroid" 등이 있다.
d <- dist(USArrests, method="euclidean") # 주들간의 유클리드 거리 계산
fit <- hclust(d, method="ave") # 계층적 군집분석


# 덴드로그램으로 시각화
### plot()함수를 통해 계층적 군집분석의 결과를 덴드로그램으로 시각화 할 수 있다.
par(mfrow=c(1,2))
plot(fit) # 덴드로그램 시각화
plot(fit, hang=-1) # 덴드로그램 시각화, hang=-1은 label의 위치를 지정
par(mfrow=c(1,1))


# cutree()함수를 계층적 군집의 결과를 이용하여 
### tree의 높이(h)나 그룹의 수(k)를 옵션으로 지정하여 원하는 수의 그룹으로 나눌 수 있다. 
groups <- cutree(fit, k=6) # 6개 군집으로 변수들을 나열
groups


# plot() 함수로 그린 덴드로그램은 
### rect.hclust() 함수를 이용하여 그룹을 사각형으로 구분지어 나타낼 수 있다.
### 위에서 cutree()함수로 나누어진 그룹과 동일함을 확인할 수 있다.
plot(fit)
rect.hclust(fit, k=6, border="red") # 덴드로그램에서 6개의 군집으로 나눈 것을 빨간색 테두리로 표시


# rect.hclust() 함수는 그룹의 수(k)를 이용하여 그룹을 시각화할뿐 아니라, 
### tree의 높이(h)와 위치(which)를 이용하여 그룹의 전체 또는 일부를 나타낼 수 있다.
### 높이(h) 50에서 cut 수행, 2와 7번에 사각형 추가, 테두리 색상(border) 지정
hca <- hclust(dist(USArrests))
plot(hca)
rect.hclust(hca, k=3, border = 3:4)
rect.hclust(hca, h=50, which=c(2,7), border = 3:4) # 덴드로그램에서 높이를 기준으로 군집하고, 해당번째 군집만 borber 표시


# {cluster}패키지의 agnes() 함수는 계층적 군집방법 중 병합적 방법을 이용하여 분석한다.
### metric= 옵션을 통해 "euclidean", "manhattan" 등의 거리를 지정할 수 있으며,
### method= 옵션을 통해 병합방법을 지정할 수 있다.
### metric= 옵션을 이용하지 않고 daisy() 함수를 이용하여 거리를 계산할 수도 있다.
### daisy() 함수는 데이터 관측값 사이의 거리를 계산해주며, 
### 자료의 형태가 수치형일 필요가 없다는 점에서 dist()함수보다 유연하다.


# agnes()함수를 이용하여 계층적 군집을 수행
### USArrests 자료에 대해 agnes()함수를 이용하여 계층적 군집을 수행한다.
### agnes() 함수에서 stand=TRUE는 비유사성(거리)의 계산 전에 표준화를 수행함.
### 입력 자료가 비유사성 행렬인 경우에는 무시됨.
library(dplyr)
library(cluster)
agn1 <- agnes(USArrests, metric="manhattan", stand=TRUE) # 계층적 군집 계산
agn1
plot(agn1)
### diss=TRUE는 입력 자료가 비유사성 행렬 또는 dist 객체인 경우에는 디폴트임
agn2 <- agnes(daisy(USArrests), diss=TRUE, method="complete") # daisy() 함수로 거리 계산
plot(agn2)
### method = 은 군집 방법을 지정. 
### "flexible"(가중 평균연결법의 일반화된 방법). "average"(디폴트), "single", "complete", "ward", "weighted", "gaverage"가 있다.
agn3 <- agnes(USArrests, method="flexible", par.meth=0.6)
plot(agn3)


# 계층적 군집 방법의 이론적 배경
### 계층적 군집 방법은 다음과 같다.
### 군집을 형성하는 매 단계에서 지역적(local) 최적화를 수행해 나가는 방법을 사용하므로 그 결과가 전역적인(global) 최적해라고 볼 수 있다.
### 병합적 방법에서 한 번 군집이 형성되면 군집에 속한 개체는 다른 군집으로 이동 할 수 없다.
### 중심연결법, 와드연결법 등에서는 군집의 크기에 가중을 두어 병합을 시도하므로 크기가 큰 군집과의 병합이 유도될 수 있다.
### {ape}패키지는 계층적 군집의 결과를 다양한 시각화를 할 수 있게 해준다.


# hclust() 함수를 이용하여 계층적 군집 수행
fit <- hclust(d, method="ave")
clus6 <- cutree(fit, 6)
### 색상 지정
colors = c("red", "blue", "green", "black", "cyan", "magenta")


# {ape}패키지의 as.phylo() 함수를 이용하여 hclust객체를 phylo객체로 전환
# install.packages("ape")
library(ape)
### phylo 객체에 대한 plot()함수의 형식은 다음과 같다.
### x : phylo 객체
### type " "phylogram"(디폴트), "cladogram", "fan", "unrooted", "radial"
### show.tip.label : 레이블 나타냄(TRUE)
### edge.color, edge.width, edge.lty : 연결선의 색상, 너비, 형태를 지정
### tip.color : 레이블 색상
plot(as.phylo(fit), type="fan", tip.color = colors[clus6], label.offset=1, cex=0.7)
plot(as.phylo(fit), type = "phylogram", show.tip.label=TRUE, edge.color="black", edge.width=1, edge.lty=1, tip.color="black")
plot(as.phylo(fit), type="cladogram", cex=0.6, label.offset=0.5) # type = "cladogram"
plot(as.phylo(fit), type="unrooted", cex=0.6, no.margin=0.5) # type = "unrooted"