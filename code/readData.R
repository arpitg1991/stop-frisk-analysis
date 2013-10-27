require(foreign)

# set directory to your repository
setwd(dir = '~/stop-frisk-analysis/data/raw/2012.por')

df <- as.data.frame(read.spss('~/Projects/stop-frisk-analysis/data/raw/2012.por'))


require(ggplot2)


desc <- read.csv('data/detailcm.csv')

df$DETAILCM <- as.numeric(df$DETAILCM)
df2 <- merge(df, desc, all.x = T)

require(plyr)
require(stringr)
df2$d <- str_replace_all(as.character(df2$DATESTOP), pattern = ' ', replace = '')
df2$t <- str_replace_all(as.character(df2$TIMESTOP), pattern = ' ', replace = '')

df2$d[nchar(df2$d)==7] <- paste('0',df2$d[nchar(df2$d)==7], sep = '')
df2$t[nchar(df2$t)==3] <- paste('0',df2$t[nchar(df2$t)==3], sep = '')
df2$t[nchar(df2$t)==2] <- paste('00',df2$t[nchar(df2$t)==3], sep = '')

df2$hourStop <- substr(df2$t, 1,2)

df2$datestop <- as.POSIXct(as.Date(df2$d, '%m%d%Y'))

require(lubridate)

df2$monthStop <- month(df2$datestop)
df2$weekStop <- as.numeric(week(df2$datestop))
df2$wkdayStop <- weekdays(df2$datestop)
df2$dayStop <- as.numeric(day(df2$datestop))



test <- ddply(.data = df2, .variables = c('weekStop', 'hourStop', 'CMDESC'),.fun = NROW)

df2$arrestMade <- as.numeric(with(df2, ARSTMADE=='Y'))
df2$frisked <- as.numeric(with(df2, FRISKED=='Y'))


dtest <- ddply(.data = df2, 
               .variables = c('dayStop'),
               summarize, 
               avgArrest = mean(arrestMade),
               numStops = NROW(CMDESC),
               avgFrisk = mean(frisked)
               )

ggplot(dtest, aes(x = avgFrisk, y = avgArrest)) + geom_point(aes(color = dayStop, size = numStops)) + geom_line()


dtest <- ddply(.data = df2, 
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
