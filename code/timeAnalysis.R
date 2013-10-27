# set directory to your repository
setwd(dir = '~/stop-frisk-analysis/')

# load data

load('data/cleanedData.Rdata')

require(plyr)
require(ggplot2)

# Distributions of physical features by race

test <- ddply(.data = df, .variables = c('weekStop', 'hourStop', 'CMDESC'),.fun = NROW)

hourSet<-ddply(.data = df, .variables = c('hourStop', 'CMDESC'),
               summarize,
               numStops = NROW(CMDESC)
               )

head(hourSet[ order(-hourSet[,3]),],30)

ggplot(hourSet, aes(x = as.numeric(hourStop), y= numStops, group = CMDESC)) + geom_point() + xlab('Hour of the day') + ylab('Number of incidents')  + geom_line(aes(group = CMDESC))



dtest <- ddply(.data = df, 
               .variables = c('dayStop'),
               summarize, 
               avgArrest = mean(arrestMade),
               numStops = NROW(CMDESC),
               avgFrisk = mean(frisked)
)

ggplot(dtest, aes(x = avgFrisk, y = avgArrest)) + geom_point(aes(color = dayStop, size = numStops)) + geom_line()


dtest <- ddply(.data = df, 
               .variables = c('wkdayStop','CMDESC'),
               summarize, 
               avgArrest = mean(arrestMade),
               numStops = NROW(CMDESC),
               avgFrisk = mean(frisked)
)

ggplot(dtest, aes(x = avgFrisk, y = avgArrest)) + geom_point(aes(color = CMDESC, size = numStops)) 

dtest <- ddply(.data = df2, 
               .variables = c('PCT'),
               summarize, 
               avgArrest = mean(arrestMade),
               numStops = NROW(CMDESC),
               avgFrisk = mean(frisked)
)
ggplot(dtest, aes(x = avgFrisk, y = avgArrest)) + geom_point(aes(color = as.factor(PCT), size = numStops))


ggplot(dtest, aes(x = as.numeric(hourStop), y= V1)) + geom_point(aes(color = factor(CMDESC))) + xlab('Hour of the day') + ylab('Number of incidents') 


ggplot(test, aes(x = as.numeric(hourStop), y= V1)) + geom_point(aes(color = factor(CMDESC))) + xlab('Hour of the day') + ylab('Number of incidents') 

ggplot(test, aes(x = as.numeric(weekStop), y= V1)) + geom_point(aes(color = factor(CMDESC))) + xlab('Week of the year') + ylab('Number of incidents')
