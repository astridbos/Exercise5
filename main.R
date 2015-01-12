# AD-Scripting, Astrid Bos & David Scholte-Albers
# 09 January 2014
# Exercise 5

# Start with empty environment
rm(list=ls())

# Import packages
library(sp)
library(rgdal)
library(rgeos)


# Check working directory
getwd()

# Call functions
#source()
#source()

# Specify weblinks to download
#URL

#Download & unzip data
#Data
railways <- readOGR('data/railways.shp', 'railways')
industrial <- railways[railways$type == 'industrial',]
str(industrial)
plot(industrial)

# Change projection


### buffer maken rond industrial spoorlijn
plot(industrial, col = 'grey')
plot(gBuffer(industrial, byid=TRUE, width=0.01), add=T, col='red')


#######################
### Script David ######
#######################

# Team AD-Scripting: Astrid Bos & David Scholte-Albers
# Date: 09-01-2014

# Clear environment
rm(list=ls())


# Load libraries
library(sp)
library(rgdal)
library(rgeos)

railways <- readOGR("data/Railways/railways.shp", "railways")
proj4string(railways) <- prj_string_WGS


plot(railwayReproj)

industrial <- railways[railways$type == "industrial", ]

plot(industrial)

transformRD <- CRS("+proj=sterea +lat_0=52.15616055555555 +lon_0=5.38763888888889
                                      +k=0.9999079 +x_0=155000 +y_0=463000 +ellps=bessel +towgs84=565.2369,
                                      50.0087,465.658,-0.406857330322398,0.350732676542563,-1.8703473836068,
                                      4.0812 +units=m +no_defs")

indusRD <- spTransform(industrial, transformRD)
plot(indusRD)

buffer <- gBuffer(industrial, byid=F, width=100)
plot(buffer)

#####################
