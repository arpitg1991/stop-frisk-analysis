#table(df$PCT)
#table(df$FRISKED)
#table(df$FRISKED, df$SEARCHED)
#with(df, table(PCT, FRISKED))
#with(df, table(PCT, FRISKED, CONTRABN, ADTLREPT, PISTOL, RIFLSHOT, ASLTWEAP, KNIFCUTI, MACHGUN, OTHRWEAP, PF_HANDS, PF_WALL, PF_GRND,
#               PF_DRWEP, PF_PTWEP,PF_BATON,PF_HCUFF,PF_PEPSP,PF_OTHER))
library(plyr)
counts1 <- ddply(df, .(df$PCT, df$FRISKED, df$CONTRABN), nrow)
names(counts1) <- c("PCT", "FRISKED", "CONTRABN", "FREQ")

counts1 <- transform(counts1, PERCENTAGE = ((FREQ / 530691) * 100))
write.table(counts1,file="counts1.csv",sep=",",row.names=T)
as.numeric(counts1$PCT)

#Deleted counts2 because there are no reports of ADTLREPT for any precinct 

counts3 <- ddply(df, .(df$PCT, df$FRISKED, df$KNIFCUTI), nrow)
names(counts3) <- c("PCT", "FRISKED", "KNIFCUTI", "FREQ")

counts3 <- transform(counts3, PERCENTAGE = ((FREQ / 530691) * 100))
write.table(counts3,file="counts3.csv",sep=",",row.names=T)
as.numeric(counts3$PCT)


counts4 <- ddply(df, .(df$PCT, df$FRISKED, df$PISTOL), nrow)
names(counts4) <- c("PCT", "FRISKED", "PISTOL", "FREQ")

counts4 <- transform(counts4, PERCENTAGE = ((FREQ / 530691) * 100))
write.table(counts4,file="counts4.csv",sep=",",row.names=T)
as.numeric(counts4$PCT)


counts5 <- ddply(df, .(df$PCT, df$FRISKED, df$RIFLSHOT), nrow)
names(counts5) <- c("PCT", "FRISKED", "RIFLSHOT", "FREQ")

counts5 <- transform(counts5, PERCENTAGE = ((FREQ / 530691) * 100))
write.table(counts5,file="counts5.csv",sep=",",row.names=T)
as.numeric(counts5$PCT)


counts6 <- ddply(df, .(df$PCT, df$FRISKED, df$ASLTWEAP), nrow)
names(counts6) <- c("PCT", "FRISKED", "ASLTWEAP", "FREQ")

counts6 <- transform(counts6, PERCENTAGE = ((FREQ / 530691) * 100))
write.table(counts6,file="counts6.csv",sep=",",row.names=T)
as.numeric(counts6$PCT)


counts7 <- ddply(df, .(df$PCT, df$FRISKED, df$MACHGUN), nrow)
names(counts7) <- c("PCT", "FRISKED", "MACHGUN", "FREQ")

counts7 <- transform(counts7, PERCENTAGE = ((FREQ / 530691) * 100))
write.table(counts7,file="counts7.csv",sep=",",row.names=T)
as.numeric(counts7$PCT)


counts8 <- ddply(df, .(df$PCT, df$FRISKED, df$OTHRWEAP), nrow)
names(counts8) <- c("PCT", "FRISKED", "OTHRWEAP", "FREQ")

counts8 <- transform(counts8, PERCENTAGE = ((FREQ / 530691) * 100))
write.table(counts8,file="counts8.csv",sep=",",row.names=T)
as.numeric(counts8$PCT)


counts9 <- ddply(df, .(df$PCT, df$FRISKED, df$ARSTMADE), nrow)
names(counts9) <- c("PCT", "FRISKED", "ARSTMADE", "FREQ")

counts9 <- transform(counts9, PERCENTAGE = ((FREQ / 530691) * 100))
write.table(counts9,file="counts9.csv",sep=",",row.names=T)
as.numeric(counts9$PCT)


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

Total <- cbind.data.frame(counts1, counts3, counts4, counts5, counts6, counts7, counts8, counts9)
PCT1 <- merge(counts1, counts3, counts4, counts5, counts6, counts7, counts8, counts9, by = "PCT")

#vars <- names(df)[26:42]
#df2 <- df
#df2[df2=="N"] <- 0
#df2[df2=="Y"] <- 1





#aggTable <- ddply(df2, .variables'PCT', summarize,
#                  sumKnife = sum(KNIFE)
#                  totalForce )
#View(aggTable)
