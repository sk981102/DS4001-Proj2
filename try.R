source("datacleaning.r")
s1<-read.csv("submission1.csv")
s2<-read.csv("submission2.csv")
s3<-read.csv("submission3.csv")

comb<-cbind(s1,s2,s3)
comb<-comb[,c(1,2,4,6)]

comb2<-comb[,-1]
comb3<-apply(comb2,1,sum)
finalcomb<-cbind(comb[,1],comb3)

final<-ifelse(finalcomb[,2]>=1,1,0)
final<-cbind(comb[,1],final)

names<-c("ID","high.end")
colnames(final)<-names

write.csv(final,"submission4.csv",row.names = F)
