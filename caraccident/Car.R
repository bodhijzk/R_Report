library(readxl)
library(dplyr)
library(gridExtra)
library(ggplot2)
library(ggThemeAssist)
library(ggplotly)

#데이터 준비
month_age <- read.csv("2015year_agegroup_month_CarAccident.csv")
sex_age<-read.csv("2015year_agegroup_sex_CarAccident.csv")
timeline_age <- read.csv("2015year_agegroup_timline_CarAccident.csv")

#복사본 생성
month<- month_age
sex <- sex_age
timline <- timeline_age

#변수명 영문으로 변경
month <- month %>%
  rename ( agegroup= "연령층",
           month = "월",
           cases = "발생건수",
           dead= "사망자수",
           injured = "부상자수",
           heavy_injured = "중상",
           minor_injured="경상",
           report_cases="부상신고")

timeline <- timeline %>%
  rename(agegroup= "연령층",
         timeline = "시간대",
         cases = "발생건수",
         dead= "사망자수",
         injured = "부상자수",
         heavy_injured = "중상",
         minor_injured="경상",
         report_cases="부상신고")
head(timeline)

#결측치,이상치 확인
table(is.na(month))
levels(month$agegroup)
table(is.na(timeline))
levels(timeline$agegroup)

#연령대 및 월별 교통사고 발생 건수
ageg <- month %>%
  filter(agegroup != "12세이하")%>%
  filter(agegroup!="불명")
ageg
#연령대 및 시간대 별 교통사고 발생 건수
time_age <- timeline %>%
  filter(agegroup!= "불명")

#데이터 시각화
p<-ggplot(data=ageg,aes(month,cases,color=agegroup,group=agegroup))+
  geom_line()+geom_point(size=2,shape=1,fill="black")+
  theme(plot.subtitle = element_text(vjust  =  1))+
  theme(plot.caption = element_text(vjust  =  1))+
  ggtitle("2015년연령대 및 월별 교통사고 발생 건수")+

p
ggThemeAssistGadget(p)
q <- ggplot(time_age,aes(x=timeline,y=cases,group=agegroup,color=agegroup))+
  geom_line()+
  geom_point(size=1,shape=1)+
  ggtitle("2015년연령대 및 시간대별 교통사고 발생 건수")
q
#인터랙티브 그래프
ggplotly(p)
ggplotly(q)
