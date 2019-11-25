source("datacleaning.r")
library(ISLR)
library(glmnet)
library(pls)
library(tree)
library(randomForest) ##for random forests (and bagging)
library(gbm) ##for boosting


boost.class<-gbm(high.end~NEIGHBORHOOD + BUILDING.CLASS.CATEGORY +
                   TAX.CLASS.AT.PRESENT + BLOCK + LOT+ LAND.SQUARE.FEET +
                   TAX.CLASS.AT.TIME.OF.SALE +GROSS.SQUARE.FEET, 
                 data=train_prepared, distribution="bernoulli", cv.fold=3,n.trees=500)
boost.class
pred.train.boost<-predict(boost.class, newdata=test_prepared, 
                          n.trees=500, type = "response")
