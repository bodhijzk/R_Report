library(stringr)
library(KoNLP)
library(rJava)
library(memoise)
library(dplyr)
library(wordcloud)
library(RColorBrewer)
library(wordcloud2)

useNIADic()
Sys.setenv(JAVA_HOME= "C:/Program Files/Java/jre1.8.0_211")
txt <- readLines("hiphopencoding.txt",encoding = "UTF-8")

txt <- str_replace_all(txt,"\\W"," ")

nouns <- extractNoun(txt)
#추출한 명사 list 를 문자열 벡터로 변환하여 단어별 빈도표를 생성한다
wordcount <- table(unlist(nouns))
#데이터 프레임 변환
df_wordT <- as.data.frame(wordcount, stringAsFactors= T)
#변수명 변경
df_wordT<- rename(df_wordT,
                  word=Var1,
                  freq=Freq)

df_wordT$word<-as.character(df_wordT$word)

df_wordT <- filter(df_wordT,nchar(word)>=2)




wordcloud2(df_wordT, figPath ="note.png", 
           size = 0.5,color = "random-dark",
           backgroundColor = "white", 
           rotateRatio= 3)



letterCloud(df_wordT, word = "hiphop", size = 2,
            backgroundColor = "black",
            rotateRatio= 3)




