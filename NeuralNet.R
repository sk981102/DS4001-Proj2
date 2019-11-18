#install.packages("neuralnet")
source("datacleaning.r")

library(caret)
library(neuralnet)

##neural net only takes numeric

dmy <- dummyVars(" ~ NEIGHBORHOOD +BUILDING.CLASS.CATEGORY+TAX.CLASS.AT.PRESENT+
                 RESIDENTIAL.UNITS+COMMERCIAL.UNITS+
                 TAX.CLASS.AT.TIME.OF.SALE", data = train_prepared)
train_prepared2 <- data.frame(predict(dmy, newdata = train_prepared))

train_prepared_final<-cbind(train_prepared2,train_prepared%>%select(
  BLOCK,LOT,LAND.SQUARE.FEET,GROSS.SQUARE.FEET,YEAR.BUILT,high.end
))

nn=neuralnet(high.end~ .,data=train_prepared_final, hidden=2,act.fct = "logistic",
             linear.output = FALSE)

plot(nn)


dmy <- dummyVars(" ~ NEIGHBORHOOD +BUILDING.CLASS.CATEGORY+TAX.CLASS.AT.PRESENT+
                 RESIDENTIAL.UNITS+COMMERCIAL.UNITS+
                 TAX.CLASS.AT.TIME.OF.SALE", data = test_prepared)
test_prepared2 <- data.frame(predict(dmy, newdata = test_prepared))
test_prepared_final<-cbind(test_prepared2,test_prepared%>%select(
  BLOCK,LOT,LAND.SQUARE.FEET,GROSS.SQUARE.FEET,YEAR.BUILT
))

test_pred<-compute(nn,train_prepared)
table(train$high.end,test_pred$class)

pred<-compute(nn,test_prepared_final)
sub<-ifelse(pred>0.5,1,0)
head(sub)
submission<-read.csv("sample_submission.csv")
submission<-cbind(submission,sub)
names<-c("ID","high.end")
submission<-submission%>%mutate(
  high.end=sub
) %>% select(
  ID, high.end
)
head(submission)

write.csv(submission,"submission2.csv",row.names = F)

