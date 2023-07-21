getwd()
setwd("/Users/baektaehyun/desktop/전산통계학/실습파일")
library(xlsx)
ds <-  read.xlsx("Forbes-2021.xlsx",header = T, sheetIndex = 1)
head(ds)
reStr <- function (x) gsub("^\\s+|\\s+$|[$BM,]", "", x)
for(i in 4:7){
  ds[,i] <- as.numeric(reStr(ds[,i]))
}
head(ds)
ds[!complete.cases(ds),] #결측값 확인

table(ds$Country)
tmp <- sort(table(ds$Country), decreasing = T)
tmp
top.10.contry <- tmp[1:10]
top.10.contry
par(mar=c(8,4,4,2))
barplot(top.10.contry,
        main = '기업수 상위 10개국',
        col=rainbow(10),
        las=2)

colnames(ds)
tmp <- ds[order(ds$Market.Value, decreasing = T),]
top.10.Market_value <- tmp[1:10,c('Name','Market.Value')]
top.10.Market_value #2021년 기준 시가총액 상위 10개 기업

korea <- subset(ds, Country == 'South Korea')
korea[,c('Name','Country','Market.Value')] #포브스 2000에 속하는 한국기업


tmp <- ds[,4:7] #sales, profit, assets,market.Value 추출
tmp <- tmp[complete.cases(tmp),]
plot(tmp, lower.panel=NULL) #산점도
cor(tmp) #상관계수 -> 기업의 자산과 자산의 어느정도 서로 영향을 끼침
