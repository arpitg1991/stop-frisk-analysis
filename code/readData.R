
### Once you initialize your repositor in line 5, this script will create and save the Rdata with cleaned 2012 data.



# set directory to your repository
setwd(dir = '~/stop-frisk-analysis/')

require(foreign)
df <- as.data.frame(read.spss('data/raw/2012.por'),stringsAsFactors=F)

desc <- read.csv('data/detailcm.csv')

# merge suspected crime codes.
df$DETAILCM<- as.integer(df$DETAILCM)
df2 <- merge(df, desc, by = 'DETAILCM', all.x = T)

require(plyr)
require(stringr)
# clean date and time variable
df2$d <- str_replace_all(as.character(df2$DATESTOP), pattern = ' ', replace = '')
df2$t <- str_replace_all(as.character(df2$TIMESTOP), pattern = ' ', replace = '')

df2$d[nchar(df2$d)==7] <- paste('0',df2$d[nchar(df2$d)==7], sep = '')
df2$t[nchar(df2$t)==3] <- paste('0',df2$t[nchar(df2$t)==3], sep = '')
df2$t[nchar(df2$t)==2] <- paste('00',df2$t[nchar(df2$t)==2], sep = '')

df2$hourStop <- as.integer(substr(df2$t, 1,2))
df2$datestop <- as.POSIXct(as.Date(df2$d, '%m%d%Y'))

require(lubridate)
df2$monthStop <- as.integer(month(df2$datestop))
df2$weekStop <- as.integer(week(df2$datestop))
df2$wkdayStop <- weekdays(df2$datestop)
df2$dayStop <- as.integer(day(df2$datestop))

df2$arrestMade <- as.integer(with(df2, ARSTMADE=='Y'))
df2$frisked <- as.integer(with(df2, FRISKED=='Y'))

df = df2


# Drop out those who are older than 95 and younger than 5
df <- df[df$AGE<=95, ]
df <- df[df$AGE>=5, ]

df$ageBin <-  with(df, cut(AGE, breaks=c(4, 18, 21, 24, 30, 41, 60, 95)))
df$race[df$RACE=='W'] <- 'White'
df$race[df$RACE=='B'] <- 'Black'
df$race[df$RACE=='P'|df$RACE=='Q'] <- 'Hispanic'
df$race[is.na(df$race)] <- 'Other'

df$heightInches <- as.integer(df$HT_FEET) * 12 + as.integer(df$HT_IN)
df$weight <- as.integer(df$WEIGHT)


save(df, file = 'data/cleanedData2012.Rdata')