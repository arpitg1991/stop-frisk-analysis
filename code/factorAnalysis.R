load('data/frisk.RData')
library('psych')
library('GPArotation')
frisk1 <- as.data.frame(cbind(frisk[,406],frisk[,412],frisk[,240],frisk[,246],frisk[,254],frisk[,359],frisk[,297]))#income,foodstmps,highScool,graduateDegree,homeLanguageEnglish,noSocialSecurity,unEmployed
scaledFrisk1 <- as.data.frame(scale(frisk1))
fa.parallel(frisk1)
corMat1 <- cor (frisk1)
solution <- fa(r = frisk1, nfactors = 3, rotate = "varimax", fm = "wls",max.iter = 500)
##########################################################################################
frisk2 <- as.data.frame(cbind(frisk[,208],frisk[,218],frisk[,406],frisk[,412],frisk[,240],frisk[,246],frisk[,254],frisk[,359],frisk[,297]))#blacks,hispanic,income,foodstmps,highScool,graduateDegree,homeLanguageEnglish,noSocialSecurity,unEmployed
scaledFrisk2 <- as.data.frame(scale(frisk2))
fa.parallel(frisk2)
corMat1 <- cor (frisk2)
solution <- fa(r = frisk2, nfactors = 3, rotate = "varimax", fm = "wls",max.iter = 500)
#############################################################################################
# frisk[,369] #number of houses with SNAP
# frisk [,406] #average per capita income
# frisk[,407] #income white
# frisk[,408] #income black
# frisk[,409] #income asian
# frisk[,410] #income not hispanic
# frisk[,411] #income hispanic
# frisk[,413] #number of houses with food stamps 
# frisk[,437] #number of childer under two parents
# frisk[,439] #number of childer under one parent
# frisk[,415] #percentage of households white
# frisk[,419] #percentage of households black
# frisk[,423] #percentage of households asian
# frisk[,427] #percentage of households not hispanic
# frisk[,431] #percentage of households hispanic
# frisk[,356] #percentage of houses with social security
# frisk[,362] #percentage of houses with supplemental security
# frisk[,366] #percentage of houses with public assistance 
# frisk[,321] #percentage enrolled in college
# frisk[,319] #percentage enrolled grade 1 to 12
# frisk[,317] #percentage enrolled in KG
# frisk[,265] #percentage of no income individuals
# frisk[,255] #percentage of home  with language english
# frisk[,257] #percentage of home with lang spanis
# frisk[,258] #percentage of home with lang other
frisk3 <- as.data.frame(cbind(frisk[,369], frisk[,406],frisk[,407],frisk[,408],frisk[,409],
                              frisk[,410],frisk[,411],frisk[,413],frisk[,437],frisk[,439],
                              frisk[,415],frisk[,419],frisk[,423],frisk[,427],frisk[,431],
                              frisk[,356],frisk[,362],frisk[,366],frisk[,321],frisk[,319],
                              frisk[,317],frisk[,265],frisk[,255],frisk[,257],frisk[,258] ))
scaledFrisk3 <- as.data.frame(scale(frisk3))
fa.parallel(scaledFrisk3)
corMat1 <- cor (frisk3)
solution <- fa(r = frisk3, nfactors = 8, rotate = "varimax", fm = "wls",max.iter = 500)
names(frisk3)