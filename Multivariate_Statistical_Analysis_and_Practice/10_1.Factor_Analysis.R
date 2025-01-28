# 10장 인자분석 : FA를 사용한 인자분석
rm(list=ls())

# 데이터 불러오기
### biology(BIO), geology(GEO), chemistry(CHEM), algebra(ALG), calculus(CALC), statistics(STAT) 6과목
### 각 항목은 1(아주 싫어함)부터 5(아주 좋아함)의 값을 가진다.
subjects <- read.csv("C:/Users/User/Desktop/다변량통계 분석 및 실습/다변량 R 실습자료/subjects.csv", head=T)
head(subjects, 3)


# 상관계수 행렬 
options(digits=3) # 출력되는 소수점 자리수를 3개로 지정한다.
corMat <- cor(subjects) # 상관행렬 구하기
corMat


# 인자분석
### fa()함수를 이용하여 여러가지 회전과 인자화 방법을 제공한다. common 인자화에 사용된다.
### r : 상관행렬
### nfactors : 인자의 수(디폴트 1)
### rotate : 회전방법, 직교회전("none","varimax","quartimax")과 사교회전("promax","oblimin")이 있다.
### fm : 인자화 방법("pa"(principal axis), "ml"(maximum likelihood), "minres"(minimum residual, OLS), "wls"(weifhted least square) 등)
### 회전은 직교회전과 사교회전으로 구분된며, 두 회전의 차이는 인자들 간의 상관을 허용하는냐의 차이를 가진다.
### 직교회전은 인자들 사이의 독립성을 유지하는 회전으로 해석적인 면에서 유리하며,
### 사교회전은 비독립적인 인자를 허용하는 회전으로 단순한 구조를 만드는데 유리하다.
### 인자화의 방법은 common과 com-ponent로 구분되는데,
### common은 데이터를 잘 묘사하는 것이 주목적이며,
### com-ponent는 데이터의 양을 줄이는 데 그 목적이 있다.
# install.packages("psych")
library(psych)
# install.packages("GPArotation") # 다양한 회전 옵션을 수행할 수 있게 해준다.
library(GPArotation) # 사교회전(“oblimin”옵션)의 수행에 필요함
### 인자부하를 살펴보면, BIO, GEO, CHEM은 모두 제 1인자(PA1)에 0.8 근방의 매우 높은 인자부하를 가진다.
### 따라서 이 인자를 과학으로 명명하고 과학에 대한 관심도를 나타내는 것으로 해석할 수 있다.
### ALG, CALC, sTAT은 제 2인자(PA2)에 높은 부하를 가지므로 제 2인자를 수학의 관심도로 명명할 수 있다.
### 한가지 주목할 점으로 STAT의 경우 ALG, CALC에 비해 PA2에서 낮은 부하를 가지며, PA1에서 약간의 부하를 가진다.
### 이것은 STAT(통계학)이 ALG9대수), CALC(미적분)보다 수학과의 개념과 덜 연관되어있음을 알 수 있다.
### Proportion Var = SS loadings / 6
### Cumulative Var = sum(SS loadings / 6)
### Proportion Explained = Proportion Var / (Proportion Var_PA1 + Proportion Var_PA2)
### Cumulative Proportion = sum(Proportion Explained)
### 두 인자는 각각 분산의 약 30% 정도를 설명하고 있으며, 두 개의 인자는 전체 분산의 66%를 설명한다.
### 두 인자는 어느 정도 상관되어 있으며(상관계수 : 0.21), 이는 우리가 사교회전을 선택한 것과 맥락이 같다.
EFA <- fa(r = corMat, nfactors = 2, rotate="oblimin", fm = "pa")
EFA


# 인자 부하의 시각화
##  인자 부하 저장
ls(EFA) # EFA(탐색적 인자분석)의 결과로 출력할 수 있는 매소드 출력
EFA$loadings # 높은 인자부하를 필터링하여 출력
load_PA1 <- EFA$loadings[,1] # PA1의 인자부하 저장
load_PA2 <- EFA$loadings[,2] # PA2의 인자부하 저장
load <- EFA$loadings[,1:2]
## 인자 부하 시각화
plot(load, type="n") # type="n"를 사용하여 플랏이 안찍힌 그래프 틀 생성
text(load, labels=names(subjects), cex=.7) # 플랏이 찍힌 곳에 변수를 표시한다.


# {psych}패키지의 factor.plot()와 fa.diagram() 함수
## {psych}패키지의 factor.plot()와 fa.diagram() 함수를 사용하여 인자분석의 결과를 보다 쉽게 나타낼 수 있다.
# install.packages("psych")
library(psych) # 인자분석을 위한 라이브러리 호출
factor.plot(EFA, cut=0.5)  # 부하가 모두 0.5 이하인 점을 (색상으로) 구분해 줌 
fa.diagram(EFA) # PA1과 PA2와 연관된 인자들을 그래프로 표기


# 인자의 수 결정
## 인자의 수를 결정하기 위해서 {nFactors}패키지를 이용한다.
## {nFactors}패키지 parallel()함수는 임의의 무상관인 표준정규변량의 상관(또는 공분산) 행렬의 고윳값 분포를 제공
## {nFactors}패키지 nScree()함수는 Cartell의 scree test를 수행, 고윳값이 작아지는 직전값을 선택
## 위의 scree플롯에서 고윳값이 작아지는 직전값은 2로, 즉 유지되어야 할 성분(인자)의 수는 2이다.
## 그림의 우 상단에는 다양한 방법에 의한 최적의 성분 수가 제시되어 있다.(모두 2로 주어짐)
## 이 가운데 첫 번째는 '고윳값이 그들의 평균(상관행렬의 경우에는 1)보다 큰 값의 수'로 성분의 수를 정하는 kaiser의 규직을 적용한 결과이다.
# install.packages("nFactors")
library(nFactors)
ev <- eigen(cor(subjects)) # 상관행렬에 대한 고윳값 
ap <- parallel(subject=nrow(subjects), var=ncol(subjects), rep=100,cent=.05)
nS <- nScree(x=ev$values, aparallel=ap$eigen$qevpea)
plotnScree(nS)

# scree 플롯 역시 {psych}패키지의 VSS.scree() 또는 scree()함수를 이용하면 쉽게 그릴 수 있다. 
## 이 함수는 상관행렬 또는 원 자료를 사용할 수 있다.
# install.packages("psych")
library(psych) # 인자분석을 위한 라이브러리 호출
VSS.scree(corMat) # VSS.scree(subjects)와 동일
scree(corMat) # scree(subjects)와 동일

# {FactoMineR}패키지를 통해 탐색적 인자분석(EFA)에 대한 추가적인 함수를 사용할 수 있다.
# install.packages("FactoMineR")
library(FactoMineR)
result <- PCA(subjects)   