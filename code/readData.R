
### Once you initialize your repositor in line 5, this script will create and save the Rdata with cleaned 2012 data.



# set directory to your repository
setwd(dir = '~/stop-frisk-analysis/')

require(foreign)
df <- as.data.frame(read.spss('data/raw/2012.por'))

desc <- read.csv('data/detailcm.csv')

# merge suspected crime codes.
df$DETAILCM <- as.numeric(df$DETAILCM)
df2 <- merge(df, desc, all.x = T)

require(plyr)
require(stringr)
# clean date and time variable
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

df2$arrestMade <- as.numeric(with(df2, ARSTMADE=='Y'))
df2$frisked <- as.numeric(with(df2, FRISKED=='Y'))

df <- df2

save(df, file = 'data/cleanedData.Rdata')

# loading the data example...
load(file = 'data/cleanedData.Rdata')