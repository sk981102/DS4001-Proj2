source("datacleaning.r")

library(glmnet)
library(ROCR)

summary(train_prepared)
summary(test_prepared)
attach(train_prepared)

model<-glm(high.end~ NEIGHBORHOOD+BUILDING.CLASS.CATEGORY+TAX.CLASS.AT.PRESENT+
             BLOCK+LOT+RESIDENTIAL.UNITS+
             COMMERCIAL.UNITS+LAND.SQUARE.FEET+GROSS.SQUARE.FEET+
             TAX.CLASS.AT.TIME.OF.SALE,family=binomial)
summary(model)
pred<-predict(model,newdata=train_prepared)

rates<-prediction(pred, teain_prepared$high.end)
roc_result<-performance(rates,measure="tpr", x.measure="fpr")
plot(roc_result, main="ROC Curve")+lines(x = c(0,1), y = c(0,1), col="red")

confusion.mat<-table(train_prepared$high.end,pred > 0.5)
confusion.mat

(8174+2021)/(14150)

# test set submission
pred<-predict(model,newdata=test_prepared)
sub<-ifelse(pred>0.5,1,0)
head(sub)
submission<-read.csv("sample_submission.csv")
submission<-cbind(submission,sub)
names<-c("ID","high.end")
submission%>%mutate(
  high.end=sub
)

## model 2 using Logistic regression
model2<-glm(high.end~ NEIGHBORHOOD+BUILDING.CLASS.CATEGORY+
             BLOCK+LOT+BUILDING.CLASS.AT.PRESENT+RESIDENTIAL.UNITS+
             COMMERCIAL.UNITS+GROSS.SQUARE.FEET+
             TAX.CLASS.AT.TIME.OF.SALE+BUILDING.CLASS.AT.TIME.OF.SALE,family=binomial)

pred2<-predict(model,newdata=train_prepared)

rates2<-prediction(pred2, train_prepared$high.end)
roc_result2<-performance(rates2,measure="tpr", x.measure="fpr")
plot(roc_result2, main="ROC Curve")+lines(x = c(0,1), y = c(0,1), col="red")

confusion.mat2<-table(train_prepared$high.end,pred2 > 0.5)
confusion.mat2

(7627+2318)/(14150) #0.7028269
