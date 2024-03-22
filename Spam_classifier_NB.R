choose.files()
sms_raw = read.csv("C:\\Users\\DELL\\Downloads\\sms_spam.csv")
sms_raw
library(tidyverse)
x = iconv(x , "WINDOWS-1252", "UTF-8")
sms_raw[,sapply(sms_raw, is.character)] = sapply(
  sms_raw[,sapply(sms_raw, is.character)],
  iconv, "WINDOWS-1252", "UTF-8")


install.packages('tm')
library(tm)

sms_raw$type = as.factor(sms_raw$type)

install.packages("SnowballC")
library(SnowballC)
  
sms_raw
sms_corpus = VCorpus(VectorSource(sms_raw$text))
sm_dtm3 = DocumentTermMatrix(sms_corpus, control = list(stemming = TRUE, 
                                                    tolower = TRUE,
                                                    stopwords = TRUE,
                                                    removePunctuation = TRUE,
                                                    removeNumbers = TRUE
                                                    ))
