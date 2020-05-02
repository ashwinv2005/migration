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
    dplyr::select(imp) %>%
    mutate(OBSERVATION.DATE = as.Date(OBSERVATION.DATE), 
           month = month(OBSERVATION.DATE), year = year(OBSERVATION.DATE),
           day = day(OBSERVATION.DATE) + cdays[month], week = week(OBSERVATION.DATE),
           fort = ceiling(day/14)) %>%
    ungroup
  
  return(data)
}

##########################################################################################


cleanmodifydata = function(datapath,sensitivedatapath)
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
  
  # read sensitive species data
  nms = nms[-47]
  sesp = read.csv(sensitivedatapath, colClasses = nms, stringsAsFactors = F)
  stdformat = data.frame(date = as.character(sesp$OBSERVATION.DATE))
  stdformat = stdformat %>%
    separate(date, c("month","day","year"), "/")
  stdformat$year = as.numeric(stdformat$year)
  sesp$OBSERVATION.DATE = paste(stdformat$year,"-",stdformat$month,"-",stdformat$day, sep = "")
  sesp = sesp %>% mutate(GROUP.IDENTIFIER = ifelse(GROUP.IDENTIFIER == "", NA, GROUP.IDENTIFIER))
  
  # merge both data frames
  data = rbind(data,sesp)
  
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
    dplyr::select(imp) %>%
    mutate(OBSERVATION.DATE = as.Date(OBSERVATION.DATE), 
           month = month(OBSERVATION.DATE),
           day = day(OBSERVATION.DATE) + cdays[month],
           year = year(OBSERVATION.DATE)) %>%
    dplyr::select(-c("OBSERVATION.DATE")) %>%
    ungroup
  
  bb = matrix(nrow=2,ncol=2)
  bb[1,1] = 68.186523
  bb[1,2] = 97.41528
  bb[2,1] = 6.756104
  bb[2,2] = 37.07831
  
  cs = c(100*1000/111111,100*1000/111111) 
  cc = bb[, 1] + (cs/2)  # cell offset
  cd = ceiling(diff(t(bb))/cs)  # number of cells per direction
  grd = GridTopology(cellcentre.offset=cc, cellsize=cs, cells.dim=cd)
  sp_grd = SpatialGridDataFrame(grd, data=data.frame(id=1:prod(cd)))
  sp_grd_poly = as(sp_grd, "SpatialPolygonsDataFrame")
  
  temp = data %>% group_by(group.id) %>% slice(1)
  
  rownames(temp) = temp$group.id
  coordinates(temp) = ~LONGITUDE + LATITUDE
  temp = over(temp,sp_grd_poly)
  temp = data.frame(temp)
  temp$group.id = rownames(temp)
  data = left_join(temp,data)
  names(data)[1] = "gridg3"
  
  save(data,file = "dataforfreq.RData")
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
  
  PROJ = "+proj=robin +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs" 
  # or use the short form "+proj=robin"
  NE_countries_rob  = spTransform(NE_countries, CRSobj = PROJ)
  NE_graticules_rob = spTransform(NE_graticules, CRSobj = PROJ)
  NE_box_rob        = spTransform(NE_box, CRSobj = PROJ)
  
  # project long-lat coordinates for graticule label data frames 
  # (two extra columns with projected XY are created)
  prj.coord = project(cbind(lbl.Y$lon, lbl.Y$lat), proj=PROJ)
  lbl.Y.prj = cbind(prj.coord, lbl.Y)
  names(lbl.Y.prj)[1:2] = c("X.prj","Y.prj")
  
  prj.coord = project(cbind(lbl.X$lon, lbl.X$lat), proj=PROJ)
  lbl.X.prj = cbind(prj.coord, lbl.X)
  names(lbl.X.prj)[1:2] = c("X.prj","Y.prj")
  
  # __________ Plot layers
  ggp = ggplot() +
    # add Natural Earth box projected to Robinson
    geom_polygon(data=NE_box_rob, aes(x=long, y=lat), colour="black", fill="#002fb3", size = 0.25) +
    # add Natural Earth countries projected to Robinson, give black border and fill with gray
    geom_polygon(data=NE_countries_rob, aes(long,lat, group=group), colour="black", fill="#038056", size = 0.25) +
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
    theme_void()
  
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
create_freq<-function(Species,data)
  {
  data$month = as.factor(data$month)
  
  temp = data %>%
    filter(COMMON.NAME == Species) %>%
    distinct(gridg3,month)
  data = temp %>% left_join(data)
  
  freq<-matrix(ncol=3, nrow=365)
  freq[,1]<-c(1:365)
  
  out<-for (i in freq[,1]){
    dat1<-data%>%subset(day == i)  
    freq[i,2]<-length(which(dat1$COMMON.NAME == Species))
    freq[i,3]<-n_distinct(dat1$group.id)
  }
  freq<-as.data.frame(freq)
  colnames(freq)<-c("day","detected","checklists")
  return(freq)
  }

#### Updated migration map function
#### For image with side panel: Species1 = "India Name of Species", SciName = "Scientific Name" 
#### rawpathPhoto = "file path of jpeg of bird", yaxis = ylim of inset graph, pointsize = size of the point

#### Removed: see line 109, I have replaced the lapply with a for loop, found it easier to code in both the map     stuff and the graph

#### Code is for single species at the moment

migrationmap = function(n=1, Species1,SciName, rawpath1, rawpath2=NA, rawpathPhoto,  res = 120, range = 30,
                        step = 10, fps = 2, col1 = "red", col2 = "blue", pointsize, yaxis, ybreaks,
                        world = F, minlong = -15, 
                        minlat = -33, maxlong = 180, maxlat = 70,ggp,dataall)
{
  require(tidyverse)
  require(rgdal)
  require(magick)
  require(gridExtra)
  require(grid)
  require(ggpubr)
  require(extrafont)
  
  freq = create_freq(Species = Species1, data = dataall)
  
  if (n==1)
  {
    data = readcleanrawdata(rawpath = rawpath1)
  }
  
  if (n!=1)
  {
    data1 = readcleanrawdata(rawpath = rawpath1)
    data2 = readcleanrawdata(rawpath = rawpath2)
    data = rbind(data1,data2)
    data1 = data1 %>% select(COMMON.NAME)
    data2 = data2 %>% select(COMMON.NAME)
  }
  
  PROJ = "+proj=robin +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs" 
  #PROJ = "+proj=eck4 +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs" 
  
  projdat = project(cbind(data$LONGITUDE,data$LATITUDE), proj = PROJ)
  data = cbind(projdat, data)
  names(data)[1:2] = c("long","lat")
  
  data = data %>% select(long,lat,COMMON.NAME,day)
  
  
  min = project(cbind(minlong,minlat), proj = PROJ)
  max = project(cbind(maxlong,maxlat), proj = PROJ)
  
  ##############
  
  if (n==1)
  {
    species = data$COMMON.NAME[1]
    cols = col1
    specs = species
  }
  
  if (n==2)
  {
    spec1 = data1$COMMON.NAME[1]
    spec2 = data2$COMMON.NAME[1]
    specs = c(spec1,spec2)
    species = paste(specs[1],"(blue)","    ",specs[2],"(red)")
    if (sort(specs)[1] == specs[1])
    {
      cols = c(col2,col1)
    }
    if (sort(specs)[1] != specs[1])
    {
      cols = c(col1,col2)
    }
  }
  
  mon = c(rep("January",31),rep("February",28),rep("March",31),rep("April",30),rep("May",31),rep("June",30),
          rep("July",31),rep("August",31),rep("September",30),rep("October",31),rep("November",30),
          rep("December",31))
  
  mdays = c(15.5,45.0,74.5,105.0,135.5,166.0,196.5,227.5,258.0,288.5,319.0,349.5)
  mlabs = c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")
  
  img = image_graph(width = 1080, height = 810, res = res)
  #datalist = split(data, data$fort)
  
  l = list()
  nums = c(1:365,1:(range-1))
  x = c(seq(101,365,step),seq(1,100,step))
  
  ct = 0
  for (i in x)
  {
    ct = ct + 1
    l[[ct]] = nums[i:(i+range-1)]
    if(max(l[[ct]]) == 365 & min(l[[ct]]) == 1)
      l[[ct]][l[[ct]]<=365 & l[[ct]]>(365-range)] = l[[ct]][l[[ct]]<=365 & l[[ct]]>(365-range)] - 365
  }
  
  avg<-matrix(ncol = 2,nrow = 0)
  for (i in l){
    
    v1 = i
    if(min(v1) <= 0)
    {
      v1[v1<=0] = v1[v1<=0]+365
    }
    
    temp = data %>%
      filter(day %in% v1) %>%
      distinct(long,lat,COMMON.NAME)
    
    temp1 = freq %>%
      filter(day %in% v1) 
    
    med = floor(median(i))
    if (med == 0)
      med = 365
    if (med < 0)
      med = med + 365
    
    #cols = "#c26023"
    
    if (isTRUE(world))
    {
      p = ggp +
        if(switchs)geom_point(data = temp, aes(x = long,y = lat, col = COMMON.NAME, alpha = 0.8, stroke = 0), size = 1.5) +
        ggtitle(mon[med], size = 1) +
        theme(plot.title = element_text(hjust = 0.01, size = 10)) +
        scale_color_manual(breaks = sort(specs), values = cols) +
        theme(legend.position = "none")
    }
    else
    {
      p = ggp +
        geom_point(data = temp, aes(x = long,y = lat, col = COMMON.NAME, alpha = 0.8, stroke = 0), size = pointsize) +
        coord_cartesian(xlim = c(min[1],max[1]), ylim = c(min[2],max[2])) +
        theme(plot.title = element_text(hjust = 0.01, size = 10)) +
        scale_color_manual(breaks = sort(specs), values = cols) +
        ggtitle(mon[med]) +
        theme(legend.position = "none")+
        theme(panel.background = element_rect(fill = "white"),
          plot.margin = margin(2, 2, 2, 2, "mm"),
          plot.background = element_rect(
            fill = "grey90",
            colour = "black",
            size = 2))
      p1 = ggdraw(p) + draw_label(species, 0.5, 0.975, size = 10)+theme(text=element_text(family="Gill Sans", size=10))
    }
    
    xt = v1[floor(range/2)]
    ggg<-c(((sum(temp1$detected)/sum(temp1$checklists))*100),xt)
    avg<-rbind(avg,ggg, deparse.level = 0)
    colnames(avg)<-c("frequency","day")
    avg<-as.data.frame(avg)
    #print(avg)


    qi<-ggplot(avg,aes(y = frequency,x =  day)) + geom_point(size = 1.5)+
      #geom_line()+
      scale_x_continuous(limits = c(1,365), breaks= mdays, labels=mlabs)+
      scale_y_continuous(limits = yaxis, breaks= ybreaks)+
      xlab("months")+ ylab("frequency in India (%)")+
      theme(text=element_text(family="Gill Sans"))+
      theme(axis.title.x = element_blank(), axis.text.x = element_text(size = 6),
            axis.ticks.x = element_blank(),axis.ticks.y = element_blank(),
            axis.title.y = element_text(angle = 90, size = 8), 
            axis.text.y = element_text(size = 6)) +
      theme(panel.background = element_rect(fill = "white"),
                                               plot.margin = margin(1, 1, 1, 1, "mm"),
                                               plot.background = element_rect(
                                                 fill = "white",
                                                 colour = "black",
                                                 size = 1))
    
      
    a<-image_read(rawpathPhoto)
    
    vv<-ggdraw(p1) + draw_image(a, x = 1.01, y = 0.905, hjust = 1, vjust = 0.9, width = 0.25, height = 0.25)
    
    ## include in the function component, probably
    vp = viewport(width = 0.4, height = 0.3, x = 0.42,
                  y = unit(9.1, "lines"), just = c("right","top"))
    
    full = function() {
      print(vv)
      print(qi, vp = vp)
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
  
  if (n == 1)
  {
    nm = specs
    nm = paste(nm,"_",minlong,"_",minlat,"_",maxlong,"_",maxlat,".gif",sep = "")
  }
  
  if (n != 1)
  {
    nm1 = specs1
    nm2 = specs2
    nm = paste(nm1,"_",nm2,"_",minlong,"_",minlat,"_",maxlong,"_",maxlat,".gif",sep = "")
  }
  
  
  animation = image_animate(img, fps = fps)
  image_write(animation, nm)
  
  #ggsave("map_draft_2.png", width=24, height=14.5, units="cm", dpi=600)
}
