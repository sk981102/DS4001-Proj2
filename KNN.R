ggplot(data=train_prepared)+geom_point(mapping =aes(x=SQU, 
                                                       y=GROSS.SQUARE.FEET,color=high.end))
ggplot(data=train_prepared)+geom_point(mapping =aes(x=YEAR.BUILT, 
                                                    y=BLOCK,color=high.end))
sggplot(data=train_prepared)+geom_point(mapping =aes(x=YEAR.BUILT, 
                                                    y=GROSS.SQUARE.FEET,color=high.end))
ggplot(data=train_prepared%>%filter(NEIGHBORHOOD=="MIDTOWN EAST"))+
  geom_point(mapping =aes(x=LAND.SQUARE.FEET,y=GROSS.SQUARE.FEET,color=high.end))
