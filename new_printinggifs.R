##R.Data file

######################
## Run cleanmodifydata() only once with the correct data path and sensitive data path (.txt files) specified
## Subsequently only load dataforfreq.RData (saved by the previous function in the working directory)

source('~/GitHub/migration/new_functions.R')
cleanmodifydata(datapath = "ebd_IN_relApr-2020.txt", sensitivedatapath = "ebd_relApr-2020_sensitive.txt")

load("dataforfreq.RData")
source('~/GitHub/migration/new_functions.R')
ggp = worldbasemap()

#migrationmap(ggp = ggp, rawpath1 = "ebd_tylwar1_relMar-2020.txt",  rawpathPhoto = "D:/Post_NCBS/NCF/migration/tlwa.jpg", res = 144,range = 35,step = 10,fps = 5, col1 = "#c26023", yaxis = c(0,0.2), pointsize = 2, minlong = 60,minlat = 5,maxlong = 100, maxlat = 36,data = data)

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
             res = 144,range = 30,step = 3,fps = 10, col1 = "#ffbd1c", 
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
             rawpath1 = "ebd_blakit1_relMar-2020.txt", rawpathPhoto = "BLKI.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30,step = 3,fps = 10, col1 = "#ffbd1c",
             minlong = -50,minlat = -45,maxlong = 180, maxlat = 70, impos = "L", grpos = "L",
             pointsize = 1.5, dataall = data, migstatus = "LM", credit = "Koshy Koshy")

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
