setwd("D:/Post_NCBS/NCF/migration")
load("dataforfreq.RData")

require(lubridate)
require(tidyverse)
require(rgdal)
require(sp)
require(sf)
require(rgeos)

####################################################################################

## read and clean raw data and add important columns like group id, seaonality variables
## place raw txt file (India download) in working directory 

readcleanrawdata = function(rawpath)
{
  require(lubridate)
  require(tidyverse)
  require(cowplot)
  
  #library(auk)
  
  #allin = system.file("extdata/ebd_IN_relMay-2018.txt", package = "auk")
  
  #allout = tempfile()
  #auk_clean(allin,allout, sep = "\t", remove_text = FALSE)
  
  #all = allout %>%
  #  read_ebd()
  
  preimp = c("COMMON.NAME","OBSERVATION.COUNT",
             "LOCALITY.ID","LOCALITY.TYPE",
             "LATITUDE","LONGITUDE","OBSERVATION.DATE","TIME.OBSERVATIONS.STARTED","OBSERVER.ID",
             "PROTOCOL.TYPE","DURATION.MINUTES","EFFORT.DISTANCE.KM",
             "NUMBER.OBSERVERS","ALL.SPECIES.REPORTED","GROUP.IDENTIFIER","SAMPLING.EVENT.IDENTIFIER","APPROVED","CATEGORY")
  
  nms = read.delim(rawpath, nrows = 1, sep = "\t", header = T, quote = "", stringsAsFactors = F, na.strings = c(""," ",NA))
  nms = names(nms)
  nms[!(nms %in% preimp)] = "NULL"
  nms[nms %in% preimp] = NA
  
  data = read.delim(rawpath, colClasses = nms, sep = "\t", header = T, quote = "", stringsAsFactors = F, na.strings = c(""," ",NA))
  
  ## choosing important variables
  
  imp = c("COMMON.NAME","OBSERVATION.COUNT",
          "LOCALITY.ID","LOCALITY.TYPE",
          "LATITUDE","LONGITUDE","OBSERVATION.DATE","TIME.OBSERVATIONS.STARTED","OBSERVER.ID",
          "PROTOCOL.TYPE","DURATION.MINUTES","EFFORT.DISTANCE.KM",
          "NUMBER.OBSERVERS","ALL.SPECIES.REPORTED","group.id")
  
  days = c(31,28,31,30,31,30,31,31,30,31,30,31)
  cdays = c(0,31,59,90,120,151,181,212,243,273,304,334)
  
  ## setup eBird data ##
  
  ## filter approved observations, species, slice by single group ID, remove repetitions
  ## remove repeats
  ## set date, add month, year and day columns using package LUBRIDATE
  ## add number of species column (no.sp)
  
  data = data %>%
    filter(APPROVED == 1) %>%
    mutate(group.id = ifelse(is.na(GROUP.IDENTIFIER), SAMPLING.EVENT.IDENTIFIER, GROUP.IDENTIFIER)) %>%
    group_by(group.id) %>% slice(1) %>% ungroup %>%
    dplyr::select(all_of(imp)) %>%
    mutate(OBSERVATION.DATE = as.Date(OBSERVATION.DATE), 
           month = month(OBSERVATION.DATE), year = year(OBSERVATION.DATE),
           day = day(OBSERVATION.DATE) + cdays[month], week = week(OBSERVATION.DATE),
           fort = ceiling(day/14)) %>%
    ungroup
  
  
  return(data)
}

##########################################################################################


cleanmodifydata = function(datapath)
{
  require(lubridate)
  require(tidyverse)
  require(rgdal)
  require(sp)
  require(sf)
  require(rgeos)
  
  # select only necessary columns
  preimp = c("COMMON.NAME","REVIEWED","APPROVED","OBSERVATION.DATE",
             "ALL.SPECIES.REPORTED","GROUP.IDENTIFIER","SAMPLING.EVENT.IDENTIFIER",
             "LONGITUDE","LATITUDE")
  
  nms = read.delim(datapath, nrows = 1, sep = "\t", header = T, quote = "", stringsAsFactors = F, 
                   na.strings = c(""," ",NA))
  nms = names(nms)
  nms[!(nms %in% preimp)] = "NULL"
  nms[nms %in% preimp] = NA
  
  # read data from certain columns only
  data = read.delim(datapath, colClasses = nms, sep = "\t", header = T, quote = "", 
                    stringsAsFactors = F, na.strings = c(""," ",NA))
  
  imp = c("COMMON.NAME","OBSERVATION.DATE","group.id","LONGITUDE","LATITUDE")
  
  
  # no of days in every month, and cumulative number
  days = c(31,28,31,30,31,30,31,31,30,31,30,31)
  cdays = c(0,31,59,90,120,151,181,212,243,273,304,334)
  
  # create a column "group.id" which can help remove duplicate checklists
  data = data %>%
    filter(REVIEWED == 0 | APPROVED == 1) %>%
    mutate(group.id = ifelse(is.na(GROUP.IDENTIFIER), SAMPLING.EVENT.IDENTIFIER, GROUP.IDENTIFIER)) %>%
    filter(ALL.SPECIES.REPORTED == 1) %>%
    group_by(group.id,COMMON.NAME) %>% slice(1) %>% ungroup %>%
    dplyr::select(all_of(imp)) %>%
    mutate(OBSERVATION.DATE = as.Date(OBSERVATION.DATE), 
           year = year(OBSERVATION.DATE)) %>%
    ungroup
  
  data = data %>% dplyr::select(-c("LONGITUDE","LATITUDE"))
  
  save(data,file = "dataforfreq2.RData")
}


# ======================================================================================
# Create a simple world map in Robinson projection with labeled graticules using ggplot
# ======================================================================================

# Set a working directory with setwd() or work with an RStudio project

worldbasemap = function()
{
  # __________ Set libraries
  require(tidyverse)
  require(rgdal)      # for spTransform() & project()
  
  # __________ Load ready to use data from GitHub
  #load(url("https://github.com/valentinitnelav/RandomScripts/blob/master/NaturalEarth.RData?raw=true"))
  # This will load 6 objects:
  #   xbl.X & lbl.Y are two data.frames that contain labels for graticule lines
  #       They can be created with the code at this link: 
  #       https://gist.github.com/valentinitnelav/8992f09b4c7e206d39d00e813d2bddb1
  #   NE_box is a SpatialPolygonsDataFrame object and represents a bounding box for Earth 
  #   NE_countries is a SpatialPolygonsDataFrame object representing countries 
  #   NE_graticules is a SpatialLinesDataFrame object that represents 10 dg latitude lines and 20 dg longitude lines
  #           (for creating graticules check also the graticule package or gridlines fun. from sp package)
  #           (or check this gist: https://gist.github.com/valentinitnelav/a7871128d58097e9d227f7a04e00134f)
  #   NE_places - SpatialPointsDataFrame with city and town points
  #   NOTE: data downloaded from http://www.naturalearthdata.com/
  #         here is a sample script how to download, unzip and read such shapefiles:
  #         https://gist.github.com/valentinitnelav/a415f3fbfd90f72ea06b5411fb16df16
  
  # __________ Project from long-lat (unprojected data) to Robinson projection
  # spTransform() is used for shapefiles and project() in the case of data frames
  # for more PROJ.4 strings check the followings
  #   http://proj4.org/projections/index.html
  #   https://epsg.io/
  
  #load(basepath)
  
  # to WRITE to shapefiles
  
  #dir.create("NE_countries")
  #writeOGR(obj=NE_countries, dsn="NE_countries", layer="NE_countries", driver="ESRI Shapefile")
  
  #dir.create("NE_graticules")
  #writeOGR(obj=NE_graticules, dsn="NE_graticules", layer="NE_graticules", driver="ESRI Shapefile")
  
  #dir.create("NE_box")
  #writeOGR(obj=NE_box, dsn="NE_box", layer="NE_box", driver="ESRI Shapefile")
  
  #dir.create("NE_places")
  #writeOGR(obj=NE_places, dsn="NE_places", layer="NE_places", driver="ESRI Shapefile")
  
  #write.csv(lbl.X,"lbl.X.csv",row.names = F)
  #write.csv(lbl.Y,"lbl.Y.csv",row.names = F)
  
  NE_countries = readOGR("NE_countries")
  NE_graticules = readOGR("NE_graticules")
  NE_box = readOGR("NE_box")
  lbl.X = read.csv("lbl.X.csv")
  lbl.Y = read.csv("lbl.Y.csv")
  
  PROJ = "+proj=longlat +ellps=WGS84"
  
  # or use the short form "+proj=robin"
  NE_countries_rob  = spTransform(NE_countries, CRSobj = PROJ)
  NE_graticules_rob = spTransform(NE_graticules, CRSobj = PROJ)
  NE_box_rob        = spTransform(NE_box, CRSobj = PROJ)
  NE_India = NE_countries[NE_countries@data$geounit == "India",]
  NE_India_rob  = spTransform(NE_India, CRSobj = PROJ)
  
  # project long-lat coordinates for graticule label data frames 
  # (two extra columns with projected XY are created)
  prj.coord = project(cbind(lbl.Y$lon, lbl.Y$lat), proj=PROJ)
  lbl.Y.prj = cbind(prj.coord, lbl.Y)
  names(lbl.Y.prj)[1:2] = c("X.prj","Y.prj")
  
  prj.coord = project(cbind(lbl.X$lon, lbl.X$lat), proj=PROJ)
  lbl.X.prj = cbind(prj.coord, lbl.X)
  names(lbl.X.prj)[1:2] = c("X.prj","Y.prj")
  
  #038056 #old green
  #04af76 #old India
  #002fb3 #old ocean
  #ffbd1c #old point colour
  #004d00 #new world
  #008000 #new india
  #142952 #new ocean
  
  
  # __________ Plot layers
  ggp = ggplot() +
    # add Natural Earth box projected to Robinson
    #geom_polygon(data=NE_box_rob, aes(x=long, y=lat), colour=NA, fill="#142952", size = 0.25) +
    # add Natural Earth countries projected to Robinson, give black border and fill with gray
    geom_polygon(data=NE_countries_rob, aes(long,lat, group=group), colour="#7b7b7b", fill="#e5d8ca", size = 0.25) +
    geom_polygon(data=NE_India_rob, aes(long,lat, group=group), colour="#7b7b7b", fill="#ffffff", size = 0.25) +
    # Note: "Regions defined for each Polygons" warning has to do with fortify transformation. Might get deprecated in future!
    # alternatively, use use map_data(NE_countries) to transform to data frame and then use project() to change to desired projection.
    # add graticules projected to Robinson
    #geom_path(data=NE_graticules_rob, aes(long, lat, group=group), linetype="dotted", color="grey50", size = 0.25) +
    # add graticule labels - latitude and longitude
    #geom_text(data = lbl.Y.prj, aes(x = X.prj, y = Y.prj, label = lbl), color="grey50", size=2) +
    #geom_text(data = lbl.X.prj, aes(x = X.prj, y = Y.prj, label = lbl), color="grey50", size=2) +
    # the default, ratio = 1 in coord_fixed ensures that one unit on the x-axis is the same length as one unit on the y-axis
    coord_fixed(ratio = 1) +
    # remove the background and default gridlines
    theme(axis.line=element_blank(),
          axis.text.x=element_blank(),
          axis.text.y=element_blank(),
          axis.ticks=element_blank(),
          axis.title.x=element_blank(),
          axis.title.y=element_blank(),
          plot.margin=unit(c(0,0,-0.09,-0.1), "cm"),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.border = element_blank(),
          plot.background = element_rect(fill = NA, colour = NA),
          panel.background = element_rect(fill = "#a9d5e0", colour = NA))
  
  
  return(ggp)
}

# REFERENCES:
# This link was useful for graticule idea
#   http://stackoverflow.com/questions/38532070/how-to-add-lines-of-longitude-and-latitude-on-a-map-using-ggplot2
# Working with shapefiles, projections and world maps in ggplot

#Raw india data, clean and read. Dataframe is called dat
#load("D:/Post_NCBS/NCF/migration/ebd_IN_relMar-2020/filtered_ebd.RData")

## Use to create a reporting frequency of individual species for each day in the year
## Input species name, eg Tytler's Leaf Warbler

##data$year_cat<-cut(data$year, c(1900,2000,2006,2010,2012,2013,2014,2015,2016,2017,2018,2019,2020), labels = c("Pre 2000", "2000-2006","2007-2010","2011-2012","2013","2014","2015","2016","2017","2018","2019","2020"))

data$year_cat<-cut(data$year, c(1900,2005,2015,2020), labels = c("Pre 2005", "2005-2015","2015-2020"))

ggp<-worldbasemap()

create_freq<-function(Species,data)
{
    temp = data %>%
      filter(COMMON.NAME == Species) %>%
      distinct(gridg3)
    data = temp %>% left_join(data)
    
    freq<-matrix(ncol=4, nrow = 3)
    freq[,2]<-levels(data$year_cat)
    freq[,1]<-c(1:3)
    both<-list(freq[,1], freq[,2])
    both[[1]]<-as.numeric(both[[1]])
    
    out<-for (i in as.numeric(freq[,1])){
      dat1<-data%>%subset(year_cat == both[[2]][i])  
      freq[both[[1]][i],3]<-length(which(dat1$COMMON.NAME == Species))
      freq[both[[1]][i],4]<-n_distinct(dat1$group.id)
  }
    freq<-as.data.frame(freq)
    colnames(freq)<-c("Sr.no","year_cat","detected","checklists")
  
  return(freq)
}

#### Updated migration map function
#### For image with side panel: Species1 = "India Name of Species", SciName = "Scientific Name" 
#### rawpathPhoto = "file path of jpeg of bird", yaxis = ylim of inset graph, pointsize = size of the point

#### Removed: see line 109, I have replaced the lapply with a for loop, found it easier to code in both the map     stuff and the graph

#### Code is for single species at the moment

migrationmap = function(Species1,SciName, rawpath1, rawpathPhoto,  res = 120, range = 30,
                        step = 10, fps = 2, col1 = "red", pointsize, yaxis,
                        world = F, minlong = -15, 
                        minlat = -33, maxlong = 180, maxlat = 70,ggp,dataall,credit,impos,grpos,
                        credit_color = "black")
{
  require(tidyverse)
  require(rgdal)
  require(magick)
  require(gridExtra)
  require(grid)
  require(ggpubr)
  require(extrafont)
  require(ggformula)
  require(zoo)
  require(gifski)
  
  freq1 = create_freq(Species = Species1, data = dataall)
  
  freq1$perc = with(freq1,as.numeric(as.character(detected))/as.numeric(as.character(checklists)))*100
  
  mx = max(freq1$perc)
  yaxis = c(0,(mx+0.02))
  ybreaks = seq(0,yaxis[2],1)
  

  data = readcleanrawdata(rawpath = rawpath1)
  ##data$year_cat<-cut(data$year, c(1900,2000,2006,2010,2012,2013,2014,2015,2016,2017,2018,2019,2020), labels = c("Pre 2000", ## "2000-2006","2007-2010","2011-2012","2013","2014","2015","2016","2017","2018","2019","2020"))
  
  data$year_cat<-cut(data$year, c(1900,2005,2015,2020), labels =  c("Pre 2005", "2005-2015","2015-2020"))
  
  bb = matrix(nrow=2,ncol=2)
  bb[1,1] = 68.186523
  bb[1,2] = 97.41528
  bb[2,1] = 6.756104
  bb[2,2] = 37.07831
  
  cs = c(150*1000/111111,150*1000/111111) 
  cc = bb[, 1] + (cs/2)  # cell offset
  cd = ceiling(diff(t(bb))/cs)  # number of cells per direction
  grd = GridTopology(cellcentre.offset=cc, cellsize=cs, cells.dim=cd)
  sp_grd= SpatialGridDataFrame(grd, data=data.frame(id=1:prod(cd)))
  sp_grd_poly = as(sp_grd, "SpatialPolygonsDataFrame")
  v<-fortify(sp_grd_poly,region = c("id"))
  
  temp = data %>% group_by(group.id) %>% slice(1)
  
  rownames(temp) = temp$group.id
  coordinates(temp) = ~LONGITUDE + LATITUDE
  temp = over(temp,sp_grd_poly)
  temp = data.frame(temp)
  temp$group.id = rownames(temp)
  data = left_join(temp,data)
  names(data)[1] = "gridg3"

  PROJ = "+proj=robin +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs" 
  #PROJ = "+proj=eck4 +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"
  
  #projdat2 = project(cbind(data$LONGITUDE,data$LATITUDE), proj = PROJ)
  #data = cbind(projdat2, data)
  #names(data)[1:2] = c("long","lat")
  
  min = project(cbind(minlong,minlat), proj = PROJ)
  max = project(cbind(maxlong,maxlat), proj = PROJ)
  
  windowsFonts("Gill Sans" = windowsFont("Gill Sans"))
  
  ##############
  
    species = data$COMMON.NAME[1]
    cols = col1
    specs = species
    wd = strwidth(species,family = "Gill Sans",units = 'figure')
    wd = wd + 0.04
  
  img = image_graph(width = 1080, height = 810, res = res)
  #datalist = split(data, data$fort)
  
  
  a = image_read(rawpathPhoto)
  a = image_scale(a, "300")
  a = image_border(a, "#ffffff", "3x3")
  a = image_annotate(a, credit, font = 'Gill Sans', size = 24, location = "+8+4", color = credit_color)
  
  b = image_read("birdcountindia logo.png")
  b = image_scale(b, "300")
  b = image_background(b, "#ffffff", flatten = TRUE)
  #b = image_border(b, "black", "3x3")
  
  c = image_read("eBird India logo.png")
  c = image_scale(c, "300")
  c = image_background(c, "#ffffff", flatten = TRUE)
  #c = image_border(c, "black", "4x4")
  
  avg<-matrix(ncol = 2,nrow = 0)
  #l<-c("Pre 2000", "2000-2006","2007-2010","2011-2012","2013","2014","2015","2016","2017","2018","2019","2020")
  l<- c("Pre 2005", "2005-2015","2015-2020")
  l<-as.factor(l)
  for (i in l){
    
    temp = data %>%
      filter(year_cat %in% i)
    
    ts<-as.numeric(temp$gridg3)
    v2<-v%>%
      filter(id %in% ts)
    
    projdat = project(cbind(v2$long,v2$lat), proj = PROJ)
    v2 = cbind(projdat, v2)
    names(v2)[1:2] = c("long1","lat1")
    
    temp1 = freq1 %>%
      filter(year_cat %in% i) 
    
    p = ggp +
      geom_polygon(data = v2, aes(x = long, y = lat, group = group), 
                   col = "black", fill = col1, alpha = 1) +
     # coord_cartesian(xlim = c(min[1],max[1]), ylim = c(min[2],max[2]))
      coord_cartesian(xlim = c(55,105), ylim = c(5,40))
    #theme(plot.title = element_text(hjust = 0.01, size = 10)) +
    #ggtitle(mon[med]) + minlong = 55,minlat = 5,maxlong = 105, maxlat = 40
    #theme(legend.position = "none")
    
   # p = ggp +
  #    geom_point(data = temp, aes(x = LONGITUDE,y = LATITUDE, col = COMMON.NAME, alpha = 0.99, stroke = 0), size = pointsize#)+
      #coord_cartesian(xlim = c(min[1],max[1]), ylim = c(min[2],max[2]))+
 #     coord_cartesian(xlim = c(55,105), ylim = c(5,40))+
  #    theme(legend.position = "none")
  
      p1 = ggdraw(p)
    
    
    qi<-ggplot(freq1,aes(y = perc,x =  year_cat, group = 1)) + 
      stat_summary(fun=sum, geom="line")+
      geom_vline(xintercept = i, size = 0.1)+
      scale_x_discrete(limits = c("Pre 2005", "2005-2015","2015-2020"),expand = c(0.15,0))+
      scale_y_continuous(limits = yaxis, breaks= ybreaks)+
      xlab("Year")+ ggtitle(paste("frequency in India ","(max ",round(mx,1),"%)",sep = ""))+
      theme(text=element_text(family="Gill Sans"))+
      theme(axis.title.x = element_blank(), axis.text.x = element_text(colour = "black",size = 8),
            axis.ticks.x = element_blank(), axis.ticks.y = element_blank(),
            axis.title.y = element_blank(), 
            axis.text.y = element_blank(),
            plot.title = element_text(size = 10, hjust = 0.5)) +
      theme(panel.background = element_rect(fill = "#ffffff"),
            plot.margin = margin(1,1,1,1, "mm"),
            plot.background = element_rect(
              fill = "#ffffff",
              colour = "black",
              size = 0.75),
            axis.line=element_blank(),
            panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            panel.border = element_blank())
    
    qj = ggplot() +
      theme(text=element_text(family="Gill Sans"))+
      theme(panel.background = element_rect(fill = "#ffffff"),
            plot.margin = margin(1, 1, 1, 1, "mm"),
            plot.background = element_rect(
              fill = "#ffffff",
              colour = "#ffffff",
              size = 0.5),
            axis.line=element_blank(),
            panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            panel.border = element_blank())
    
    qj1 = ggdraw(qj) +
      draw_label(species, 0.5, 0.59, size = 13, fontfamily="Gill Sans", fontface = 'bold', colour = col1)
    
    vv<-ggdraw(p1) + {if(impos == "R")draw_image(a, x = 1.017, y = 0.955, hjust = 1, vjust = 0.9, 
                                                 width = 0.25, height = 0.25)} +
      {if(impos == "L")draw_image(a, x = 0.234, y = 0.955, hjust = 1, vjust = 0.9, 
                                  width = 0.25, height = 0.25)} +
      {if(grpos == "R")draw_image(b, x = 0.215, y = 0.0826, hjust = 1, vjust = 0.9, 
                                  width = 0.230, height = 0.07)} +
      {if(grpos == "R")draw_image(c, x = 0.287, y = 0.0826, hjust = 1, vjust = 0.9, 
                                  width = 0.105, height = 0.07)} +
      {if(grpos == "L")draw_image(b, x = 0.923, y = 0.0826, hjust = 1, vjust = 0.9, 
                                  width = 0.230, height = 0.07)} +
      {if(grpos == "L")draw_image(c, x = 0.995, y = 0.0826, hjust = 1, vjust = 0.9, 
                                  width = 0.105, height = 0.07)}
    
    
    
    if (grpos == "L")
    {
      vp = viewport(width = 0.3, height = 0.2, x = 0.316,
                    y = unit(6.22, "lines"), just = c("right","top"))
    }
    
    if (grpos == "R")
    {
      vp = viewport(width = 0.3, height = 0.2, x = 0.685,
                    y = unit(6.22, "lines"), just = c("left","top"))
    }
    
    vq = viewport(width = wd, height = 0.04, x = 0.5,
                  y = 0.99, just = c("center","top"))
    
    
    full = function() {
      print(vv)
      print(qi, vp = vp)
      print(qj1, vp = vq)
    }
    
    full()
    
    #text1<- paste(Species1)
    #text2<-paste(SciName)
    #tgrob1 <- text_grob(text1, family = "Gill Sans", face = "bold", color = "black", vjust = 2, size = 16)
    #tgrob2 <- text_grob(text2, family = "Gill Sans", face = "italic", color = "black", vjust = -1, size = 12)
    #tgrob3 <- text_grob(mon[med], family = "Gill Sans", face = "bold", color = "black", vjust = 2, size = 18 )
    
    #r<-grid.arrange(arrangeGrob(arrangeGrob(tgrob1,tgrob2, ncol=1, nrow=2),qi, tgrob3, nrow = 3, ncol = 1),
    #arrangeGrob(vv, ncol=1, nrow=1), heights=c(100,1), widths=c(1,2))
    #print(r)
  }
  
  dev.off(which = 2)
  

  nm = specs
  nm = paste(nm,"_",minlong,"_",minlat,"_",maxlong,"_",maxlat,".gif",sep = "")
  
  
  
  #animation = image_animate(img, fps = fps)
  image_write_gif(img, nm, delay = 1/fps)
  
  
  #ggsave("map_draft_2.png", width=24, height=14.5, units="cm", dpi=600)
}

migrationmap(ggp = ggp, Species1 = "White-rumped Vulture",
             rawpath1 = "ebd_whrvul1_relApr-2020.txt", rawpathPhoto = "WRVU.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30, fps = 1, col1 = "#5e488a",
             minlong = 55,minlat = 5,maxlong = 105, maxlat = 40, impos = "R", grpos = "L",
             pointsize = 2.5, dataall = data, credit = "Shantanu Kuvasekar")

migrationmap(ggp = ggp, Species1 = "Indian Courser",
             rawpath1 = "ebd_indcou1_relMay-2020.txt", rawpathPhoto = "INCO.jpg", yaxis = c(-0.1,1.2),
             res = 144,range = 30, fps = 1, col1 = "#5e488a",
             minlong = 55,minlat = 5,maxlong = 105, maxlat = 40, impos = "R", grpos = "L",
             pointsize = 2.5, dataall = data, credit = "Manojritty")


############### testing ###########################
x<-readcleanrawdata("ebd_whrvul1_relApr-2020.txt")
x$year_cat<-cut(x$year, c(1900,2000,2006,2010,2012,2013,2014,2015,2016,2017,2018,2019,2020), labels = c("Pre 2000", "2000-2006","2007-2010","2011-2012","2013","2014","2015","2016","2017","2018","2019","2020"))

freq<-create_freq("White-rumped Vulture",data)
freq$perc = with(freq,as.numeric(as.character(detected))/as.numeric(as.character(checklists)))*100
mx = max(freq$perc)
yaxis = c(0,(mx+0.02))
ybreaks = seq(0,yaxis[2],1)
#######################################################
