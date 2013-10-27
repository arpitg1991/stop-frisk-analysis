# set directory to your repository
setwd(dir = '~/stop-frisk-analysis/')

# load data

load('data/cleanedData.Rdata')

require(plyr)
require(ggplot2)
require(ggthemes)
# Distributions of physical features by race

hourSet<-ddply(.data = df, .variables = c('hourStop', 'CMDESC'),
               summarize,
               numStops = NROW(CMDESC)
               )


ggplot(hourSet, aes(x = as.numeric(hourStop), y= numStops, group = CMDESC)) +
  geom_point() + xlab('Hour of the day') + ylab('Number of incidents')  +
  geom_line(aes(group = CMDESC)) +
  theme_economist()


head(hourSet[ order(-hourSet[,3]),],20)

df$CMDESC2 <- 'Other'
df$CMDESC2[is.na(df$CMDESC)] <- 'None Provided'
df$CMDESC2[df$CMDESC == 'CREATING A HAZARD'] <- 'Creating a Hazard'
df$CMDESC2[df$CMDESC == 'RECKLESS ENDANGERMENT PROPERTY'] <- 'Reckless Endangerment Property'

hourSet<-ddply(.data = df, .variables = c('hourStop', 'CMDESC2'),
               summarize,
               numStops = NROW(CMDESC)
)

ggplot(hourSet, aes(x = hourStop), y= numStops)) +
  geom_bar(stat=identity, aes(group = ))

img = qplot(hourStop, data = df, geom = 'bar', fill = race, binwidth = 1) +
  facet_wrap(~CMDESC2) +
  theme_economist() +
  xlim(0,23) +
  xlab('Hour in the day') +
  ylab('Number of stops')

ggsave(file="hourStop.png", plot=img, width=6, height=3, units = 'in')

img = qplot(weekStop, data = df, geom = 'bar', fill = race, binwidth = 1) +
  facet_wrap(~CMDESC2) +
  theme_economist() + 
  xlim(1,52) +
  xlab('Week in the year')+
  ylab('Number of stops')


ggsave(file="weekStop.png", plot=img, width=6, height=3, units = 'in')



