# 1장 다변량 분석 기초 : 공분산과 상관행렬

# mtcars 자료에 대해 공분산행렬과 상관행렬을 구한다.
summary(mtcars)
data(mtcars)
cov(mtcars[, c("disp", "hp", "wt", "qsec")]) # 공분산
cor(mtcars[, c("disp", "hp", "wt", "qsec")]) # 상관행렬
cov(subset(mtcars, am==0)[,c("disp", "hp", "wt", "qsec")]) # am==0(오토)인 경우
cov(subset(mtcars, am==1)[,c("disp", "hp", "wt", "qsec")]) # am==1(수동)인 경우