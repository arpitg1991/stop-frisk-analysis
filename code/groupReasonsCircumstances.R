#install.packages('useful')
#require(cluster)
setwd('~/stop-frisk-analysis')
load('data/cleanedData.Rdata')
categ <- df[,c(44:64,66:69)]
categ <- data.frame(lapply(categ, as.character), stringsAsFactors=FALSE)
write.csv(categ,'data/reasonsCircumstances.csv',row.names = FALSE)
save(categ,file = 'data/reasonCircumstances.Rda')
categM <- as.matrix(categ)
categM[categM == "N"] <- 0
categM[categM == "Y"] <- 1
categD <- as.data.frame(categM)
categ <- categD
for (i in 1:ncol(categD)){
  categ[,i] <- as.numeric(levels(categD[,i]))[categD[,i]]
  
}
k2 <- kmeans(categ,2)
k5 <- kmeans(categ,5)
k3 <- kmeans(categ,3)
k10 <- kmeans(categ,10)
save(k2,k5,k3,k10,file = 'data/kmeans.Rda')
k2<-as.matrix(as.data.frame(k2[1]))
k3<-as.matrix(as.data.frame(k3[1]))
k5<-as.matrix(as.data.frame(k5[1]))
k10<-as.matrix(as.data.frame(k10[1]))
k <- cbind(k2,k3,k5,k10)

location <- data.frame(df$XCOORD,df$YCOORD)

write.csv(location,'data/location.csv',row.names = FALSE)