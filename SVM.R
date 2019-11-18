source("datacleaning.r")
library(boot) ##for cv.glm function
library(MASS) ##for lda function
library(ipred) ##for errorest function
library(klaR) ##for partimat

lda.data <- lda(high.end~BLOCK+LOT+LAND.SQUARE.FEET+
                  YEAR.BUILT+GROSS.SQUARE.FEET
                ,train_prepared)
test_pred<-predict(lda.data,newdata=train_prepared)
table(train$high.end,test_pred$class)
mean(train$high.end==test_pred$class)
plot(lda.data, col = as.integer(train_prepared$high.end), main="LDA")

pred<-predict(lda.data,newdata=test_prepared)
high.end<-pred$class


#### qda

qda.data <- qda(high.end~BLOCK+LOT+LAND.SQUARE.FEET+
                  YEAR.BUILT+GROSS.SQUARE.FEET
                ,train_prepared)
test_pred<-predict(qda.data,newdata=train_prepared)
table(train$high.end,test_pred$class)
mean(train$high.end==test_pred$class)


pred<-predict(lda.data,newdata=test_prepared)
high.end<-pred$class


submission<-read.csv("sample_submission.csv")
submission<-cbind(submission,high.end)
names<-c("ID","high.end")
submission<-submission[,c(1,3)]
head(submission)

write.csv(submission,"submission3.csv",row.names = F)

