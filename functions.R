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
  load(url("https://github.com/valentinitnelav/RandomScripts/blob/master/NaturalEarth.RData?raw=true"))
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
  
  NE_countries = readOGR("NE_countries")
  
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
    # add Natural Earth countries projected to Robinson, give black border and fill with gray
    geom_polygon(data=NE_countries_rob, aes(long,lat, group=group), colour="black", fill="gray80", size = 0.25) +
    # Note: "Regions defined for each Polygons" warning has to do with fortify transformation. Might get deprecated in future!
    # alternatively, use use map_data(NE_countries) to transform to data frame and then use project() to change to desired projection.
    # add Natural Earth box projected to Robinson
    geom_polygon(data=NE_box_rob, aes(x=long, y=lat), colour="black", fill="transparent", size = 0.25) +
    # add graticules projected to Robinson
    geom_path(data=NE_graticules_rob, aes(long, lat, group=group), linetype="dotted", color="grey50", size = 0.25) +
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


###########################################################################


migrationmap = function(n=1, rawpath1, rawpath2=NA, res = 120, range = 30, step = 10, 
                        fps = 2, col1 = "red", col2 = "blue", world = F, minlong = -15, 
                        minlat = -33, maxlong = 180, maxlat = 70,ggp)
{
  require(tidyverse)
  require(rgdal)
  require(magick)
  
  if (n==1)
  {
    data = readcleanrawdata(rawpath = rawpath1)
  }
  
  if (n!=1)
  {
    data1 = readcleanrawdata(rawpath = rawpath1)
    data2 = readcleanrawdata(rawpath = rawpath2)
    data = rbind(data1,data2)
  }
  
  PROJ = "+proj=robin +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs" 
  #PROJ = "+proj=eck4 +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs" 
  
  projdat = project(cbind(data$LONGITUDE,data$LATITUDE), proj = PROJ)
  data = cbind(projdat, data)
  names(data)[1:2] = c("long","lat")
  
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
          rep("December",31),rep("January",range))
  
  img = image_graph(width = 1080, height = 810, res = res)
  #datalist = split(data, data$fort)
  
  l = list()
  nums = c(1:365,1:range)
  x = c(seq(135,365,step),seq(1,135,step))
  
  ct = 0
  for (i in x)
  {
    ct = ct + 1
    l[[ct]] = nums[i:(i+range-1)]
  }
  
  out = lapply(l, function(v){
    
    temp = data %>%
      filter(day %in% v)
    
    if (isTRUE(world))
    {
      p = ggp +
        geom_point(data = temp, aes(x = long,y = lat, col = COMMON.NAME, alpha = 0.8, stroke = 0), size = 1.5) +
        ggtitle(mon[median(v)], size = 1) +
        theme(plot.title = element_text(hjust = 0.01, size = 10)) +
        scale_color_manual(breaks = sort(specs), values = cols) +
        theme(legend.position = "none")
    }
    else
    {
      p = ggp +
        geom_point(data = temp, aes(x = long,y = lat, col = COMMON.NAME, alpha = 0.8, stroke = 0), size = 1.5) +
        coord_cartesian(xlim = c(min[1],max[1]), ylim = c(min[2],max[2])) +
        ggtitle(mon[median(v)]) +
        theme(plot.title = element_text(hjust = 0.01, size = 10)) +
        scale_color_manual(breaks = sort(specs), values = cols) +
        theme(legend.position = "none")
    }
    
    p1 = ggdraw(p) + draw_label(species, 0.5, 0.975, size = 10)
    print(p1)
  })
  dev.off()
  
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
  
  #ggsave("map_draft_1.png", width=28, height=13.5, units="cm", dpi=600)
}
