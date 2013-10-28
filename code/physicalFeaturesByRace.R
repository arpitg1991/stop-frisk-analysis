setwd(dir = '~/stop-frisk-analysis/')
load('data/cleanedData.Rdata')

require(ggplot2)
require(ggthemes)

img = ggplot(df, aes(AGE)) + 
  geom_histogram(color = 'white', binwidth = 10) + 
  facet_wrap(~race) +
  theme_economist() +
  xlab('Age') +
  ylab('Number of stops')
ggsave(file="ageHist.png", plot=img, width=6, height=3, units = 'in')


img = ggplot(df, aes(heightInches)) + 
  geom_histogram(color = 'white', binwidth = 2) + 
  facet_wrap(~race) +
  theme_economist() +
  xlab('Height in inches') +
  ylab('Number of stops')
ggsave(file="heightHist.png", plot=img, width=6, height=3, units = 'in')

img = ggplot(df, aes(weight)) + 
  geom_histogram(color = 'white', binwidth = 20) + 
  facet_wrap(~race) +
  theme_economist() +
  xlab('Weight in lbs') +
  ylab('Number of stops')
ggsave(file="weightHist.png", plot=img, width=6, height=3, units = 'in')

img = qplot(BUILD, data = df, geom = 'bar') +
  theme_economist() + 
  ylab('Number of stops') +
  facet_wrap(~race)
ggsave(file="build.png", plot=img, width=6, height=3, units = 'in')

