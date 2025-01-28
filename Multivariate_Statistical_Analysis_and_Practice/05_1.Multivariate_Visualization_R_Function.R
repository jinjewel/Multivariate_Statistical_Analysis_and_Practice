# 5장 다변량 자료의 시각화 : 다변량 자료의 시각화를 위한 R함수
rm(list=ls())

# pairs() 함수
### pairs() 함수는 다변량 산점도를 제공
### 변수들 간의 상관성 등의 관계성을 시각적으로 파악하는데 유용
### pch = : 글자 크기
### bg = : 점들의 색상을 넣어준다.
### 품종별로 유의미한 차이가 있다는 것을 알 수있다.
pairs(iris[1:4], pch=21, bg=c("red","green3","blue")[unclass(iris$Species)])


# matplot() 함수
### matplot() 함수는 (행렬)자료의 열을 그려준다.
### 측정단위가 동일한 변수들간의 비교에 유용하다.
matplot(iris, type="p") # 종류를 숫자로 표현
matplot(iris, type="l") # 종류를 선으로 표현


# stars() 함수
### stars() 함수는 다변량 자료를 별그림 또는 조각난 다이어그램(도형그림)으로 요약한다.
### 단일 location을 이용해 spider or radar 그림을 그린다
### 중심에서 연결괸 선 또는 조각난 도형의 면적은 해당 변수의 크기를 나타낸다.
### col.line=1:nrow(iris) : 변수에 색상을 추가하기 위해 선언
stars(iris, col.line=1:nrow(iris))


# 나이팅계일 차트
### stars()함수의 옵션을 변경하여 '나이팅계일 차트'를 그릴 수 있다.
### flip.labels=FALSE : label이 정렬된 형태로 나타난다. 
### key.loc=c(14, 1.5) : 우측 하단에 원형으로 되어있는 설명부를 표시한다.
### col.lines = NA : 컬러 벡터를 지정하나, draw.segments = TRUE가 있는 경우는 무시된다.
stars(mtcars[,1:7], flip.labels=FALSE, key.loc=c(14, 1.5), draw.segments = TRUE, col.lines = NA)
stars(mtcars[,1:7], key.loc=c(14, 1.5), draw.segments = TRUE, col.lines = NA)
stars(mtcars[,1:7], flip.labels=FALSE, draw.segments = TRUE, col.lines = NA)
stars(mtcars, flip.labels=FALSE, key.loc=c(14, 1.5), col.lines = 1:nrow(mtcars))


# 레이더 플롯
### stars()함수의 옵션을 변경하여 '레이더 플롯'을 그릴 수 있다.
### location=c(0,0) : 중심을 한곳에 모았다.
### col.lines=iris$Species : 종별로 색상을 다르게 함
### key.loc=c(0,0) : 테두리의 축을 그려줌
stars(iris, location=c(0, 0), col.lines=iris$Species, key.loc=c(0,0)) # 종렬로 색상을 나누고, 각 데이터를 겹치게 그렸다.
stars(iris, location=c(0, 0), key.loc=c(0,0)) # 색상이 없음
stars(iris, location=c(0, 0), col.lines=iris$Species) # 테두리의 축과 변수명이 사라짐
### radius=FALSE : 중심에서 각 꼭짓점까지의 선을 그려줌
### lty=2 : 선의 형태를 점선으로 한다.
### col.lines=1:nrow(mtcars) : 선의 색상을 행의 수만큼 지정한다.
stars(mtcars[,1:7], locations=c(0,0), radius=FALSE, key.loc=c(0,0), lty=2, col.lines=1:nrow(mtcars))
stars(mtcars[,1:7], locations=c(0,0), key.loc=c(0,0), lty=2, col.lines=1:nrow(mtcars)) # 중앙에서부터 각 꼭짓점까지 연결
stars(mtcars[,1:7], locations=c(0,0), radius=FALSE, key.loc=c(0,0), lty=2) # 색상이 없음


# {fmsb}패키지의 radarchart()함수를 통해 레이더 차트 혹은 Spider그림을 그릴 수 있다.
# install.packages("fmsb")
library(fmsb)
set.seed(123)
maxmin <- data.frame(total=c(5, 1), phys=c(15, 3), psycho=c(3, 0), social=c(5, 1), env=c(5, 1))
dat <- data.frame(total=runif(3, 1, 5), phys=rnorm(3, 10, 2), psycho=c(0.5, NA, 3), social=runif(3, 1, 5), env=c(5, 2.5, 4))
dat <- rbind(maxmin,dat)
radarchart(dat)


# symbols()함수
### 플롯에 지정된 x, y 좌표에 여러 가지 심볼(원, 사각형, 별, 온도계, 상자그림)을 그린다.
### 사각형 심볼 차트
### circles=크기 변수
### squares=크기 변수
### rectangles=크기 변수
### stars=크기 변수
### thermometers=크기 변수
### boxplots=크기 변수
### inches=T
### add=F
### fg=iris$Species : 종 별로 색상을 다르게 하였다. 
### bg=NA
symbols(iris$Sepal.Length, squares=iris$Petal.Length, fg=iris$Species)


# 원형 심볼 차트
### circles=Girth/16 : Girth/16의 크기로 원형 심볼을 선언
### inches=  : 단위를 인치로 변환한다.
### bg=1:nrow(trees) : 버블마다 색상을 지정한다.
### fg="gray30" : 버블의 테두리의 색상을 지정한다.
### col=op : 삭제되어도 변화가 없음 (왜 있는거지...?)
attach(trees)
op <- palette(rainbow(nrow(trees), end=0.9))
symbols(Height, Volume, circles=Girth/16, inches=T, bg=1:nrow(trees), fg="gray30", col=op)


# faces()함수
### 체르노프 얼굴그림은 다변량 자료의 각 변수를 얼굴의 여러 구성요소에 대응시켜 그린 그림이다.
### 서로 닮은 형태의 개체가 유사함을 나타낼수 있으며, 최대 15개의 변수를 나타낼 수 있다.
### 데이터 생성
### {tcltk2}패키지의 데이터를 가져온다.
library(tcltk2)
bball<-read.csv("http://datasets.flowingdata.com/ppg2008.csv",header=TRUE) 


# 체르노프 얼굴 그림
### face.type= : 얼굴의 형태를 지정, 0:선 얼굴, 1:색이 칠해진 얼굴, 2:산타클로스 얼굴 
### {aplpack}패키지의 faces()함수를 이용하여 체르노프 얼굴 그림을 그린다.
library(aplpack)
### labels=bball$Name : 각 자료에 이름을 붙인다.
### ncolors=0 : 색상을 제거한다.
faces(bball[,2:16], ncolors=0, labels=bball$Name)


# 데이터 생성
data(longley)
summary(longley)


# 체르노프 얼굴 그림
### face.type=2 : 산타클로스 얼굴로 표현
faces(longley[1:16,], face.type=2)


# plot.faces()함수로 그래프로 산타클로스 얼굴 표시
### bty="n" : 그래프의 테두리를 삭제한다.
plot(longley[1:16, 2:3], bty="n") # 데이터를 좌표에 표현
### plot=F : 변수에 데이터를 대입할 때, faces()함수 결과를 실행하지 않는다.
a <- faces(longley[1:16,], plot=F)
# plot.faces()함수로 사용
plot.faces(a, longley[1:16, 2], longley[1:16, 3], width=35, height=30)
