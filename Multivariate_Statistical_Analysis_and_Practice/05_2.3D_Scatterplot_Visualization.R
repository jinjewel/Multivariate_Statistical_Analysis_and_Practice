# 5장 다변량 자료의 시각화 : 3차원 산점도와 활용
rm(list=ls())

# {Rcmdr}패키지의 scatter3d()함수


# 3차원 산점도 - 정적 그래픽
### 정적 3차원 그래프
### {scatterplot3d}패키지의 scatterplot3d()함수는 3차원 점구름 그림을 그려준다.
# install.packages("scatterplot3d")
attach(iris)
library(scatterplot3d)
scatterplot3d(iris[1:3], color="blue")


# 3차원 산점도 - 동적 그래픽
### 동적 3차원 그래프
### {rgl}패키지의 plot3d()함수를 이용해서 시점마다 회전가능한 3차원 plot 그림을 그린다.
# install.packages("rgl")
library("rgl")
plot3d(iris[1:3])



# 3차원 산점도 - 동적 그래픽
### 라벨부여가 가능한 동적 3차원 그래프
### {Rcmdr}패키지의 scatter3d()함수를 통해 다양한 회귀 평면과 함께 3차원 산점도를 그려준다.
### {Rcmdr}패키지의 Identify3d()함수를 추가적으로 사용하면 마우스를 이용하여 대화식으로 점에 라벨부여 가능
# install.packages("Rcmdr")
library(Rcmdr)
# Identify3d(iris$Sepal.Length, iris$Sepal.Width, iris$Petal.Length) # 오른쪽 마우스로 드래그시 라벨 부여
scatter3d(iris$Sepal.Length, iris$Sepal.Width, iris$Petal.Length)   


# 3차원 산점도를 곂쳐서 그릴수 있는 3차원 산점도 그래프
### scatterplot3d()함수의 points3d()메소드를 이용하여 3차원 모형에 산점도를 덧붙일수 있다.
library(scatterplot3d) # 동적 3차원 그래프를 그리기 위해 선언
### 덧붙이기 전 3차원 그래프
scatterplot3d(iris[1:3], color="blue", zlim=c(0,10), ylim=NULL)
plot_1 <- scatterplot3d(iris[1:3], color="blue", zlim=c(0,10), ylim=NULL)
iris[3] <- iris[3]+2 # iris 데이터 재표현
iris[2] <- iris[2]+sample(1:5,150, replace = T) # iris 데이터 재표현
### 덧붙이기 후 3차원 그래프
plot_1$points3d(iris[1:3], col="red") # 3차원 모형에 덧붙여서 그려주는 메소드