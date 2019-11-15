library(tidyverse)
library(ggplot2)
train<-read.csv("sales_manhattan_train_set.csv")
test<-read.csv("sales_manhattan_test_set.csv")

summary(train)
summary(test)
#getting rid of Borough, EASE.MENT, ADDRESS
#factorize high.end, TAX.CLASS.AT.TIME.OF.SALE, RESIDENTIAL UNITS, COMMERCIAL UNITS
# do something about YEAR.BUILLT(?)

#TRAIN DATASET CLEANING
train$high.end<-as.factor(train$high.end)
train$TAX.CLASS.AT.TIME.OF.SALE<-as.factor(train$TAX.CLASS.AT.TIME.OF.SALE)
train$LAND.SQUARE.FEET<-as.numeric(train$LAND.SQUARE.FEET)
train$GROSS.SQUARE.FEET<-as.numeric(train$GROSS.SQUARE.FEET)

train<-train%>%mutate(
  COMMERCIAL.UNITS=ifelse(COMMERCIAL.UNITS==0,F,T),
  RESIDENTIAL.UNITS=ifelse(RESIDENTIAL.UNITS==0,F,T),
  TOTAL.UNITS=ifelse(TOTAL.UNITS==0,F,T)
)

train_prepared<-train%>%select(
  -BOROUGH, -EASE.MENT, -ADDRESS,-ZIP.CODE
)

summary(train_prepared)

#TEST DATASET CLEANING
test$TAX.CLASS.AT.TIME.OF.SALE<-as.factor(test$TAX.CLASS.AT.TIME.OF.SALE)
test$LAND.SQUARE.FEET<-as.numeric(test$LAND.SQUARE.FEET)
test$GROSS.SQUARE.FEET<-as.numeric(test$GROSS.SQUARE.FEET)

test<-test%>%mutate(
  COMMERCIAL.UNITS=ifelse(COMMERCIAL.UNITS==0,F,T),
  RESIDENTIAL.UNITS=ifelse(RESIDENTIAL.UNITS==0,F,T),
  TOTAL.UNITS=ifelse(TOTAL.UNITS==0,F,T)
)

test_prepared<-test%>%select(
  -BOROUGH, -EASE.MENT, -ADDRESS,-ZIP.CODE
)

summary(test_prepared)
