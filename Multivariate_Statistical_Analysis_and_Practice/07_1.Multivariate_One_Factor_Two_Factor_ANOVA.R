# 7장 다변량 분산분석 : 일원배치 / 이원배치 다변량 분산분석

# 플라스틱 필름 생산 자료에 대해 MANOVA를 수행한다.
### 분석 자료 입력한다.
tear <- c(6.5, 6.2, 5.8, 6.5, 6.5, 6.9, 7.2, 6.9, 6.1, 6.3, 6.7, 6.6, 7.2, 7.1, 6.8, 7.1, 7.0, 7.2, 7.5, 7.6) 
gloss <- c(9.5, 9.9, 9.6, 9.6, 9.2, 9.1, 10.0, 9.9, 9.5, 9.4, 9.1, 9.3, 8.3, 8.4, 8.5, 9.2, 8.8, 9.7, 10.1, 9.2) 
opacity <- c(4.4, 6.4, 3.0, 4.1, 0.8, 5.7, 2.0, 3.9, 1.9, 5.7, 2.8, 4.1, 3.8, 1.6, 3.4, 8.4, 5.2, 6.9, 2.7, 1.9)
Y <- cbind(tear, gloss, opacity)

# gl(): generate (factor) levels
rate <- factor(gl(2,10), labels = c("Low", "High"))
rate
additive <- factor(gl(2, 5, length = 20), labels = c("Low","High"))
additive

# MANOVA 수행
fit <-manova(Y ~ rate*additive)
summary.aov (fit) # 일변량 분산분석표(ANOVA table)
summary(fit, test = "Wilks") # Wilks' lambda
summary(fit) # Pillai의 분산분석표

# {car}를 이용하여 MANOVA를 수행할 수도 있다.
### lm()을 먼저 수행한 뒤, 그 결과객체에 대해 Manova()함수를 수행
### Wilks lambda 통계량에 기초한 검정에서, 제한된 g와 p에 대해 F분포를 이용한 정확한 검정이 가능하다.
### Wilks lambda 검정이외에 Pillai 검정, Lawley-Hotelling 검정, Roy의 최대근검정이 있다
### 이들 검정은 manova() 함수에 test= 옵션에서 지정할 수 있다.
### 일원배치법에서 요구되는 공분산 행렬의 동일성에 대한 검정에는 Box의 M-검정(=LR검정)이 있다.
library(car) 
lm.1 <- lm(Y ~ rate * additive)
fit.1 <- Manova(lm.1)
fit.1