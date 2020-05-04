##R.Data file
#load("D:/Post_NCBS/NCF/migration/ebd_IN_relMar-2020/filtered_ebd.RData")

#setwd("D:/Post_NCBS/NCF/migration")
#source('D:/Post_NCBS/NCF/migration/new_functions.R')

######################
## Run cleanmodifydata() only once with the correct data path and sensitive data path (.txt files) specified
## Subsequently only load dataforfreq.RData (saved by the previous function in the working directory)

source('~/GitHub/migration/new_functions.R')
cleanmodifydata(datapath = "ebd_IN_relDec-2019.txt", sensitivedatapath = "Sensitive_India_may 2019.csv")

load("dataforfreq.RData")
source('~/GitHub/migration/new_functions.R')
ggp = worldbasemap()

#extrafont::loadfonts(device="win")


#migrationmap(ggp = ggp, rawpath1 = "ebd_tylwar1_relMar-2020.txt",  rawpathPhoto = "D:/Post_NCBS/NCF/migration/tlwa.jpg", res = 144,range = 35,step = 10,fps = 5, col1 = "#c26023", yaxis = c(0,0.2), pointsize = 2, minlong = 60,minlat = 5,maxlong = 100, maxlat = 36,data = data)

##Add Species1 and SciName for for side panel

migrationmap(ggp = ggp, Species1 = "White-throated Needletail", SciName = "Hirundapus caudacutus",
             rawpath1 = "ebd_whtnee_relFeb-2020.txt", rawpathPhoto = "WTNE.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 50,fps = 5, col1 = "#ffbd1c", 
             minlong = 70,minlat = -45,maxlong = 180, maxlat = 55,
             pointsize = 2.5, dataall = data, migstatus = "S", credit = "Chris Bromley")

migrationmap(ggp = ggp, Species1 = "Green Warbler", SciName = "Phylloscopus nitidus",
             rawpath1 = "ebd_grnwar1_relMar-2020.txt", rawpathPhoto = "GRWA.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 50,fps = 5, col1 = "#ffbd1c", 
             minlong = 17,minlat = 4,maxlong = 112, maxlat = 52,
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "David Raju")

migrationmap(ggp = ggp, Species1 = "Red-headed Bunting", SciName = "Emberiza bruniceps",
             rawpath1 = "ebd_rehbun1_relMar-2020.txt", rawpathPhoto = "RHBU.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 50,fps = 5, col1 = "#ffbd1c", 
             minlong = 33,minlat = 5,maxlong = 133, maxlat = 58,
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Raju Kasambe")

migrationmap(ggp = ggp, Species1 = "Large-billed Leaf Warbler", SciName = "Phylloscopus magnirostris",
             rawpath1 = "ebd_lblwar1_relMar-2020.txt", rawpathPhoto = "LBLW.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 50,fps = 5, col1 = "#ffbd1c", 
             minlong = 46,minlat = 5,maxlong = 145, maxlat = 50,
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "David Cook")

migrationmap(ggp = ggp, Species1 = "Brown-breasted Flycatcher", SciName = "Muscicapa muttui",
             rawpath1 = "ebd_brbfly2_relMar-2020.txt", rawpathPhoto = "BBFC.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 50,fps = 5, col1 = "#ffbd1c", 
             minlong = 46,minlat = 5,maxlong = 145, maxlat = 50,
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Saswat Mishra")

migrationmap(ggp = ggp, Species1 = "Common Cuckoo", SciName = "Cuculus canorus",
             rawpath1 = "ebd_comcuc_relMar-2020.txt", rawpathPhoto = "COCU.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 50,fps = 5, col1 = "#ffbd1c", 
             minlong = -35,minlat = -35,maxlong = 180,maxlat = 80, 
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Ron Knight")


########################### high res runs


migrationmap(ggp = ggp, Species1 = "White-throated Needletail", SciName = "Hirundapus caudacutus",
             rawpath1 = "ebd_whtnee_relFeb-2020.txt", rawpathPhoto = "WTNE.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 2,fps = 10, col1 = "#ffbd1c", 
             minlong = 70,minlat = -45,maxlong = 180, maxlat = 55,
             pointsize = 2.5, dataall = data, migstatus = "S", credit = "Chris Bromley")

migrationmap(ggp = ggp, Species1 = "Green Warbler", SciName = "Phylloscopus nitidus",
             rawpath1 = "ebd_grnwar1_relMar-2020.txt", rawpathPhoto = "GRWA.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 2,fps = 10, col1 = "#ffbd1c", 
             minlong = 17,minlat = 4,maxlong = 112, maxlat = 52,
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "David Raju")

migrationmap(ggp = ggp, Species1 = "Red-headed Bunting", SciName = "Emberiza bruniceps",
             rawpath1 = "ebd_rehbun1_relMar-2020.txt", rawpathPhoto = "RHBU.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 2,fps = 10, col1 = "#ffbd1c", 
             minlong = 33,minlat = 5,maxlong = 133, maxlat = 58,
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Raju Kasambe")

migrationmap(ggp = ggp, Species1 = "Large-billed Leaf Warbler", SciName = "Phylloscopus magnirostris",
             rawpath1 = "ebd_lblwar1_relMar-2020.txt", rawpathPhoto = "LBLW.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 2,fps = 10, col1 = "#ffbd1c", 
             minlong = 46,minlat = 5,maxlong = 145, maxlat = 50,
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "David Cook")

migrationmap(ggp = ggp, Species1 = "Brown-breasted Flycatcher", SciName = "Muscicapa muttui",
             rawpath1 = "ebd_brbfly2_relMar-2020.txt", rawpathPhoto = "BBFC.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 2,fps = 10, col1 = "#ffbd1c", 
             minlong = 46,minlat = 5,maxlong = 145, maxlat = 50,
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Saswat Mishra")

migrationmap(ggp = ggp, Species1 = "Common Cuckoo", SciName = "Cuculus canorus",
             rawpath1 = "ebd_comcuc_relMar-2020.txt", rawpathPhoto = "COCU.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 2,fps = 10, col1 = "#ffbd1c", 
             minlong = -35,minlat = -35,maxlong = 180,maxlat = 80, 
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Ron Knight")
