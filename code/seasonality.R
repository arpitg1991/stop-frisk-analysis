setwd(dir='~/stop-frisk-analysis/')

load('data/cleanedData2012.Rdata')

require(plyr)
require(lubridate)
sumStat <- ddply(.data = df, .variables = c('dayStop', 'PCT'),
                 summarize,
                 numStops = NROW(dayStop)
)

sumStat2 <- ddply(.data = sumStat, .variables = c('dayStop'),
                  summarize,
                  avgStops = mean(numStops))

ggplot(data = sumStat2, aes(x = dayStop, y = avgStops)) + geom_line()


sumStat <- ddply(.data = df, .variables = c('datestop','PCT'),
                 summarize,
                 numStops = NROW(weekStop)
)

sumStat$date <- as.Date(sumStat$datestop)

aggStat <- ddply(.data = df, .variables = c('datestop'),
                 summarize,
                 numStops = NROW(weekStop)
)

require(reshape2)
sumStat2 <- sumStat[, -1]
sumStat2$PCT <- as.integer(sumStat2$PCT)
sumStat2 <- sumStat2[is.na(sumStat2$PCT) == F,]
sumStat2$Precinct <- do.call(paste, c('pct_',sumStat2[c('PCT')]))
sumStat2$Precinct <- sub(' ', '', sumStat2$Precinct)

sumStat3 <- dcast(sumStat2, date ~ Precinct, value.var = 'numStops',)
sumStat3[is.na(sumStat3)] <- 0


# Time Series Plot by precinct
test <- ts(sumStat3$pct_106, start = min(sumStat$date), frequency=30,)
test2 <- decompose(test)
plot(test2)
Seasonality_Precinct22 <- test2$seasonal
plot(test2)

}
# Time Series Plot for entire series
test <- ts(aggStat$numStops, start = min(sumStat$date), frequency=28,)
test2 <- decompose(test)
plot(test2)




# Obtain seasonal components and metric
getSeasonalityMetric <- function(series){
  test <- ts(series, start = min(sumStat3$date), frequency = 30)
  test2 <- decompose(test)
  seasonalComponent <- test2$seasonal
  rangeSeasonal <- max(seasonalComponent) - min(seasonalComponent)
  avgTrend <- mean(test2$trend, na.rm = T)
  seasonalityMetric <- rangeSeasonal / avgTrend * 100
  print(seasonalityMetric)
}


getSeasonalityComp <- function(series){
  test <- ts(series, start = min(sumStat3$date), frequency = 30)
  test2 <- decompose(test)
  seasonalComponent <- test2$seasonal
  rangeSeasonal <- max(seasonalComponent) - min(seasonalComponent)
}

getTrend <- function(series){
  test <- ts(series, start = min(sumStat3$date), frequency = 30)
  test2 <- decompose(test)
  avgTrend <- mean(test2$trend, na.rm = T)
}


require(stringr)

temp <- str_replace(names(seasonality), 'pct_', '')
names(seasonality) <- temp

seasonality <- as.data.frame(seasonality)
seasonality$Precinct <- rownames(seasonality)
write.table(seasonality,file = 'seasonalityByPrecinct.csv', sep = ',', row.names=F)


## PLOTS

seasonalityMetric <- apply(sumStat3[,2:77], MARGIN= 2, FUN = getSeasonalityMetric)
seasonalityComponent <- apply(sumStat3[,2:77], MARGIN= 2, FUN = getSeasonalityComp)
precinctTrend <- apply(sumStat3[,2:77], MARGIN= 2, FUN = getTrend)

require(ggthemes)

df <- as.data.frame(cbind(seasonalityMetric, seasonalityComponent, precinctTrend))
names(df) = c('seasonalityIndex', 'seasonalityComponent', 'trend')
require(ggplot2)

seasonalityHistogram <- ggplot(df, aes(x = seasonalityIndex)) + geom_histogram(aes(y = ..density..)) +  geom_density() +
  xlab('Seasonality Index') + theme_tufte()

seasonalityScatter <- ggplot(df, aes(x = precinctTrend, y = seasonalityComponent, colour = seasonalityIndex)) +
  geom_point(aes(size = seasonalityIndex)) + theme_tufte() + 
  xlab('Trend # of stops per day') + ylab('Range of seasonal component') +
  scale_colour_continuous(name = 'Seasonality Index', guide=FALSE) + scale_size_continuous(name = 'Seasonality Index')

multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  require(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}

multiplot(seasonalityHistogram,seasonalityScatter, cols = 2)
