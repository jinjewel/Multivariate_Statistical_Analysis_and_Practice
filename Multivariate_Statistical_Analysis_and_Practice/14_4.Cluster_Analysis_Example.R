rm(list=ls())

# 연습문제 2번

# (a)
data(attitude)
library(NbClust)
set.seed(1234)
nc <- NbClust(attitude[,3:4], min.nc = 2, max.nc = 15, method="kmeans")

table(nc$Best.nc[1,]) # 군집 2개로 나누는 것이 적절하다.

fit.km <- kmeans(attitude[3:4], 2, nstart = 25)
fit.km$size # 각 군집의 크기

fit.km$centers # 각 군집의 중심값

# 군집 결과의 시각화
plot(attitude[,3:4], col=fit.km$cluster)
points(fit.km$centers, col=1:2, pch=8, cex=2)

# (b)
set.seed(1234)
nc_total <- NbClust(attitude, min.nc = 2, max.nc = 15, method="kmeans")

table(nc_total$Best.nc[1,]) # 군집 2개로 나누는 것이 적절하다.

fit.km <- kmeans(attitude, 2, nstart = 25)
fit.km$size # 각 군집의 크기

fit.km$centers # 각 군집의 중심값

# 군집 결과의 시각화
plot(attitude, col=fit.km$cluster)
points(fit.km$centers, col=1:2, pch=8, cex=2)

