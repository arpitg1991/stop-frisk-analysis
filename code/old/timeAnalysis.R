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
  geom_line(aes(group = CMDESC, color = CMDESC)) +
  theme_economist()


head(hourSet[ order(-hourSet[,3]),],20)

df$CMDESC2 <- 'Other'
df$CMDESC2[df$CMDESC == 'CPW'] <- 'Criminal Possession of Weapon'
df$CMDESC2[df$CMDESC == 'ROBBERY'] <- 'Robbery'
df$CMDESC2[df$CMDESC == 'GRAND LARCENY AUTO'] <- 'Grand Larceny Auto'
df$CMDESC2[df$CMDESC == 'CRIMINAL TRESPASS'] <- 'Criminal Trespass'
df$CMDESC2[df$CMDESC == 'BURGLARY'] <- 'Burglary'
df$CMDESC2[df$CMDESC == 'CRIMINAL POSSESSION OF MARIHUANA'] <- 'Criminal Possession of Marijuana'
df$CMDESC2[df$CMDESC == 'ASSAULT'] <- 'Assault'
df$CMDESC2[df$CMDESC == 'GRAND LARCENY'] <- 'Grand Larceny'



hourSet<-ddply(.data = df, .variables = c('hourStop', 'CMDESC2'),
               summarize,
               numStops = NROW(CMDESC)
)

ggplot(hourSet, aes(x = as.numeric(hourStop), y= numStops, group = CMDESC2)) +
  geom_point() + xlab('Hour of the day') + ylab('Number of incidents')  +
  geom_line(aes(group = CMDESC2, color = CMDESC2)) +
  theme_economist()


weekSet<-ddply(.data = df, .variables = c('weekStop', 'CMDESC2'),
               summarize,
               numStops = NROW(CMDESC)
)


ggplot(weekSet, aes(x = as.numeric(weekStop), y= numStops, group = CMDESC2)) +
  geom_point() + xlab('Week in the year') + ylab('Number of incidents')  +
  geom_line(aes(group = CMDESC2, color = CMDESC2)) +
  theme_economist()


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



