##R.Data file
#load("D:/Post_NCBS/NCF/migration/ebd_IN_relMar-2020/filtered_ebd.RData")

#setwd("D:/Post_NCBS/NCF/migration")
#source('D:/Post_NCBS/NCF/migration/new_functions.R')

######################
## Run cleanmodifydata() only once with the correct data path and sensitive data path (.txt files) specified
## Subsequently only load dataforfreq.RData (saved by the previous function in the working directory)

cleanmodifydata(datapath = "ebd_IN_relDec-2019.txt", sensitivedatapath = "Sensitive_India_may 2019.csv")

load("dataforfreq.RData")
source('~/GitHub/migration/new_functions.R')
ggp = worldbasemap()

#extrafont::loadfonts(device="win")


#migrationmap(ggp = ggp, rawpath1 = "ebd_tylwar1_relMar-2020.txt",  rawpathPhoto = "D:/Post_NCBS/NCF/migration/tlwa.jpg", res = 144,range = 35,step = 10,fps = 5, col1 = "#c26023", yaxis = c(0,0.2), pointsize = 2, minlong = 60,minlat = 5,maxlong = 100, maxlat = 36,data = data)

##Add Species1 and SciName for for side panel

migrationmap(ggp = ggp, Species1 = "White-throated Needletail", SciName = "Hirundapus caudacutus",
             rawpath1 = "ebd_whtnee_relFeb-2020.txt", rawpathPhoto = "WTNE.jpg", yaxis = c(0,4), ybreaks = c(0,1,2,3),
             res = 144,range = 30,step = 50,fps = 5, col1 = "#ffbd1c", 
             minlong = 70,minlat = -45,maxlong = 180, maxlat = 55,
             pointsize = 2.5, dataall = data)

migrationmap(ggp = ggp, Species1 = "White-throated Needletail", SciName = "Hirundapus caudacutus",
             rawpath1 = "ebd_whtnee_relFeb-2020.txt", rawpathPhoto = "WTNE.jpg", yaxis = c(0,4), ybreaks = c(0,1,2,3),
             res = 144,range = 30,step = 2,fps = 10,
             minlong = 74,minlat = -35,maxlong = 170, maxlat = 50, col1 = "#ffbd1c", 
             pointsize = 2.5, dataall = data)
