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
