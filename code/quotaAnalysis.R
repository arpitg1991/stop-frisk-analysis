setwd(dir='~/stop-frisk-analysis/')

load('data/cleanedData.Rdata')
df2012 <- df
load('data/cleanedData2011.Rdata')
df2011 <- df
load('data/cleanedData2010.Rdata')
df2010 <- df
rm(df)

df2012$yr <- 2012
df2012 <- df2012[,-81]
df2011$yr <- 2011
df2011 <- df2011[,-81]
df2010$yr <- 2010


df <- rbind.data.frame(df2010, df2011, df2012)

df$Precinct <- as.integer(df$PCT)

rm(df2010)
rm(df2011)
rm(df2012)

save(df,file = 'data/Data10_12.Rdata')

load('data/Data10_12.Rdata')

require(plyr)
hourStat <- ddply(.data = df, .variables = c('hourStop', 'Precinct'),
                       summarize,
                       numStops = NROW(Precinct)
)

require(ggplot2)

sumStat <- ddply(.data = df, .variables = c('datestop'),
                  summarize,
                  numStops = NROW(weekStop)
)

ggplot(weekStat, aes(x = weekStop, y =numStops, group = interaction(monthStop, factor(yr)))) +
  geom_point() + geom_line(aes(color = factor(yr)))




load('data/cleanedData.Rdata')

sumStat <- ddply(.data = df, .variables = c('datestop','PCT'),
                 summarize,
                 numStops = NROW(weekStop)
)

total <- ddply(.data = df, .variables = c('PCT'),
               summarize,
               numStops = NROW(PCT)
)

df$XCOORD <- as.integer(df$XCOORD)
df$YCOORD <- as.integer(df$YCOORD)

pctCenters <- ddply(.data = df, .variables = c('PCT'), summarize,
                    numStops = NROW(PCT),
                    avgX = mean(XCOORD, na.rm = T),
                    avgY = mean(YCOORD, na.rm = T),
                    sdX = sd(XCOORD, na.rm = T),
                    sdY = sd(YCOORD, na.rm = T)                                        
)

df2<- merge(df, pctCenters, by = 'PCT')
df2$pctDist <- with(df2, ((XCOORD - avgX)^2 + (YCOORD - avgY)^2)^0.5)

pctDist <- ddply(.data = df2, .variables = c('PCT'), summarize,
                 numStops = NROW(PCT),
                 avgDist = mean(pctDist, na.rm = T)
)

df$PCT <- as.integer(df$PCT)
weekInMonth <- ddply(.data = df, .variables = c('weekStop', 'monthStop', 'PCT'),
                 summarize,
                 numStops = NROW(weekStop)
)



ggplot(weekInMonth[weekInMonth$PCT == 52,], aes(x = weekStop, y =numStops, group = monthStop)) +
  geom_point() + geom_line(aes(color = monthStop))


total <- total[order(-total[,2], total[1]),]

require(lubridate)
sumStat$date <- as.Date(sumStat$datestop)

require(reshape2)
sumStat2 <- sumStat[, -1]
sumStat2$PCT <- as.integer(sumStat2$PCT)
sumStat2 <- sumStat2[is.na(sumStat2$PCT) == F,]
sumStat2$Precinct <- do.call(paste, c('pct_',sumStat2[c('PCT')]))
sumStat2$Precinct <- sub(' ', '', sumStat2$Precinct)

sumStat3 <- dcast(sumStat2, date ~ Precinct, value.var = 'numStops',)
sumStat3[is.na(sumStat3)] <- 0



test <- ts(sumStat3$pct_75, start = min(sumStat$date), frequency=30,)
test2 <- decompose(test)
plot(test2)
