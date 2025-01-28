# 2장 R 기초 함수와 주요 행렬 이론 : 특잇값 분해

# SVD(특잇값)를 활용하여 full_rank가 아닌 행렬의 일반화역행렬 찾기
### 행렬 선언
rm(list=ls())
a <- matrix(c(1,1,1,1,1,1,1,1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,1),6,4) # matrix((data),가로,세로)
a # 주어진 행렬 (6*4)


# 특잇값 분해
a.svd <- svd(a) # 특잇값분해


# 일반화 역행렬 계산을 위한 값 정리
lamda <- a.svd$d # 고윳값(6*4 행렬 이므로 4개의 고윳값 생성)
lamda # 단 마지막 특잇값은 0임을 알 수 있다.
sigma <- diag(lamda) # 0을 포함하는 특잇값을 대각원소로 사용하는 대각행렬
sigma
sigma_c <- diag(lamda[1:3]) # 0을 제외한 특잇값을 대각원소를 사용하는 대각행렬
sigma_c
sigma_c_inv <- diag(1/lamda[1:3]) # 일반화역행렬을 위해 (시그마)^(-1)
sigma_c_inv
U <- a.svd$u # U 행렬(6*4), 얇은 SVD의 좌특이벡터 U이다.
U 
V <- a.svd$v # V 행렬(4*4), 얇은 SVD의 우특이벡터 V이다.
V
U_com <- as.matrix(U[,1:3]) # 간결한 SVD의 좌특이벡터 U이다.
U_com
V_com <- as.matrix(V[,1:3]) # 간결한 SVD의 우특이벡터 V이다.
V_com


# 일반화 역행렬 A^(+) = (U * sigma * t(V))^(-1) = v * sigma^(-1) * t(U)
a.ginv <- U_com %*% sigma_c_inv %*% t(V_com)
a.ginv


# {MASS} 패키지의 ginv()함수를 사용한 일반화 역행렬
library(MASS)
ginv(a) # 위에서 순수 계산한 식이랑 동일