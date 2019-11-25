source("datacleaning.r")
library(ISLR)
library(glmnet)
library(pls)
library(tree)
library(randomForest) ##for random forests (and bagging)
library(gbm) ##for boosting
library(adabag)

boost.class<-boosting(high.end~NEIGHBORHOOD + BUILDING.CLASS.CATEGORY +
                   TAX.CLASS.AT.PRESENT + BLOCK + LOT+ LAND.SQUARE.FEET +
                   TAX.CLASS.AT.TIME.OF.SALE +GROSS.SQUARE.FEET, 
                 data=train_prepared,boos=F,mfinal=20)
boost.class
pred.train.boost<-predict(boost.class, newdata=train_prepared, 
                          n.trees=500, type = "response")

mean(pred.train.boost$class==train_prepared$high.end) #0.8209894

pred.test.boost<-predict(boost.class, newdata=test_prepared, 
                          n.trees=500, type = "response")

submission<-read.csv("sample_submission.csv")
submission<-cbind(submission,pred.test.boost$class)
final<-submission[,-2]

names<-c("ID","high.end")
colnames(final)<-names

write.csv(final,"submission7.csv",row.names = F)
