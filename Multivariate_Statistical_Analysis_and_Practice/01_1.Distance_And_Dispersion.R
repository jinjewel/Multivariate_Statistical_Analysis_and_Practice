# 1장 다변량 분석 기초 : 거리와 산포

# dist() 함수는 유클리드 거리 등을 제공한다.
### method = "minkowski" or "binary", "manhattan", "euclidean", "maximum", "canberra"
### p = 민코우스키 거리의 승수
x = c(1,2,3,4,5)
dist(x, method = "euclidean", diag=F, upper=F, p=2)
dist(x, method = "euclidean", p=2)


# scale() 함수를 사용하여 척도화를 진행한다.
### scale(x, center=F, scale=apply(x,2,sd,na.rm=T)) # 중심화 없이 척도화를 진행
### center = T : 중심화는 열 평균(결측값 제외한)을 뺀 값을 제공한다.
### scale = T : 척도화는 반드시 중심화 이후에 수렴되며, 열 평균 표준편차로 나눈 값을 제공한다.
### scale = apply(x,2,sd,na.rm=T) : scale=T 와 충돌이 생기므로 다음의 코드를 사용한다.
scale(x, center=T, scale=T) # 중심화와 척도화를 진행


# trees 자료에 대해 개체 간의 거리 계산한다.
dist(trees[1:4,]) # trees 데이터 중 4번까지의 데이터를 사용하여 유클리드 거리 계산
dist(scale(trees[1:4,], center=T)) # 표준화된 거리 계산


# 가상의 다변량 자료에 대해 평균점으로부터의 마할라노비스 제곱거리를 계산한다.
### mahalanodis() 함수는 마할라노비스 제곱거리를 제공한다.
### {biotools} D2.dist() 함수를 사용하여 마할라노비스 제곱거리를 제공한다.
### center= : 분포의 평균벡터를 지정, 두 점간의 거리는 여기에 또다른 데이터를 대입
### cov = : 분포의 공분한 행렬 p*p 를 지정
x <- matrix(rnorm(5*3), ncol=3) # 100*3 행렬
mahalanobis(x, center=colMeans(x), cov=cov(x))