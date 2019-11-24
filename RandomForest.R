source("datacleaning.r")
library(ISLR)
library(glmnet)
library(pls)
library(tree)
library(randomForest) ##for random forests (and bagging)
library(gbm) ##for boosting


rnd.class<-randomForest(high.end~ NEIGHBORHOOD +BUILDING.CLASS.CATEGORY +
                         TAX.CLASS.AT.PRESENT+BLOCK + LOT + RESIDENTIAL.UNITS 
                        + COMMERCIAL.UNITS + LAND.SQUARE.FEET+
                          TAX.CLASS.AT.TIME.OF.SALE+
                          GROSS.SQUARE.FEET,data=train_prepared,mtry=6,
                        importance=TRUE) 
rnd.class
importance(rnd.class)

levels(test_prepared$NEIGHBORHOOD) <- levels(train_prepared$NEIGHBORHOOD)
levels(test_prepared$BUILDING.CLASS.CATEGORY) <- levels(train_prepared$BUILDING.CLASS.CATEGORY)
levels(test_prepared$BLOCK) <- levels(train_prepared$BLOCK)
levels(test_prepared$LOT) <- levels(train_prepared$LOT)
levels(test_prepared$RESIDENTIAL.UNITS) <- levels(train_prepared$RESIDENTIAL.UNITS)
levels(test_prepared$COMMERCIAL.UNITS) <- levels(train_prepared$COMMERCIAL.UNITS)
levels(test_prepared$GROSS.SQUARE.FEET) <- levels(train_prepared$GROSS.SQUARE.FEET)
levels(test_prepared$TAX.CLASS.AT.PRESENT) <- levels(train_prepared$TAX.CLASS.AT.PRESENT)
levels(test_prepared$TAX.CLASS.AT.TIME.OF.SALE) <- levels(train_prepared$TAX.CLASS.AT.TIME.OF.SALE)
levels(test_prepared$LAND.SQUARE.FEET) <- levels(train_prepared$LAND.SQUARE.FEET)

rnd.pred<-predict(rnd.class,newdata=test_prepared) 

submission<-read.csv("sample_submission.csv")
submission<-cbind(submission,rnd.pred)
final<-submission[,-2]

names<-c("ID","high.end")
colnames(final)<-names

write.csv(final,"submission6.csv",row.names = F)



tunegrid<-expand.grid(.mtry=c(1:15))
rf_default<-train(default~.,data=credit_train,method='rf',metric=metric,tuneGrid=tunegrid,
                  trControl=control)
plot(rf_default)