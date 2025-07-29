source('~/GitHub/migration/new_functions.R')
load("dataforfreq.RData")
ggp = worldbasemap()

library(gifski)

migrationmap_bare(ggp = ggp, Species1 = "European Roller",
                 rawpath1 = "ebd_eurrol1_relDec-2023.txt", rawpathPhoto = "AMFA.jpg", 
                 yaxis = c(-0.1,1.2),res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a", 
                 minlong = -20,minlat = -35,maxlong = 160,maxlat = 70, impos = "R", grpos = "R",
                 pointsize = 2.5, dataall = data, migstatus = "P", credit = "Subhadra Devi")

migrationmap_bare(ggp = ggp, Species1 = "Amur Falcon", SciName = "Falco amurensis",
                 rawpath1 = "ebd_amufal1_relDec-2023.txt", rawpathPhoto = "AMFA.jpg", 
                 yaxis = c(-0.1,1.2),res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a", 
                 minlong = -30,minlat = -35,maxlong = 180,maxlat = 65, impos = "L", grpos = "R",
                 pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Ian White")

migrationmap_bare(ggp = ggp, Species1 = "Spotted Flycatcher",
                  rawpath1 = "ebd_spofly1_relJan-2024.txt", rawpathPhoto = "AMFA.jpg", 
                  yaxis = c(-0.1,1.2),res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a", 
                  minlong = -52,minlat = -35,maxlong = 180, maxlat = 70, impos = "L", grpos = "R",
                  pointsize = 2.5, dataall = data, migstatus = "LM", credit= "Charles J Sharp")

migrationmap_bare(ggp = ggp, Species1 = "Blyth's Reed Warbler",
                  rawpath1 = "ebd_blrwar1_relJan-2024.txt", rawpathPhoto = "AMFA.jpg", 
                  yaxis = c(-0.1,1.2),res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a", 
                  minlong = -15,minlat = 5,maxlong = 180,maxlat = 70, impos = "R", grpos = "L",
                  pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Imran Shah")

migrationmap_bare(ggp = ggp, Species1 = "European Bee-eater",
                  rawpath1 = "ebd_eubeat1_relJan-2024.txt", rawpathPhoto = "AMFA.jpg", 
                  yaxis = c(-0.1,1.2),res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a", 
                  minlong = -20,minlat = -35,maxlong = 160,maxlat = 70, impos = "R", grpos = "R",
                  pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Stavros Toumanidis")

migrationmap_bare(ggp = ggp, Species1 = "Indian Pitta",
                  rawpath1 = "ebd_indpit1_relJan-2024.txt", rawpathPhoto = "AMFA.jpg", 
                  yaxis = c(-0.1,1.2),res = 144,range = 30,step = 3,fps = 10, col1 = "#5e488a", 
                  minlong = 55,minlat = 5,maxlong = 105, maxlat = 40, impos = "R", grpos = "L",
                  pointsize = 2.5, dataall = data, migstatus = "LM", credit = "Shantanu Kuvasekar")