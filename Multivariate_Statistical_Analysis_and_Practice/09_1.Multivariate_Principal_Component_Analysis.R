# 9장 주성분 분석 : PCA의 개념과 수리

# 최신 버전 업데이트
### install.packages("installr")
### library(installr)
### check.for.updates.R()
### install.R()


# {stats}패키지의 prcomp()함수를 이용하여 주성분 분석을 진행한다.
### 데이터 선언
data(iris)
head(iris, 3)


# prcomp() 함수
### 연속형 자료에 대해 로그 변환을 수행하고, 
### prcomp() 함수를 통해 PCA를 수행하기 전에 변수에 대해 중심화와 표준화를 수행한다.
### prcomp() 함수에서 center=T, scale=F가 디폴트이다.
### 변수의 왜도와 크기는 주성분에 영향을 미치므로 PCA분석에 앞서 왜도 변환, 중심화, 표준화를 수행하는 것은 매우 바람직하다. 
### 이 예제에서는 로그변환을 수행하였으나 보다 일반적으로 Box-Cox 변환을 적용할 수 있다.
### 이 예제의 마지막 부분에서 모든 이러한 변환과 PCA의 적용이 {caret}패키지의 preProcess()함수의 단 일회 호출을 통해 어떻게 수행되는지 보여준다.
log.ir <- log(iris[,1:4])
ir.species <- iris[,5]
ir.pca <- prcomp(log.ir, center=T, scale=T) # 상관계수를 사용하여 주성분분석 진행, 표준화 변환을 이용


# print()함수
### print()함수는 4개의 주성분 각각의 표준편차와 연속형 변수의 선형결합 계수를 나타내는 회전(또는 부하)를 제공한다.
print(ir.pca) # 표준편차 + 부하행렬 출력


# plot() 함수
### plot() 함수는 주성분과 관련된 분산을 그려준다.
### 이 그림은 이후 분석에서 몇 개의 주성분을 사용할 것인지에 대한 정보를 제공한다.
### 이 예제 에서는 처음 2개의 주성분이 자료 변동의 대부분을 설명하는 것을 알 수 있다.
plot(ir.pca, type="l") # 분산의 크기를 꺾은선으로 그려줌


# summary() 함수
### summary() 함수는 주성분들의 중요도를 제공한다.
### 아래 결과에서 1행은 각 주성분과 관련된 표준편차를 나타낸다. 
### 2행은 각 주성분에 의해 설명되는 자료 분산의 비율을 나타내며,
### 3행은 설명되는 분산의 누적비율을 나타낸다.
### 여기서는 처음 2개의 주성분이 자료 분산의 95% 이상을 설명함을 알 수 있다.
summary(ir.pca) # 표준편차, 비율, 누적합 출력


# predict() 함수
### predict() 함수는 새로운 자료에 대해 그들의 주성분 값(PCs)을 예측해준다.
### 여기서는 설명의 편의상 마지막 2개의 자료를 새로운 자료로 취급하여 예측을 수행한다.
predict(ir.pca, newdata=tail(log.ir, 2)) # 새로운 데이터로 예측


# biplot() 함수
### biplot() 함수를 통해 PCA의 결과를 시각화 할 수 있다.
biplot(ir.pca) # 주성분 축과 원데이터 2차원 산점도 그림


# {caret}패키지를 이용한 PCA 분석
### 왜도의 수정을 위해 Box-Cox 변환을 수정하고, 중심화, 표준화를 수행한 뒤
### {caret} 패키지의 preProcess()함수로 PCA를 수행한다.
# install.packages("caret")
require(caret)
### 디폴트로, preProcess()함수는 적어도 데이터 분산의 95% 이상을 설명하는데 필요한 주성분(PCs)만을 저장(keep)하나, 
### 이것은 thresh=0.95 옵션을 통해 변경할 수 있다.
trans = preProcess(iris[,1:4], method=c("BoxCox","center","scale","pca")) # BoxCox 변환 이용
PC = predict(trans, iris[,1:4]) # 새로운 변수로 예측
head(PC, 3)
trans$rotation # 부하행렬
ls(trans)