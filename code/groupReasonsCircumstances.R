#install.packages('useful')
#require(cluster)
setwd('~/stop-frisk-analysis')
load('data/cleanedData.Rdata')
categ <- df[,c(44:72)]
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
##################################################################
groups <- df[,c(109,110)]
groups$groups <- 0
groups$groups[which(rowSums(categ[,c(43-42,44-42,67-42,57-42,50-42)]) > 0) ] <- 1
groups$groups[which(rowSums(categ[,c(45-42,62-42,53-42,68-42)]) > 0 )] <- 2
groups$groups[which(rowSums(categ[,c(46-42,49-42,63-42,71-42)]) > 0 )] <- 3
groups$groups[which(rowSums(categ[,c(56-42,58-42,60-42)]) > 0 )] <- 4
groupings <- groups[which(groups$groups > 0 ),]
write.csv(groupings,'data/groupings.csv',row.names = FALSE)
############################################################################
location <- data.frame(lapply(location, as.numeric), stringsAsFactors=FALSE)
location <- na.omit(location)
l4 <- kmeans(location,4)
groups <- location
groups$groups <- l4
