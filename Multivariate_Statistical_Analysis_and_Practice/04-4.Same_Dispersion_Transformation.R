# 4장 고전적 다변량 분석에 대한 가정 검토 : 등-산포 변환

# 데이터 생성
### InsectSprays자료는 앞서 확인해본 결과 평균과 산포과 연관되어 있음을 알수 있었다.
### 이를 해결하기 위해 등-산포변환을 진행한다.
### 데이터 생성
### {datasets}패키지의 InsectSprays 자료 사용
### InsectSprays 데이터 : 벌레를 잡는데 사용하는 스프레이의 데이터 셋
head(InsectSprays)
summary(InsectSprays)


# 산포-수준 그림
### {car}패키지의 spreadLevelPlot()함수는 산포-수준 그림을 그려준다.
### 각 수준별로 x축이 중앙값이고, y축이 사분위수범위로 설정된다.
library(car) # spreadLevelPlot() 함수
### 결과(0.197)는 그림에서 1-b(b=기울기)에 해당하며
### 반응변수에 대한 박스-콕스 변환의 차수. 즉, 산포-안정화를 위한 반응변수에 대한 변환차수를 나타낸다.
##3 박스-콕스 변환의 차수 : 0.1967897 ~ 0 이라서 Log변환을 한다.
spreadLevelPlot(count+1 ~ spray, InsectSprays) 
### 위 젍차에 대해 등-산포변환을 진행한다.
Boxplot(log(count+1) ~ spray, data=InsectSprays)


# 원 데이터와 변환된 데이터의 분산의 동질성 검정
### bartlett.test()함수는 K-표본에서 분산의 동질성에 대해 모수적 검정을 제공
### p값(9.085e-05 -> 0.1186)이 커지게 되면서 귀무가설을 채택
### 등분산성이 만족이 된다고 할 수 있게 됬다.
bartlett.test(count ~ spray, data=InsectSprays) # 원 데이터
bartlett.test(log(count+1) ~ spray, data=InsectSprays) # 변환 데이터