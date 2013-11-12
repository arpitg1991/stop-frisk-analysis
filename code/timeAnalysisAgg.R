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


weekSet<-ddply(.data = df, .variables = c('weekStop', 'CMDESC2'),
               summarize,
               numStops = NROW(CMDESC)
)


img = 
  ggplot(weekSet, aes(x = as.numeric(weekStop), y= numStops, group = CMDESC2)) +
  geom_point() + xlab('Week in the year') + ylab('Number of stops')  +
  geom_line(aes(group = CMDESC2, color = CMDESC2)) +
  theme_economist() + theme(legend.position = 'right') 
ggsave(file="week_desc.png", plot=img, width=6, height=3, units = 'in')


hourSet<-ddply(.data = df, .variables = c('hourStop', 'CMDESC2'),
               summarize,
               numStops = NROW(CMDESC)
)


img = ggplot(hourSet, aes(x = as.numeric(hourStop), y= numStops, group = CMDESC2)) +
  geom_point() + xlab('Hour of the day') + ylab('Number of stops')  +
  geom_line(aes(group = CMDESC2, color = CMDESC2)) +
  theme_economist() + theme(legend.position = 'right') 

ggsave(file="hour_desc.png", plot=img, width=6, height=3, units = 'in')




dtest <- ddply(.data = df, 
               .variables = c('race','weekStop'),
               summarize, 
               numStops = NROW(CMDESC)
)
ggplot(dtest, aes(x = weekStop, y = numStops, group = race)) + geom_line(aes(color = race))
