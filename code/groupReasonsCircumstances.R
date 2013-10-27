setwd('~/stop-frisk-analysis')
data <- load('data/cleanedData.Rdata')
categ <- mydata[,c(43:63,65:72)]
categ <- data.frame(lapply(categ, as.character), stringsAsFactors=FALSE)
write.csv(categ,'data/reasonsCircumstances.csv',row.names = FALSE)
save(categ,file = 'data/reasonCircumstances.Rda')
