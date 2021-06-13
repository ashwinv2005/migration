######################
## Run cleanmodifydata() only once with the correct data path and sensitive data path (.txt files) specified
## Subsequently only load dataforfreq.RData (saved by the previous function in the working directory)

source('~/GitHub/migration/new_functions.R')
cleanmodifydata(datapath = "ebd_IN_relApr-2020.txt", sensitivedatapath = "ebd_relApr-2020_sensitive.txt")

load("dataforfreq.RData")
source('~/GitHub/migration/new_functions.R')
ggp = worldbasemap()

#library(extrafontdb)
#extrafont::loadfonts(device="win")
#dev.off()


library(gifski)



##Add Species1 and SciName for for side panel

############ 2 species

start = Sys.time()
migrationmap2(ggp = ggp, Species1 = "Greenish Warbler", Species2 = "Green Warbler",
              rawpath1 = "ebd_grewar3_relMar-2020.txt", rawpath2 =  "ebd_grnwar1_relMar-2020.txt", 
              rawpathPhoto2 = "GRWA.jpg", rawpathPhoto1 = "GHWA.jpg", yaxis = c(-0.1,1.2),
              res = 144,range = 30,step = 3,fps = 10, col1 = "#449966", col2 = "#5e488a",
              minlong = -42,minlat = -32,maxlong = 180, maxlat = 70, impos = "L", grpos = "R",
              pointsize = 2.5, dataall = data, migstatus1 = "LM", migstatus2 = "LM" ,
              credit1 = "Dibyendu Ash", credit2 = "Arun Prabhu")

migrationmap2(ggp = ggp, Species1 = "Isabelline Shrike", Species2 = "Brown Shrike",
              rawpath1 = "ebd_isashr1_relMar-2020.txt", rawpath2 = "ebd_brnshr_relMar-2020.txt",
              rawpathPhoto1 = "ISSH.jpg", yaxis = c(-0.1,1.2), rawpathPhoto2 = "BRSH.jpg",
              res = 144,range = 30,step = 3,fps = 10, col1 = "#449966", col2 = "#5e488a", 
              minlong = -42,minlat = -32,maxlong = 180, maxlat = 70,
              pointsize = 2.5, dataall = data, migstatus1 = "LM", migstatus2 = "LM",
              credit1= "Pkspks", credit2 = "Sandip Das", impos = "BL", grpos = "L")
end = Sys.time()
end-start

start = Sys.time()
migrationmap(ggp = ggp, Species1 = "Red-headed Bunting", SciName = "Emberiza bruniceps",
             rawpath1 = "ebd_rehbun1_relMar-2020.txt", rawpathPhoto = "RHBU.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a", 
             minlong = -10,minlat = 5,maxlong = 170,maxlat = 70, impos = "R", grpos = "L",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Charles J. Sharp")
end = Sys.time()
end-start


start = Sys.time()
ggp = worldbasemapgreen()
migrationmapgreen(ggp = ggp, Species1 = "Red-headed Bunting", SciName = "Emberiza bruniceps",
                  rawpath1 = "ebd_rehbun1_relMar-2020.txt", rawpathPhoto = "RHBU.jpg", yaxis = c(-0.1,1.2),
                  res = 144,range = 30,step = 3,fps = 10, col1 = "#ffbd1c", 
                  minlong = -10,minlat = 5,maxlong = 170,maxlat = 70, impos = "R", grpos = "L",
                  pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Charles J. Sharp")
end = Sys.time()
end-start

start = Sys.time()
migrationmap(ggp = ggp, Species1 = "Ashy Drongo",
             rawpath1 = "ebd_ashdro1_relApr-2020.txt", rawpathPhoto = "ASDR.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a",
             minlong = 20,minlat = -20,maxlong = 180, maxlat = 65, impos = "R", grpos = "L",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Koshy koshy")
end = Sys.time()
end-start

migrationmap(ggp = ggp, Species1 = "Tytler's Leaf Warbler",
             rawpath1 = "ebd_tylwar1_relMar-2020.txt",  rawpathPhoto = "TLWA.jpg",
             res = 144,range = 35,step = 3,fps = 10, col1 = "#5e488a", yaxis = c(0,0.2),
             pointsize = 2.5, migstatus = "LM", minlong = 55,minlat = 5,maxlong = 105,
             maxlat = 40,dataall = data, impos = "R", grpos = "L",
             credit = "Vasanthjoshi49", credit_color = "white")

migrationmap(ggp = ggp, Species1 = "Indian Blue Robin",
             rawpath1 = "ebd_inbrob1_relApr-2020.txt", rawpathPhoto = "IBRO.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a",
             minlong = 45,minlat = 0,maxlong = 125, maxlat = 45, impos = "L", grpos = "R",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Tarun Menon")

migrationmap(ggp = ggp, Species1 = "European Bee-eater",
             rawpath1 = "ebd_eubeat1_relApr-2020.txt", rawpathPhoto = "EBEA.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a", 
             minlong = -20,minlat = -35,maxlong = 160,maxlat = 70, impos = "R", grpos = "R",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Stavros Toumanidis")

migrationmap(ggp = ggp, Species1 = "Lesser Flamingo",
             rawpath1 = "ebd_lesfla1_relApr-2020.txt", rawpathPhoto = "LEFL.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a", 
             minlong = 55,minlat = 5,maxlong = 105, maxlat = 40, impos = "R", grpos = "R",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Tarun Menon")

migrationmap(ggp = ggp, Species1 = "Gray Nightjar",
             rawpath1 = "ebd_grynig1_relApr-2020.txt", rawpathPhoto = "GRNI.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a",
             minlong = 55,minlat = -10,maxlong = 170, maxlat = 60, impos = "L", grpos = "L",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Saswat Mishra", credit_color = "white")

migrationmap(ggp = ggp, Species1 = "European Roller",
             rawpath1 = "ebd_eurrol1_relApr-2020.txt", rawpathPhoto = "EURO.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 8,fps = 5, col1 = "#5e488a", 
             minlong = -20,minlat = -35,maxlong = 160,maxlat = 70, impos = "R", grpos = "R",
             pointsize = 2.5, dataall = data, migstatus = "P", credit = "Subhadra Devi")

migrationmap(ggp = ggp, Species1 = "Hypocolius",
             rawpath1 = "ebd_hypoco1_relApr-2020.txt", rawpathPhoto = "HYPO.jfif", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a", 
             minlong = 20,minlat = 0,maxlong = 125,maxlat = 50, impos = "R", grpos = "R",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "pkspks")

migrationmap(ggp = ggp, Species1 = "Indian Golden Oriole",
             rawpath1 = "ebd_ingori1_relApr-2020.txt", rawpathPhoto = "IGOR.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a", 
             minlong = 40,minlat = 0,maxlong = 135,maxlat = 60, impos = "R", grpos = "L",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Imran Shah")

migrationmap(ggp = ggp, Species1 = "Gray-headed Lapwing",
             rawpath1 = "ebd_gyhlap1_relApr-2020.txt", rawpathPhoto = "GHLA.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a",
             minlong = 45,minlat = -5,maxlong = 165, maxlat = 60, impos = "L", grpos = "L",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "harum koh", credit_color = "white")

migrationmap(ggp = ggp, Species1 = "Pacific Golden-Plover",
             rawpath1 = "ebd_pagplo_relApr-2020.txt", rawpathPhoto = "PGPL.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a",
             minlong = -50,minlat = -50,maxlong = 180, maxlat = 70, impos = "L", grpos = "L",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Bernard Spragg", credit_color = "white")

migrationmap(ggp = ggp, Species1 = "Short-eared Owl",
             rawpath1 = "ebd_sheowl_relApr-2020.txt", rawpathPhoto = "SEOW.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a",
             minlong = -50,minlat = -20,maxlong = 180, maxlat = 70, impos = "L", grpos = "L",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "USFWS")

migrationmap2(ggp = ggp, Species1 = "Red-breasted Flycatcher", Species2 = "Taiga Flycatcher",
              rawpath1 = "ebd_rebfly_relApr-2020.txt", rawpath2 = "ebd_taifly1_relApr-2020.txt",
              rawpathPhoto1 = "RBFL.jpg", yaxis = c(-0.1,1.2), rawpathPhoto2 = "TAFL.jpg",
              res = 144,range = 30,step = 3,fps = 10, col1 = "#449966", col2 = "#5e488a", 
              minlong = -50,minlat = -32,maxlong = 180, maxlat = 70,
              pointsize = 2, dataall = data, migstatus1 = "LM", migstatus2 = "LM",
              credit1= "Garima Bhatia", credit2 = "Khoitran1957", impos = "BL", grpos = "L", credit1_color = "white")

migrationmap(ggp = ggp, Species1 = "Common Rosefinch",
             rawpath1 = "ebd_comros_relApr-2020.txt", rawpathPhoto = "CORO.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a",
             minlong = -50,minlat = -20,maxlong = 180, maxlat = 70, impos = "L", grpos = "L",
             pointsize = 2.5, dataall = data, migstatus = "S", credit = "Imran Shah")

migrationmap(ggp = ggp, Species1 = "Spot-winged Starling",
             rawpath1 = "ebd_spwsta1_relApr-2020.txt", rawpathPhoto = "SWST.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a",
             minlong = 50,minlat = 0,maxlong = 120, maxlat = 40, impos = "L", grpos = "R",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Subhadra Devi")

migrationmap(ggp = ggp, Species1 = "Amur Falcon", SciName = "Falco amurensis",
             rawpath1 = "ebd_amufal1_relMar-2020.txt", rawpathPhoto = "AMFA.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 7,fps = 5, col1 = "#5e488a", 
             minlong = -30,minlat = -35,maxlong = 180,maxlat = 65, impos = "L", grpos = "R",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Ian White")

migrationmap(ggp = ggp, Species1 = "Bar-headed Goose", SciName = "Anser indicus",
             rawpath1 = "ebd_bahgoo_relMar-2020.txt", rawpathPhoto = "BHGO.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 7,fps = 5, col1 = "#5e488a", 
             minlong = 30,minlat = 5,maxlong = 180,maxlat = 70, impos = "L", grpos = "R",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Mprasannak")

migrationmap(ggp = ggp, Species1 = "Sanderling",
             rawpath1 = "ebd_sander_relMay-2020.txt", rawpathPhoto = "SAND.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a", 
             minlong = -50,minlat = -50,maxlong = 180, maxlat = 70, impos = "L", grpos = "L",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Ssprmannheim")

migrationmap(ggp = ggp, Species1 = "Common Greenshank",
             rawpath1 = "ebd_comgre_relMay-2020.txt", rawpathPhoto = "COGR.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 50,fps = 10, col1 = "#5e488a", 
             minlong = -50,minlat = -50,maxlong = 180, maxlat = 70, impos = "L", grpos = "L",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "?sa Berndtsson")

migrationmap(ggp = ggp, Species1 = "Whimbrel",
             rawpath1 = "ebd_whimbr_relMay-2020.txt", rawpathPhoto = "WHIM.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a", 
             minlong = -55,minlat = -50,maxlong = 180, maxlat = 70, impos = "L", grpos = "L",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Shino jacob koottanad")

migrationmap(ggp = ggp, Species1 = "Forest Wagtail",
             rawpath1 = "ebd_forwag1_relMay-2020.txt", rawpathPhoto = "FOWA.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a",
             minlong = 40,minlat = -10,maxlong = 160, maxlat = 60, impos = "L", grpos = "L",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Jason Thompson")

migrationmap(ggp = ggp, Species1 = "Brown-headed Gull",
             rawpath1 = "ebd_bnhgul1_relMay-2020.txt", rawpathPhoto = "BHGU.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a", 
             minlong = 25,minlat = -10,maxlong = 150,maxlat = 55, impos = "L", grpos = "L",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Rushen")

migrationmap(ggp = ggp, Species1 = "Garganey",
             rawpath1 = "ebd_gargan_relMay-2020.txt", rawpathPhoto = "GARG.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a", 
             minlong = -55,minlat = -40,maxlong = 180,maxlat = 70, impos = "L", grpos = "R",
             pointsize = 2.5, dataall = data, migstatus = "S", credit = "Luciano 95")

migrationmap(ggp = ggp, Species1 = "Western Yellow Wagtail",
             rawpath1 = "ebd_gargan_relMar-2020.txt", rawpathPhoto = "WYWA.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 50,fps = 5, col1 = "#5e488a", 
             minlong = -42,minlat = -32,maxlong = 180,maxlat = 70, impos = "L", grpos = "R",
             pointsize = 2.5, dataall = data, migstatus = "S", credit = "afsarnayakkan")

migrationmap(ggp = ggp, Species1 = "Barn Swallow",
             rawpath1 = "ebd_gargan_relMar-2020.txt", rawpathPhoto = "WYWA.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 50,fps = 5, col1 = "#5e488a", 
             minlong = -42,minlat = -32,maxlong = 180,maxlat = 70, impos = "L", grpos = "R",
             pointsize = 2.5, dataall = data, migstatus = "S", credit = "afsarnayakkan")

migrationmap(ggp = ggp, Species1 = "Kashmir Flycatcher",
             rawpath1 = "ebd_kasfly1_relMay-2020.txt",  rawpathPhoto = "KAFL.jpg",
             res = 144,range = 35,step = 3,fps = 10, col1 = "#5e488a", yaxis = c(0,0.2),
             pointsize = 2.5, migstatus = "P", minlong = 55,minlat = 5,maxlong = 105,
             maxlat = 40,dataall = data, impos = "R", grpos = "L",
             credit = "Bhargav Dwaraki", credit_color = "white")

migrationmap(ggp = ggp, Species1 = "Rosy Starling", SciName = "Pastor roseus",
             rawpath1 = "ebd_rossta2_relMar-2020.txt", rawpathPhoto = "ROST.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a", 
             minlong = -25,minlat = -25,maxlong = 180, maxlat = 70, impos = "R",grpos = "L",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Imran Shah")

migrationmap(ggp = ggp, Species1 = "Yellow-browed Warbler", SciName = "Phylloscopus inornatus",
             rawpath1 = "ebd_yebwar3_relMar-2020.txt", rawpathPhoto = "YBWA.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a", 
             minlong = -60,minlat = -27,maxlong = 180,maxlat = 70, impos = "L", grpos = "R",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Frank Vassen")

migrationmap(ggp = ggp, Species1 = "White-throated Needletail", SciName = "Hirundapus caudacutus",
             rawpath1 = "ebd_whtnee_relFeb-2020.txt", rawpathPhoto = "WTNE.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a", 
             minlong = 0,minlat = -50,maxlong = 180, maxlat = 55,
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Chris Bromley", impos = "L", grpos = "L")

migrationmap(ggp = ggp, Species1 = "Oriental Pratincole", SciName = "Glareola maldivarum",
             rawpath1 = "ebd_oripra_relJul-2020.txt", rawpathPhoto = "ORPR.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a", 
             minlong = 0,minlat = -50,maxlong = 180, maxlat = 55,
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "JJ Harrison", impos = "L", grpos = "L")

migrationmap(ggp = ggp, Species1 = "Indian Pitta", SciName = "Pitta brachyura",
             rawpath1 = "ebd_indpit1_relMar-2020.txt", rawpathPhoto = "INPI.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a",
             minlong = 55,minlat = 5,maxlong = 105, maxlat = 40, impos = "R", grpos = "L",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Shantanu Kuvasekar")

migrationmap(ggp = ggp, Species1 = "Isabelline Shrike", SciName = "Lanius isabellinus",
             rawpath1 = "ebd_isashr1_relMar-2020.txt", rawpathPhoto = "ISSH.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a", 
             minlong = -42,minlat = -32,maxlong = 180,maxlat = 70, impos = "L", grpos = "R",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Pkspks")

migrationmap(ggp = ggp, Species1 = "Demoiselle Crane", SciName = "Grus virgo",
             rawpath1 = "ebd_demcra1_relApr-2020.txt", rawpathPhoto = "DECR.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a",
             minlong = -5,minlat = -5,maxlong = 180, maxlat = 70, impos = "R", grpos = "L",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Sumeet Moghe")

migrationmap(ggp = ggp, Species1 = "Common Cuckoo", SciName = "Cuculus canorus",
             rawpath1 = "ebd_comcuc_relMar-2020.txt", rawpathPhoto = "COCU.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a", 
             minlong = -42,minlat = -32,maxlong = 180,maxlat = 70, impos = "L", grpos = "R",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Mike McKenzie")

migrationmap(ggp = ggp, Species1 = "Common Crane", SciName = "Grus grus",
             rawpath1 = "ebd_comcra_relApr-2020.txt", rawpathPhoto = "COCR.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a",
             minlong = -15,minlat = -5,maxlong = 180, maxlat = 75, impos = "R", grpos = "L",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Marie-Lan Tay Pamart", credit_color = "white") 

migrationmap(ggp = ggp, Species1 = "Brown Shrike", SciName = "Lanius Cristatus",
             rawpath1 = "ebd_brnshr_relMar-2020.txt", rawpathPhoto = "BRSH.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a", 
             minlong = -42,minlat = -32,maxlong = 180,maxlat = 70, impos = "L", grpos = "L",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Rison Thumboor")

migrationmap(ggp = ggp, Species1 = "Bar-headed Goose", SciName = "Anser indicus",
             rawpath1 = "ebd_bahgoo_relMar-2020.txt", rawpathPhoto = "BHGO.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 100,fps = 10, col1 = "#5e488a", 
             minlong = -15,minlat = 5,maxlong = 180,maxlat = 70, impos = "R", grpos = "L",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Mprasannak")

migrationmap(ggp = ggp, Species1 = "Amur Falcon", SciName = "Falco amurensis",
             rawpath1 = "ebd_amufal1_relMar-2020.txt", rawpathPhoto = "AMFA.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a", 
             minlong = -30,minlat = -35,maxlong = 180,maxlat = 65, impos = "L", grpos = "R",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Ian White")

migrationmap(ggp = ggp, Species1 = "Crab-Plover", SciName = "Dromas ardeola",
             rawpath1 = "ebd_craplo1_relJul-2020.txt", rawpathPhoto = "CRPL.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a", 
             minlong = -20,minlat = -40,maxlong = 160, maxlat = 50, impos = "R",grpos = "R",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "afsarnayakkan")

migrationmap(ggp = ggp, Species1 = "Brown-breasted Flycatcher",
             rawpath1 = "ebd_brbfly2_relJul-2020.txt", rawpathPhoto = "BBFL.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a",
             minlong = 40,minlat = -10,maxlong = 160, maxlat = 60, impos = "L", grpos = "L",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Saswat Mishra")

migrationmap(ggp = ggp, Species1 = "Asian Brown Flycatcher",
             rawpath1 = "ebd_asbfly_relJul-2020.txt", rawpathPhoto = "ABFL.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a",
             minlong = 40,minlat = -20,maxlong = 170, maxlat = 60, impos = "L", grpos = "L",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "afsarnayakkan")

migrationmap(ggp = ggp, Species1 = "Great Cormorant",
             rawpath1 = "ebd_grecor_relJul-2020.txt", rawpathPhoto = "GRCO.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a", 
             minlong = -50,minlat = -50,maxlong = 180, maxlat = 70, impos = "L", grpos = "L",
             pointsize = 1.5, dataall = data, migstatus = "LM", credit = "Nrik Kiran")

migrationmap(ggp = ggp, Species1 = "Indian Paradise-Flycatcher",
             rawpath1 = "ebd_aspfly1_relJul-2020.txt", rawpathPhoto = "IPFL.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a", 
             minlong = 50,minlat = 0,maxlong = 125,maxlat = 45, impos = "R", grpos = "L",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Koshy Koshy", credit_color = "white")

migrationmap(ggp = ggp, Species1 = "Black Redstart",
             rawpath1 = "ebd_blared1_relJul-2020.txt", rawpathPhoto = "BLRE.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a", 
             minlong = -15,minlat = 0,maxlong = 170, maxlat = 70, impos = "R",grpos = "L",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Siva301in")

migrationmap(ggp = ggp, Species1 = "Pied Cuckoo",
             rawpath1 = "ebd_piecuc1_relJul-2020.txt", rawpathPhoto = "JACU.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a", 
             minlong = -42,minlat = -32,maxlong = 180,maxlat = 70, impos = "L", grpos = "R",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Rison Thumboor")

migrationmap(ggp = ggp, Species1 = "Chestnut-winged Cuckoo",
             rawpath1 = "ebd_chwcuc1_relJul-2020.txt", rawpathPhoto = "CWCU.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a",
             minlong = 40,minlat = -20,maxlong = 170, maxlat = 60, impos = "L", grpos = "L",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Rejaul karim.rk")

migrationmap(ggp = ggp, Species1 = "Blue-tailed Bee-eater",
             rawpath1 = "ebd_btbeat1_relJul-2020.txt", rawpathPhoto = "BTBE.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a",
             minlong = 40,minlat = -20,maxlong = 180, maxlat = 60, impos = "L", grpos = "L",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Charles J Sharp")

migrationmap(ggp = ggp, Species1 = "Chestnut-headed Bee-eater",
             rawpath1 = "ebd_chbeat1_relJul-2020.txt", rawpathPhoto = "CHBE.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a",
             minlong = 40,minlat = -20,maxlong = 160, maxlat = 50, impos = "L", grpos = "L",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Charles J Sharp")

migrationmap(ggp = ggp, Species1 = "Blue Rock-Thrush",
             rawpath1 = "ebd_burthr_relJul-2020.txt", rawpathPhoto = "BRTH.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a", 
             minlong = -42,minlat = -20,maxlong = 180,maxlat = 70, impos = "L", grpos = "L",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Artemy Voikhanskyr")

migrationmap2(ggp = ggp, Species1 = "Desert Wheatear", Species2 = "Pied Wheatear",
              rawpath1 = "ebd_deswhe1_relJul-2020.txt", rawpath2 = "ebd_piewhe1_relJul-2020.txt",
              rawpathPhoto1 = "DEWH.jpg", yaxis = c(-0.1,1.2), rawpathPhoto2 = "PIWH.jpg",
              res = 144,range = 30,step = 3,fps = 10, col1 = "#449966", col2 = "#5e488a",
              minlong = -52,minlat = -30,maxlong = 180, maxlat = 70, impos = "BL", grpos = "R",
              pointsize = 2.5, dataall = data, migstatus1 = "LM", migstatus2 = "LM" ,
              credit1= "Shantanu Kuveskar", credit2 = "Imran Shah")

#migrationmap(ggp = ggp, Species1 = "Little Pied Flycatcher",
 #           res = 144,range = 30,step = 50,fps = 10, col1 = "#5e488a",
  #           minlong = 50,minlat = -20,maxlong = 170, maxlat = 50, impos = "L", grpos = "L",
   #          pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Tarun Menon", credit_color = "white")

migrationmap(ggp = ggp, Species1 = "Yellow-eyed Pigeon",
             rawpath1 = "ebd_pabpig1_relJul-2020.txt", rawpathPhoto = "YEPI.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a", 
             minlong = 35,minlat = 5,maxlong = 120,maxlat = 60, impos = "R", grpos = "L",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Shreeram M V")

migrationmap(ggp = ggp, Species1 = "Eurasian Wryneck",
             rawpath1 = "ebd_eurwry_relJul-2020.txt", rawpathPhoto = "EUWR.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a", 
             minlong = -42,minlat = -20,maxlong = 180,maxlat = 70, impos = "L", grpos = "L",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Pepe Reigada")

migrationmap(ggp = ggp, Species1 = "Isabelline Wheatear",
              rawpath1 = "ebd_isawhe1_relJul-2020.txt", rawpathPhoto = "ISWH.jpg", yaxis = c(-0.1,1.2),
              res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a",
              minlong = -52,minlat = -30,maxlong = 180, maxlat = 70, impos = "L", grpos = "R",
              pointsize = 2.5, dataall = data, migstatus = "LM", credit= "UdayKiran28")

migrationmap2(ggp = ggp, Species1 = "Great White Pelican", Species2 = "Dalmatian Pelican",
              rawpath1 = "ebd_grwpel1_relJul-2020.txt", rawpath2 = "ebd_dalpel1_relJul-2020.txt",
              rawpathPhoto1 = "GWPE.jpg", yaxis = c(-0.1,1.2), rawpathPhoto2 = "DAPE.jpg",
              res = 144,range = 30,step = 3,fps = 10, col1 = "#449966", col2 = "#5e488a",
              minlong = -40,minlat = -35,maxlong = 180, maxlat = 70, impos = "L", grpos = "R",
              pointsize = 2.5, dataall = data, migstatus1 = "LM", migstatus2 = "LM" ,
              credit1= "Charles J Sharp", credit2 = "Alexandru Panoiu",credit1_color = "white" ,credit2_color = "white")

migrationmap(ggp = ggp, Species1 = "Little Tern",
             rawpath1 = "ebd_litter1_relJul-2020.txt", rawpathPhoto = "LITE.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a", 
             minlong = -50,minlat = -50,maxlong = 180, maxlat = 60,
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Hari Mohan Meena", impos = "L", grpos = "L")

migrationmap(ggp = ggp, Species1 = "Gull-billed Tern",
             rawpath1 = "ebd_gubter1_relJul-2020.txt", rawpathPhoto = "GBTE.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a", 
             minlong = -50 ,minlat = -50,maxlong = 180, maxlat = 60,
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Imran Shah", impos = "L", grpos = "L")

migrationmap2(ggp = ggp, Species2 = "Oriental Pratincole", Species1 = "Collared Pratincole",
             rawpath2 = "ebd_oripra_relJul-2020.txt", rawpath1 = "ebd_colpra_relJul-2020.txt", 
             rawpathPhoto2 = "ORPR.jpg", rawpathPhoto1 = "COPR.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col2 = "#5e488a", col1 = "#449966",
             minlong = -67,minlat = -50,maxlong = 180, maxlat = 60, pointsize = 2.5, 
             dataall = data, migstatus2 = "LM",migstatus1= "S" , credit2 = "JJ Harrison", credit1 = "Zeynel Cebeci",
             impos = "BL", grpos = "L")

migrationmap(ggp = ggp, Species1 = "Oriental Turtle-Dove",
             rawpath1 = "ebd_ortdov_relJul-2020.txt", rawpathPhoto = "OTDO.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a", 
             minlong = 30 ,minlat = 0,maxlong = 180, maxlat = 65,
             pointsize = 2.5, dataall = data, migstatus = "LM",
             credit = "Koshy Koshy",credit_color = "white" , impos = "L", grpos = "L")

migrationmap(ggp = ggp, Species1 = "Black Baza",
             rawpath1 = "ebd_blabaz1_relJul-2020.txt", rawpathPhoto = "BLBA.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a", 
             minlong = 45 ,minlat = -10,maxlong = 140, maxlat = 50,
             pointsize = 2.5, dataall = data, migstatus = "LM",
             credit = "Godbolemandar",credit_color = "white" , impos = "L", grpos = "L")

migrationmap(ggp = ggp, Species1 = "Eurasian Hoopoe",
             rawpath1 = "ebd_hoopoe_relJul-2020.txt", rawpathPhoto = "HOOP.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 5, col1 = "#5e488a", 
             minlong = -50,minlat = -35,maxlong = 180,maxlat = 65, impos = "L", grpos = "R",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Nrik kiran")

migrationmapS(ggp = ggp, Species1 = "Wilson's Storm Petral",
             rawpath1 = "ebd_wispet_relMar-2020.txt", rawpathPhoto = "WSPE.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a", 
             minlong = -180,minlat = -70,maxlong = 180, maxlat = 60, impos = "R", grpos = "R",
             pointsize = 1.5, dataall = data, migstatus = "W", credit = "JJ Harrison")

migrationmap(ggp = ggp, Species1 = "Spotted Flycatcher",
             rawpath1 = "ebd_spofly1_relJul-2020.txt", rawpathPhoto = "SPFL.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a",
             minlong = -52,minlat = -35,maxlong = 180, maxlat = 70, impos = "L", grpos = "R",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit= "Charles J Sharp")

migrationmap(ggp = ggp, Species1 = "Rufous-tailed Scrub-Robin",
             rawpath1 = "ebd_rutscr1_relJul-2020.txt", rawpathPhoto = "RTSR.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a",
             minlong = -30,minlat = -35,maxlong = 180, maxlat = 70, impos = "R", grpos = "R",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit= "Gary L. Clark", credit_color = "white")

migrationmap(ggp = ggp, Species1 = "White-eyed Buzzard",
             rawpath1 = "ebd_whebuz1_relJul-2020.txt", rawpathPhoto = "WEBU.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a",
             minlong = 45,minlat = 0,maxlong = 125, maxlat = 45, impos = "L", grpos = "R",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Koshy Koshy")

migrationmap(ggp = ggp, Species1 = "Greater Whitethroat",
             rawpath1 = "ebd_grewhi1_relJul-2020.txt", rawpathPhoto = "GRWH.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a",
             minlong = -52,minlat = -35,maxlong = 180, maxlat = 70, impos = "L", grpos = "R",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit= "Francesco Veronesi", credit_color = "white")

migrationmap(ggp = ggp, Species1 = "Pallas's Fish-Eagle",
             rawpath1 = "ebd_pafeag1_relAug-2020.txt", rawpathPhoto = "PFEA.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a", 
             minlong = 30,minlat = -5,maxlong = 170,maxlat = 60, impos = "L", grpos = "R",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Koshy Koshy")

migrationmapS(ggp = ggp, Species1 = "Red-flanked Bluetail",
             rawpath1 = "ebd_refblu_relOct-2020.txt", rawpathPhoto = "RFBL.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a", 
             minlong = -42,minlat = -32,maxlong = 180,maxlat = 70, impos = "L",grpos = "R",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Alnus")

migrationmapS(ggp = ggp, Species1 = "Northern Wheatear",
                     rawpath1 = "ebd_norwhe_relOct-2020.txt", rawpathPhoto = "NOWH.jpg", yaxis = c(-0.1,1.2),
                     res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a", 
                     minlong = -42,minlat = -32,maxlong = 180,maxlat = 70, impos = "L", grpos = "R",
                     pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Zeynel Cebeci")

migrationmapS(ggp = ggp, Species1 = "Arctic Warbler",
                     rawpath1 = "ebd_arcwar1_relOct-2020.txt", rawpathPhoto = "ARWA.jpg", yaxis = c(-0.1,1.2),
                     res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a", 
                     minlong = -42,minlat = -32,maxlong = 180,maxlat = 70, impos = "L", grpos = "R",
                     pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Alnus")

migrationmapS(ggp = ggp, Species1 = "Willow Warbler",
              rawpath1 = "ebd_wlwwar_relOct-2020.txt", rawpathPhoto = "WIWA.jpg", yaxis = c(-0.1,1.2),
              res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a", 
              minlong = -42,minlat = -32,maxlong = 180,maxlat = 70, impos = "L", grpos = "R",
              pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Jakub Halun")

migrationmap(ggp = ggp, Species1 = "Black-capped Kingfisher",
             rawpath1 = "ebd_blckin1_relDec-2020.txt", rawpathPhoto = "BCKI.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a",
             minlong = 40,minlat = -20,maxlong = 160, maxlat = 50, impos = "L", grpos = "L",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Soumyajit Nandy", credit_color = "white")

migrationmap(ggp = ggp, Species1 = "Ruddy Kingfisher",
             rawpath1 = "ebd_rudkin1_relDec-2020.txt", rawpathPhoto = "RUKI.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a",
             minlong = 40,minlat = -20,maxlong = 160, maxlat = 50, impos = "L", grpos = "L",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Dipu ME-12")

########################### high res runs

migrationmap(ggp = ggp, Species1 = "Common Cuckoo", SciName = "Cuculus canorus",
             rawpath1 = "ebd_comcuc_relMar-2020.txt", rawpathPhoto = "COCU.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#ffbd1c", 
             minlong = -42,minlat = -32,maxlong = 180,maxlat = 70, impos = "L", grpos = "R",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Mike McKenzie")

migrationmap(ggp = ggp, Species1 = "Amur Falcon", SciName = "Falco amurensis",
             rawpath1 = "ebd_amufal1_relMar-2020.txt", rawpathPhoto = "AMFA.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#ffbd1c", 
             minlong = -30,minlat = -35,maxlong = 180,maxlat = 65, impos = "L", grpos = "R",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Ian White")

migrationmap(ggp = ggp, Species1 = "Rosy Starling", SciName = "Pastor roseus",
             rawpath1 = "ebd_rossta2_relMar-2020.txt", rawpathPhoto = "ROST.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#ffbd1c", 
             minlong = -25,minlat = -25,maxlong = 180, maxlat = 70, impos = "R",grpos = "L",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Imran Shah")

migrationmap(ggp = ggp, Species1 = "Isabelline Shrike", SciName = "Lanius isabellinus",
             rawpath1 = "ebd_isashr1_relMar-2020.txt", rawpathPhoto = "ISSH.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#ffbd1c", 
             minlong = -42,minlat = -32,maxlong = 180,maxlat = 70, impos = "L", grpos = "R",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Pkspks")

migrationmap(ggp = ggp, Species1 = "Brown Shrike", SciName = "Lanius Cristatus",
             rawpath1 = "ebd_brnshr_relMar-2020.txt", rawpathPhoto = "BRSH.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#ffbd1c", 
             minlong = -42,minlat = -32,maxlong = 180,maxlat = 70, impos = "L", grpos = "L",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Rison Thumboor")

migrationmap(ggp = ggp, Species1 = "Oriental Pratincole", SciName = "Glareola maldivarum",
             rawpath1 = "ebd_oripra_relMar-2020.txt", rawpathPhoto = "ORPR.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#ffbd1c", 
             minlong = 0,minlat = -50,maxlong = 180, maxlat = 55,
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "JJ Harrison", impos = "L", grpos = "L")

migrationmap(ggp = ggp, Species1 = "White-throated Needletail", SciName = "Hirundapus caudacutus",
             rawpath1 = "ebd_whtnee_relFeb-2020.txt", rawpathPhoto = "WTNE.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#ffbd1c", 
             minlong = 0,minlat = -50,maxlong = 180, maxlat = 55,
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Chris Bromley", impos = "L", grpos = "L")

migrationmap(ggp = ggp, Species1 = "Greenish Warbler", SciName = "Pgylloscopus trochiloides",
             rawpath1 = "ebd_grewar3_relMar-2020.txt", rawpathPhoto = "GHWA.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#ffbd1c", 
             minlong = -10,minlat = 0,maxlong = 180,maxlat = 70, impos = "R", grpos = "L",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Dibyendu Ash")

migrationmap(ggp = ggp, Species1 = "Green Warbler", SciName = "Phylloscopus nitidus",
             rawpath1 = "ebd_grnwar1_relMar-2020.txt", rawpathPhoto = "GRWA.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#ffbd1c", 
             minlong = -10,minlat = 0,maxlong = 180,maxlat = 70, impos = "R", grpos = "L",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Mike Pennington")

migrationmap(ggp = ggp, Species1 = "Blyth's Reed Warbler", SciName = "Acrocephalus dumetorum",
             rawpath1 = "ebd_blrwar1_relMar-2020.txt", rawpathPhoto = "BRWA.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#ffbd1c", 
             minlong = -15,minlat = 5,maxlong = 180,maxlat = 70, impos = "R", grpos = "L",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Imran Shah")

migrationmap(ggp = ggp, Species1 = "Bar-headed Goose", SciName = "Anser indicus",
             rawpath1 = "ebd_bahgoo_relMar-2020.txt", rawpathPhoto = "BHGO.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 100,fps = 10, col1 = "#5e488a", 
             minlong = -15,minlat = 5,maxlong = 180,maxlat = 70, impos = "R", grpos = "L",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Mprasannak")

migrationmap(ggp = ggp, Species1 = "Red-headed Bunting", SciName = "Emberiza bruniceps",
             rawpath1 = "ebd_rehbun1_relMar-2020.txt", rawpathPhoto = "RHBU.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#ffbd1c", 
             minlong = -10,minlat = 5,maxlong = 170,maxlat = 70, impos = "R", grpos = "L",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Charles J. Sharp")

migrationmap(ggp = ggp, Species1 = "Yellow-browed Warbler", SciName = "Phylloscopus inornatus",
             rawpath1 = "ebd_yebwar3_relMar-2020.txt", rawpathPhoto = "YBWA.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#ffbd1c", 
             minlong = -60,minlat = -27,maxlong = 180,maxlat = 70, impos = "L", grpos = "R",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Frank Vassen")

migrationmap(ggp = ggp, Species1 = "Indian Pitta", SciName = "Pitta brachyura",
             rawpath1 = "ebd_indpit1_relMar-2020.txt", rawpathPhoto = "INPI.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#ffbd1c",
             minlong = 55,minlat = 5,maxlong = 105, maxlat = 40, impos = "R", grpos = "L",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Shantanu Kuvasekar")

migrationmap(ggp = ggp, Species1 = "Cattle Egret", SciName = "Bubuculus ibis",
             rawpath1 = "ebd_categr_relMar-2020.txt", rawpathPhoto = "CAEG.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#ffbd1c",
             minlong = -180,minlat = -70,maxlong = 180, maxlat = 70, impos = "R", grpos = "L",
             pointsize = 1.5, dataall = data, migstatus = "LM", credit = "Andy Reago & Chrissy McClarren" )

migrationmap(ggp = ggp, Species1 = "Cattle Egret", SciName = "Bubuculus ibis",
             rawpath1 = "ebd_categr_relMar-2020.txt", rawpathPhoto = "CAEG.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#ffbd1c",
             minlong = 35,minlat = -15, maxlong = 150, maxlat = 55, impos = "L", grpos = "L",
             pointsize = 1.5, dataall = data, migstatus = "LM", credit = "Andy Reago & Chrissy McClarren")

migrationmap(ggp = ggp, Species1 = "Black Kite", SciName = "Milvius migrans",
             rawpath1 = "ebd_blakit1_relApr-2021.txt", rawpathPhoto = "BLKI.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#ffbd1c",
             minlong = -50,minlat = -45,maxlong = 180, maxlat = 70, impos = "L", grpos = "L",
             pointsize = 1.5, dataall = data, migstatus = "LM", credit = "JJ Harrison")

migrationmap(ggp = ggp, Species1 = "Common Crane", SciName = "Grus grus",
             rawpath1 = "ebd_comcra_relApr-2020.txt", rawpathPhoto = "COCR.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#ffbd1c",
             minlong = -15,minlat = -5,maxlong = 180, maxlat = 75, impos = "R", grpos = "L",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Marie-Lan Taÿ Pamart") 

migrationmap(ggp = ggp, Species1 = "Demoiselle Crane", SciName = "Grus virgo",
             rawpath1 = "ebd_demcra1_relApr-2020.txt", rawpathPhoto = "DECR.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#ffbd1c",
             minlong = -5,minlat = -5,maxlong = 180, maxlat = 70, impos = "R", grpos = "L",
             pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Sumeet Moghe")
