beers

breweries

#Merge Data sets
colnames(breweries)[colnames(breweries)=="Brew_ID"]="Brewery_id"
combined_data=merge(beers,breweries,by="Brewery_id")



y=na.omit(y)

unique(beers[["Name"]])[1] %in% breweries[["Names"]]

unique(breweries[["Name"]])

beers

apply(combined_data,2,function(x) sum(is.na(x)))

median_abv=combined_data[,median(na.omit(ABV)),State]
colnames(median_abv)[2]="Median_ABV"
median_ibu=combined_data[,median(na.omit(as.numeric(IBU))),State]
colnames(median_ibu)[2]="Median_IBU"
median_data=merge(median_ibu,median_abv,by="State")
median_data=median_data[order(median_data[["Median_IBU"]]),]

combined_data[is.na(combined_data[["ABV"]]),]
combined_data[is.na(combined_data[["IBU"]]),]
median_data %>% ggplot( aes(x=reorder(State,State,
                                             function(x)-length(x)),y=Median_IBU)) + geom_bar(stat="identity")+xlab("State")+ylab("Count") + 
  ggtitle("Median ABV and IBU by State \nBy Rank")+theme(axis.text.x = element_text(angle = 90, hjust = 1))


ggplot(means.long,aes(x=variable,y=value,fill=factor(gender)))+
  geom_bar(stat="identity",position="dodge")+
  scale_fill_discrete(name="Gender",
                      breaks=c(1, 2),
                      labels=c("Male", "Female"))+
  xlab("Beverage")+ylab("Mean Percentage")



abv=combined_data[,median(na.omit(as.numeric(ABV))),State]
ibu=combined_data[,median(na.omit(as.numeric(IBU))),State]
colnames(abv)[2]="ABV"
colnames(ibu)[2]="IBU"
meds=merge(ibu,abv,by="State")

meds[["State"]]
combined_data[combined_data[["State"]]=="SD",]
ggplot(meds,aes(x=variable,y=value,fill=factor(gender)))+
  geom_bar(stat="identity",position="dodge")+
  scale_fill_discrete(name="Gender",
                      breaks=c(1, 2),
                      labels=c("Male", "Female"))+
  xlab("Beverage")+ylab("Mean Percentage")


ggplot(meds,aes(x=meds$State, y = meds$IBU))+geom_bar(stat = "identity")+labs(x = "State" , y = "IBU") + 
  ggtitle("Median IBU per State")

x=reorder(State,State,
          function(x)-length(x)),y=Median_IBU)


ggplot(meds,aes(reorder(meds$State,-meds$IBU), y = meds$IBU))+geom_bar(stat = "identity")+labs(x = "State" , y = "IBU") + 
  ggtitle("Median IBU per State")+theme(axis.text.x = element_text(angle = 90, hjust = 1))
ggplot(meds,aes(reorder(meds$State,-meds$ABV), y = meds$ABV))+geom_bar(stat = "identity")+labs(x = "State" , y = "IBU") + 
  ggtitle("Median ABV per State")+theme(axis.text.x = element_text(angle = 90, hjust = 1))

ggplot(meds,aes(reorder(meds$State,-meds$ABV), y = meds$ABV))+geom_bar(stat = "identity")+labs(x = "State" , y = "IBU") + 
  ggtitle("Median ABV per State")+theme(axis.text.x = element_text(angle = 90, hjust = 1))+scale_y_continuous(limits=c(0.0,0.0625))



combined_data[,na.omit(min(IBU)),State]
combined_data[which.max(ABV),]
combined_data[which.max(IBU),]

cor(na.omit(combined_data)[["ABV"]],na.omit(combined_data)[["IBU"]])



library(ggplot2)
p3 <- ggplot(combined_data, aes(x= combined_data$IBU, y= combined_data$ABV)) + 
  geom_point(stat="identity") 
p3
ggplot(combined_data,aes(x = ABV,y = IBU ))+geom_point(na.rm=TRUE)+geom_smooth(method=lm,se=FALSE, na.rm=TRUE)+
  ggtitle("IBU vs ABV content per Alcohol")


combined_data[,max,]
