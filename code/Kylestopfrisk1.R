#Run the readData.R file that Arpit has made before running this program
#This will create 17 csv files at the end that you will be able to sort
#normalisedFreq is the column that breaks down precentages of each weapon found as well as percentage breakdown of police force used


#table(df$PCT)
#table(df$FRISKED)
#table(df$FRISKED, df$SEARCHED)
#with(df, table(PCT, FRISKED))
#with(df, table(PCT, FRISKED, CONTRABN, ADTLREPT, PISTOL, RIFLSHOT, ASLTWEAP, KNIFCUTI, MACHGUN, OTHRWEAP, PF_HANDS, PF_WALL, PF_GRND,
#               PF_DRWEP, PF_PTWEP,PF_BATON,PF_HCUFF,PF_PEPSP,PF_OTHER))
library(plyr)
#install.packages('sqldf')
library(sqldf)
#install.packages('data.table')
library(data.table)
counts1 <- ddply(df, .(df$PCT, df$FRISKED, df$CONTRABN), nrow)
names(counts1) <- c("PCT", "FRISKED", "CONTRABN", "FREQ")

counts1 <- transform(counts1, PERCENTAGE = ((FREQ / 530691) * 100))
as.numeric(counts1$PCT)

#Deleted counts2 because there are no reports of ADTLREPT for any precinct 

counts3 <- ddply(df, .(df$PCT, df$FRISKED, df$KNIFCUTI), nrow)
names(counts3) <- c("PCT", "FRISKED", "KNIFCUTI", "FREQ")

counts3 <- transform(counts3, PERCENTAGE = ((FREQ / 530691) * 100))
as.numeric(counts3$PCT)

totalCounts1 <- sqldf('select PCT,sum(FREQ) as total from counts1 group by PCT')
count1Total <- merge (x=totalCounts1, y = counts1, by.x = 'PCT',by.y= 'PCT')
count1Total$total = as.double(count1Total$total)
count1Total$FREQ = as.double(count1Total$FREQ)

counts1Divided <- sqldf('select * , FREQ/total as normalisedFreq from count1Total')
counts4 <- ddply(df, .(df$PCT, df$FRISKED, df$PISTOL), nrow)
names(counts4) <- c("PCT", "FRISKED", "PISTOL", "FREQ")

counts4 <- transform(counts4, PERCENTAGE = ((FREQ / 530691) * 100))
as.numeric(counts4$PCT)


counts5 <- ddply(df, .(df$PCT, df$FRISKED, df$RIFLSHOT), nrow)
names(counts5) <- c("PCT", "FRISKED", "RIFLSHOT", "FREQ")

counts5 <- transform(counts5, PERCENTAGE = ((FREQ / 530691) * 100))
as.numeric(counts5$PCT)


counts6 <- ddply(df, .(df$PCT, df$FRISKED, df$ASLTWEAP), nrow)
names(counts6) <- c("PCT", "FRISKED", "ASLTWEAP", "FREQ")

counts6 <- transform(counts6, PERCENTAGE = ((FREQ / 530691) * 100))
as.numeric(counts6$PCT)


counts7 <- ddply(df, .(df$PCT, df$FRISKED, df$MACHGUN), nrow)
names(counts7) <- c("PCT", "FRISKED", "MACHGUN", "FREQ")

counts7 <- transform(counts7, PERCENTAGE = ((FREQ / 530691) * 100))
as.numeric(counts7$PCT)


counts8 <- ddply(df, .(df$PCT, df$FRISKED, df$OTHRWEAP), nrow)
names(counts8) <- c("PCT", "FRISKED", "OTHRWEAP", "FREQ")

counts8 <- transform(counts8, PERCENTAGE = ((FREQ / 530691) * 100))
as.numeric(counts8$PCT)


counts9 <- ddply(df, .(df$PCT, df$FRISKED, df$ARSTMADE), nrow)
names(counts9) <- c("PCT", "FRISKED", "ARSTMADE", "FREQ")

counts9 <- transform(counts9, PERCENTAGE = ((FREQ / 530691) * 100))
as.numeric(counts9$PCT)

totalCounts3 <- sqldf('select PCT,sum(FREQ) as total from counts3 group by PCT')
count3Total <- merge (x=totalCounts3, y = counts3, by.x = 'PCT',by.y= 'PCT')
count3Total$total = as.double(count3Total$total)
count3Total$FREQ = as.double(count3Total$FREQ)

counts3Divided <- sqldf('select * , FREQ/total as normalisedFreq from count3Total')


counts10 <- ddply(df, .(df$PCT, df$PF_HANDS), nrow)
names(counts10) <- c("PCT", "PF_HANDS", "FREQ")

counts10 <- transform(counts10, PERCENTAGE = ((FREQ / 530691) * 100))

counts11 <- ddply(df, .(df$PCT, df$PF_WALL), nrow)
names(counts11) <- c("PCT", "PF_WALL", "FREQ")

counts11 <- transform(counts11, PERCENTAGE = ((FREQ / 530691) * 100))

counts12 <- ddply(df, .(df$PCT, df$PF_GRND), nrow)
names(counts12) <- c("PCT", "PF_GRND", "FREQ")

counts12 <- transform(counts12, PERCENTAGE = ((FREQ / 530691) * 100))

counts13 <- ddply(df, .(df$PCT, df$PF_DRWEP), nrow)
names(counts13) <- c("PCT", "PF_DRWEP", "FREQ")

counts13 <- transform(counts13, PERCENTAGE = ((FREQ / 530691) * 100))

counts14 <- ddply(df, .(df$PCT, df$PF_PTWEP), nrow)
names(counts14) <- c("PCT", "PF_PTWEP", "FREQ")

counts14 <- transform(counts14, PERCENTAGE = ((FREQ / 530691) * 100))

counts15 <- ddply(df, .(df$PCT, df$PF_BATON), nrow)
names(counts15) <- c("PCT", "PF_BATON", "FREQ")

counts15 <- transform(counts15, PERCENTAGE = ((FREQ / 530691) * 100))

counts16 <- ddply(df, .(df$PCT, df$PF_HCUFF), nrow)
names(counts16) <- c("PCT", "PF_HCUFF", "FREQ")

counts16 <- transform(counts16, PERCENTAGE = ((FREQ / 530691) * 100))

counts17 <- ddply(df, .(df$PCT, df$PF_PEPSP), nrow)
names(counts17) <- c("PCT", "PF_PEPSP", "FREQ")

counts17 <- transform(counts17, PERCENTAGE = ((FREQ / 530691) * 100))

counts18 <- ddply(df, .(df$PCT, df$PF_OTHER), nrow)
names(counts18) <- c("PCT", "PF_OTHER", "FREQ")

counts18 <- transform(counts18, PERCENTAGE = ((FREQ / 530691) * 100))

totalCounts4 <- sqldf('select PCT,sum(FREQ) as total from counts4 group by PCT')
count4Total <- merge (x=totalCounts4, y = counts4, by.x = 'PCT',by.y= 'PCT')
count4Total$total = as.double(count4Total$total)
count4Total$FREQ = as.double(count4Total$FREQ)

counts4Divided <- sqldf('select * , FREQ/total as normalisedFreq from count4Total')

totalCounts5 <- sqldf('select PCT,sum(FREQ) as total from counts5 group by PCT')
count5Total <- merge (x=totalCounts5, y = counts5, by.x = 'PCT',by.y= 'PCT')
count5Total$total = as.double(count5Total$total)
count5Total$FREQ = as.double(count5Total$FREQ)

counts5Divided <- sqldf('select * , FREQ/total as normalisedFreq from count5Total')

totalCounts6 <- sqldf('select PCT,sum(FREQ) as total from counts6 group by PCT')
count6Total <- merge (x=totalCounts6, y = counts6, by.x = 'PCT',by.y= 'PCT')
count6Total$total = as.double(count6Total$total)
count6Total$FREQ = as.double(count6Total$FREQ)

counts6Divided <- sqldf('select * , FREQ/total as normalisedFreq from count6Total')

totalCounts7 <- sqldf('select PCT,sum(FREQ) as total from counts7 group by PCT')
count7Total <- merge (x=totalCounts6, y = counts7, by.x = 'PCT',by.y= 'PCT')
count7Total$total = as.double(count7Total$total)
count7Total$FREQ = as.double(count7Total$FREQ)

counts7Divided <- sqldf('select * , FREQ/total as normalisedFreq from count7Total')

totalCounts8 <- sqldf('select PCT,sum(FREQ) as total from counts8 group by PCT')
count8Total <- merge (x=totalCounts6, y = counts8, by.x = 'PCT',by.y= 'PCT')
count8Total$total = as.double(count8Total$total)
count8Total$FREQ = as.double(count8Total$FREQ)

counts8Divided <- sqldf('select * , FREQ/total as normalisedFreq from count8Total')

totalCounts9 <- sqldf('select PCT,sum(FREQ) as total from counts9 group by PCT')
count9Total <- merge (x=totalCounts9, y = counts9, by.x = 'PCT',by.y= 'PCT')
count9Total$total = as.double(count9Total$total)
count9Total$FREQ = as.double(count9Total$FREQ)

counts9Divided <- sqldf('select * , FREQ/total as normalisedFreq from count9Total')

totalCounts10 <- sqldf('select PCT,sum(FREQ) as total from counts10 group by PCT')
count10Total <- merge (x=totalCounts10, y = counts10, by.x = 'PCT',by.y= 'PCT')
count10Total$total = as.double(count10Total$total)
count10Total$FREQ = as.double(count10Total$FREQ)

counts10Divided <- sqldf('select * , FREQ/total as normalisedFreq from count10Total')

totalCounts11 <- sqldf('select PCT,sum(FREQ) as total from counts11 group by PCT')
count11Total <- merge (x=totalCounts11, y = counts11, by.x = 'PCT',by.y= 'PCT')
count11Total$total = as.double(count11Total$total)
count11Total$FREQ = as.double(count11Total$FREQ)

counts11Divided <- sqldf('select * , FREQ/total as normalisedFreq from count11Total')

totalCounts12 <- sqldf('select PCT,sum(FREQ) as total from counts12 group by PCT')
count12Total <- merge (x=totalCounts12, y = counts12, by.x = 'PCT',by.y= 'PCT')
count12Total$total = as.double(count12Total$total)
count12Total$FREQ = as.double(count12Total$FREQ)

counts12Divided <- sqldf('select * , FREQ/total as normalisedFreq from count12Total')

totalCounts13 <- sqldf('select PCT,sum(FREQ) as total from counts13 group by PCT')
count13Total <- merge (x=totalCounts13, y = counts13, by.x = 'PCT',by.y= 'PCT')
count13Total$total = as.double(count13Total$total)
count13Total$FREQ = as.double(count13Total$FREQ)

counts13Divided <- sqldf('select * , FREQ/total as normalisedFreq from count13Total')

totalCounts14 <- sqldf('select PCT,sum(FREQ) as total from counts14 group by PCT')
count14Total <- merge (x=totalCounts14, y = counts14, by.x = 'PCT',by.y= 'PCT')
count14Total$total = as.double(count14Total$total)
count14Total$FREQ = as.double(count14Total$FREQ)

counts14Divided <- sqldf('select * , FREQ/total as normalisedFreq from count14Total')

totalCounts15 <- sqldf('select PCT,sum(FREQ) as total from counts15 group by PCT')
count15Total <- merge (x=totalCounts15, y = counts15, by.x = 'PCT',by.y= 'PCT')
count15Total$total = as.double(count15Total$total)
count15Total$FREQ = as.double(count15Total$FREQ)

counts15Divided <- sqldf('select * , FREQ/total as normalisedFreq from count15Total')

totalCounts16 <- sqldf('select PCT,sum(FREQ) as total from counts16 group by PCT')
count16Total <- merge (x=totalCounts16, y = counts16, by.x = 'PCT',by.y= 'PCT')
count16Total$total = as.double(count16Total$total)
count16Total$FREQ = as.double(count16Total$FREQ)

counts16Divided <- sqldf('select * , FREQ/total as normalisedFreq from count16Total')

totalCounts17 <- sqldf('select PCT,sum(FREQ) as total from counts17 group by PCT')
count17Total <- merge (x=totalCounts17, y = counts17, by.x = 'PCT',by.y= 'PCT')
count17Total$total = as.double(count17Total$total)
count17Total$FREQ = as.double(count17Total$FREQ)

counts17Divided <- sqldf('select * , FREQ/total as normalisedFreq from count17Total')

totalCounts18 <- sqldf('select PCT,sum(FREQ) as total from counts18 group by PCT')
count18Total <- merge (x=totalCounts18, y = counts18, by.x = 'PCT',by.y= 'PCT')
count18Total$total = as.double(count18Total$total)
count18Total$FREQ = as.double(count18Total$FREQ)

counts18Divided <- sqldf('select * , FREQ/total as normalisedFreq from count18Total')

write.table(counts1Divided,file="CONTRABN.csv",sep=",",row.names=T)
write.table(counts3Divided,file="KNIFCUTI.csv",sep=",",row.names=T)
write.table(counts4Divided,file="PISTOL.csv",sep=",",row.names=T)
write.table(counts5Divided,file="RIFLSHOT.csv",sep=",",row.names=T)
write.table(counts6Divided,file="ASLTWEAP.csv",sep=",",row.names=T)
write.table(counts7Divided,file="MACHGUN.csv",sep=",",row.names=T)
write.table(counts8Divided,file="OTHRWEAP.csv",sep=",",row.names=T)
write.table(counts9Divided,file="ARSTMADE.csv",sep=",",row.names=T)
write.table(counts10Divided,file="PF_HANDS.csv",sep=",",row.names=T)
write.table(counts11Divided,file="PF_WALL.csv",sep=",",row.names=T)
write.table(counts12Divided,file="PF_GRND.csv",sep=",",row.names=T)
write.table(counts13Divided,file="PF_DRWEP.csv",sep=",",row.names=T)
write.table(counts14Divided,file="PF_PTWEP.csv",sep=",",row.names=T)
write.table(counts15Divided,file="PF_BATON.csv",sep=",",row.names=T)
write.table(counts16Divided,file="PF_HCUFF.csv",sep=",",row.names=T)
write.table(counts17Divided,file="PF_PEPSP.csv",sep=",",row.names=T)
write.table(counts18Divided,file="PF_OTHER.csv",sep=",",row.names=T)

counts19 <- ddply(df, .(df$PCT, df$PERSTOP, df$RACE), nrow)
names(counts19) <- c("PCT", "PERSTOP", "RACE", "FREQ")
counts19 <- transform(counts19, PCT = as.numeric(PCT), PERSTOP = as.numeric(PERSTOP), FREQ = as.numeric(FREQ))
#counts19.num <- as.numeric(counts19$PCT, counts19$PERSTOP, counts19$FREQ)
sapply(counts19, mode)
counts19 <- na.omit(counts19)
#counts19$PERSTOP_TOTAL <- counts19$PERSTOP * counts19$FREQ
counts19 <- transform(counts19, PERSTOP_TOTAL = PERSTOP * FREQ)
DT = data.table(counts19)
PERSTOP1 <- DT[,sum(PERSTOP_TOTAL), by='PCT,RACE']
FREQ1 <- DT[,sum(FREQ), by='PCT,RACE']
#install.packages('reshape2')
library('reshape2')
count19Total <- merge(PERSTOP1, FREQ1, by = c('PCT','RACE'))
count19Total <- transform(count19Total, AVG_PER_RACE = (V1.x / V1.y))
write.table(count19Total,file="AVGSTOP_RACE_PCT.csv",sep=",",row.names=T)


totalCounts19 <- sqldf('select *,sum(FREQ) as total from counts19 group by PCT and RACE')
count19Total <- merge(x=totalCounts19, y = counts19, by.x = 'PCT',by.y= 'PCT')
count19Total$total = as.double(count19Total$total)
count19Total$FREQ = as.double(count19Total$FREQ)

counts19Divided <- sqldf('select * , FREQ/total as normalisedFreq from count19Total')

write.table(counts19Divided,file="average_stop_duration.csv",sep=",",row.names=T)




#Total <- cbind.data.frame(counts1, counts3, counts4, counts5, counts6, counts7, counts8, counts9)
#PCT1 <- merge(counts1, counts3, counts4, counts5, counts6, counts7, counts8, counts9, by = "PCT")

#vars <- names(df)[26:42]
#df2 <- df
#df2[df2=="N"] <- 0
#df2[df2=="Y"] <- 1





#aggTable <- ddply(df2, .variables'PCT', summarize,
#                  sumKnife = sum(KNIFE)
#                  totalForce )
#View(aggTable)
sucCNTBAND <- sqldf('select PCT,CONTRABN,sum(FREQ) from counts1 group by PCT,CONTRABN having CONTRABN = "Y" ' )
sucKNIFCUTI <- sqldf('select PCT,KNIFCUTI,sum(FREQ) from counts3 group by PCT,KNIFCUTI having KNIFCUTI = "Y" ' )
sucPISTOL <- sqldf('select PCT,PISTOL,sum(FREQ) from counts4 group by PCT,PISTOL having PISTOL = "Y" ' )
sucRIFLSHOT <- sqldf('select PCT,RIFLSHOT,sum(FREQ) from counts5 group by PCT,RIFLSHOT having RIFLSHOT = "Y" ' )
sucASLTWEAP <- sqldf('select PCT,ASLTWEAP,sum(FREQ) from counts6 group by PCT,ASLTWEAP having ASLTWEAP = "Y" ' )
sucMACHGUN <- sqldf('select PCT,MACHGUN,sum(FREQ) from counts7 group by PCT,MACHGUN having MACHGUN = "Y" ' )
sucOTHRWEAP <- sqldf('select PCT,OTHRWEAP,sum(FREQ) from counts8 group by PCT,OTHRWEAP having OTHRWEAP = "Y" ' )
sucCNTBAND$PCT = as.numeric(sucCNTBAND$PCT)
sucKNIFCUTI$PCT = as.numeric(sucKNIFCUTI$PCT)
sucPISTOL$PCT = as.numeric(sucPISTOL$PCT)
sucRIFLSHOT$PCT = as.numeric(sucRIFLSHOT$PCT)
sucASLTWEAP$PCT = as.numeric(sucASLTWEAP$PCT)
sucMACHGUN$PCT = as.numeric(sucMACHGUN$PCT)
sucOTHRWEAP$PCT = as.numeric(sucOTHRWEAP$PCT)
sucARREST <- sqldf('select PCT,ARSTMADE,sum(FREQ) from counts9 group by PCT,ARSTMADE having ARSTMADE = "Y" ' )


write.table(sucCNTBAND,file="sucCNTBAND.csv",sep=",",row.names=T)
write.table(sucKNIFCUTI,file="sucKNIFCUTI.csv",sep=",",row.names=T)
write.table(sucPISTOL,file="sucPISTOL.csv",sep=",",row.names=T)
write.table(sucRIFLSHOT,file="sucRIFLSHOT.csv",sep=",",row.names=T)
write.table(sucASLTWEAP,file="sucASLTWEAP.csv",sep=",",row.names=T)
write.table(sucMACHGUN,file="sucMACHGUN.csv",sep=",",row.names=T)
write.table(sucOTHRWEAP,file="sucOTHRWEAP.csv",sep=",",row.names=T)
write.table(sucARREST,file="sucARREST.csv",sep=",",row.names=T)
#sucSTOPS <- sqldf('select PCT, sum(sum(FREQ)) from sucCNTBAND,sucKNIFCUTI,sucPISTOL,sucRIFLSHOT,sucASLTWEAP,sucMACHGUN,sucOTHRWEAP group by PCT')
#sucSTOPS <- sqldf('select sucKNIFCUTI.PCT, sucCNTBAND.COUNT + sucKNIFCUTI.COUNT as total from sucCNTBAND,sucKNIFCUTI where sucKNIFCUTI.PCT=sucCNTBAND.PCT ' )

#sucSTOPS <- merge(sucCNTBAND,sucKNIFCUTI,sucPISTOL,sucRIFLSHOT,sucASLTWEAP,sucMACHGUN,sucOTHRWEAP, by="PCT")

