# set directory to your repository
setwd(dir = '~/stop-frisk-analysis/')

# load data

load('data/cleanedData.Rdata')

require(plyr)
require(ggplot2)
require(ggthemes)
# Distributions of physical features by race

img = 
  qplot(hourStop, data = df, geom = 'bar', fill = race, binwidth = 1) +
  theme_economist() +
  xlim(0,23) +
  xlab('Hour in the day') +
  ylab('Number of stops')

ggsave(file="hourStop.png", plot=img, width=6, height=3, units = 'in')

img = 
  qplot(weekStop, data = df, geom = 'bar', fill = race, binwidth = 1) +
  theme_economist() + 
  xlim(1,52) +
  xlab('Week in the year')+
  ylab('Number of stops')

ggsave(file="weekStop.png", plot=img, width=6, height=3, units = 'in')


img = 
  qplot(dayStop, data = df, geom = 'bar', fill = race, binwidth = 1) +
  theme_economist() + 
  xlim(1,31) +
  xlab('Day in the month')+
  ylab('Number of stops')


ggsave(file="dayStop.png", plot=img, width=6, height=3, units = 'in')



dtest <- ddply(.data = df, 
               .variables = c('race','weekStop'),
               summarize, 
               numStops = NROW(CMDESC)
)
ggplot(dtest, aes(x = weekStop, y = numStops, group = race)) + geom_line(aes(color = race))
