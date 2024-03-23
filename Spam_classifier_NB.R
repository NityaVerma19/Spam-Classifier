choose.files()
sms_raw = read.csv("C:\\Users\\DELL\\Downloads\\sms_spam.csv")
sms_raw
library(tidyverse)
x = iconv(x , "WINDOWS-1252", "UTF-8")
sms_raw[,sapply(sms_raw, is.character)] = sapply(
  sms_raw[,sapply(sms_raw, is.character)],
  iconv, "WINDOWS-1252", "UTF-8")


#install.packages('tm')
library(tm)

sms_raw$type = as.factor(sms_raw$type)

#install.packages("SnowballC")
library(SnowballC)
  
sms_raw
sms_corpus = VCorpus(VectorSource(sms_raw$text))
sms_dtm3 = DocumentTermMatrix(sms_corpus, control = list(stemming = TRUE, 
                                                    tolower = TRUE,
                                                    stopwords = TRUE,
                                                    removePunctuation = TRUE,
                                                    removeNumbers = TRUE
                                                    ))
sms_dtm3              #7729 words (columns)
sms_train = sms_dtm3[1:4169,]
sms_test = sms_dtm3[4170:5559,]

#saving the labels


sms_train_labels <- sms_raw[1:4169, "type"]
sms_test_labels <- sms_raw[4170:5559, "type"]

# Making a probability table
prop.table(table(sms_train_labels))
prop.table(table(sms_test_labels))

sms_freq_word <- findFreqTerms(sms_train, 5)

sms_dtm_freq_train <- sms_train[, sms_freq_word]
sms_dtm_freq_test <- sms_test[, sms_freq_word]

convert_count <- function(y) {
  ifelse(y > 0, "yes", "no")
}

sms_matrix_freq_train <- as.matrix(sms_dtm_freq_train)
sms_matrix_freq_test <- as.matrix(sms_dtm_freq_test)

# Convert regular matrix to data frame
sms_df_freq_train <- as.data.frame(sms_matrix_freq_train)
sms_df_freq_test <- as.data.frame(sms_matrix_freq_test)

# Build Naive Bayes classifier
sms_classifier <- naiveBayes(sms_matrix_freq_train, sms_train_labels)
