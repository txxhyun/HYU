getwd()
setwd("/Users/baektaehyun/desktop/전산통계학/실습파일")
library(xlsx)
files <- c("2021년 1월.xlsx","2021년 2월.xlsx","2021년 3월.xlsx","2021년 4월.xlsx","2021년 5월.xlsx","2021년 6월.xlsx")
ds<-NULL
for(f in files){
  tmp <- read_xlsx(paste("/Users/baektaehyun/desktop/전산통계학/실습파일/",f,sep = ""))
  ds <- rbind(ds, tmp)
  print(f)
}
colnames(ds)
head(ds)
unique(ds$지역)
range(ds$측정일시) # 측정기간 20210101 ~ 2021063024
ds_new <- cbind(ds[,3], ds[,5], ds[,6:11]) #사용할 데이터들을 따로 추출하여 데이터 처리
colnames(ds_new) <- c("loc", "mdate", colnames(ds_new)[3:8])
unique(ds_new$loc)
ds_new <- ds_new[complete.cases(ds_new),]
mdate <- as.character(ds_new$mdate)
ds_new$year <- as.numeric(substr(mdate, 1, 4))
ds_new$month <- as.numeric(substr(mdate, 5, 6))
ds_new$hour <- as.numeric(substr(mdate, 9, 10))
ds_new$locname <- NA
ds_new$locname[ds_new$loc == 111123] <- "서울"
ds_new$locname[ds_new$loc == 336111] <- "목포"
ds_new$locname[ds_new$loc == 632132] <- "강릉"
ds_new <- ds_new[complete.cases(ds_new),] #ds_new의 결측값 제거
str(ds_new)
head(ds_new)
ds_new
boxplot(PM10~locname, data=ds_new,
        main='미세먼지 농도 분포') # PM10 미세먼지의 장소별 상자 농도 
boxplot(PM10~locname, data=ds_new, #미세먼지의 농도 범위를 100으로 제한하여 다시 그림
        main='미세먼지 농도 분포',
        ylim=c(1,100))

tmp.month <- aggregate(ds_new[,7], 
                       by = list(month = ds_new$month, 
                                 loc = ds_new$locname), FUN = "mean") #PM 10 미세먼지의 월별 평균
tmp.month
ggplot(tmp.month, 
       aes(x=month, 
           y = x, 
           colour = loc, 
           group = loc))+
  geom_line() + 
  geom_point(size = 3, shape = 19, alpha = 0.5) + 
  ggtitle("월별 PM10 농도 변화")+
  ylab("농도")

tmp.hour <- aggregate(ds_new[,7],
                      by=list(hour=ds_new$hour,
                              loc=ds_new$locname), FUN='mean') #PM10 미세먼지의 시간대별 평균
tmp.hour$loc = as.factor(tmp.hour$loc)
head(tmp.hour)
ggplot(tmp.hour, aes(x=hour,y=x, colour=loc, group=loc))+
  geom_line( )+
  geom_point(size=3, shape=19, alpha=0.5)+
  ggtitle('시간별 PM10 농도 변화')+ylab('농도')

set.seed(100)
plot(ds_new[sample(nrow(ds_new),5000),3:7], lower.panel=NULL)
cor(ds_new[,3:7])
idx_max <- which(tmp.month$x == max(tmp.month$x)) #가장 미세먼지가 많았던 날
tmp.month[idx_max,]
idx_min <- which(tmp.month$x == min(tmp.month$x)) # 가장 미세먼지가 적었던날
tmp.month[idx_min,]

