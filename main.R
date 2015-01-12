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
source("R/download_data.R")
#source()

# Specify weblinks to download
#URL
URL_railway <- "http://www.mapcruzin.com/download-shapefile/netherlands-railways-shape.zip"
URL_places <- "http://www.mapcruzin.com/download-shapefile/netherlands-places-shape.zip"

#Download & unzip data
download_data(URL_railway)
download_data(URL_places)

railways <- readOGR('data/railways.shp', 'railways')
places <- readOGR('data/places.shp', 'places')


# Change projection
project_RD <- CRS("+proj=sterea +lat_0=52.15616055555555 +lon_0=5.38763888888889
                +k=0.9999079 +x_0=155000 +y_0=463000 +ellps=bessel +towgs84=565.2369,
                50.0087,465.658,-0.406857330322398,0.350732676542563,-1.8703473836068,
                4.0812 +units=m +no_defs")

railways_RD <- spTransform(railways, project_RD)
places_RD <- spTransform(places, project_RD)

# Extract type "industrial" from railways
industrial <- railways_RD[railways_RD$type == 'industrial',]

# Make a buffer around the railway classified as "industrial"
buffer <- gBuffer(industrial, byid=F, width=1000)

# Intersect to check which "place" falls within the "buffer" of the industrial railways
myintersection <- gIntersection(buffer, places_RD, byid=T)
myintersect <- gIntersects(buffer, places_RD, byid=T)

result_place <- places_RD@data[myintersect]

# Plot & print result
plot(buffer, col='green', main = paste("Buffer intersects with the city of", result_place[2]))
plot(myintersection, col= 'red', add=T, cex = 5)
print(paste("The city that intersects with the buffer is", result_place[2], "with a population of", result_place[4]))

############ end of script ####################