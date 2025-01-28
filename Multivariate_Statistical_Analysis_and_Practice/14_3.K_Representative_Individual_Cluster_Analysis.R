# 14장 군집분석 : k-대표개체(PAM) 군집

# {cluster}패키지의 pam() 함수는 PAM을 수행한다.
data(iris)
library(cluster)
result <- pam(iris[,1:4], 3, stand=FALSE, metric="euclidean")
summary(result)


# 군집결과 시각화
### (해석) PAM을 통한 군집결과를 clusplot() 함수를 통해 2개의 주성분 축을 이용하여 시각화한 결과
clusplot(result)


# 군집결과의 시각화
plot(iris[, 1:4], col=result$clustering)