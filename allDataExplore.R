# The purpose of this script is to experiment with random access of an entire
# MySQL DB that contains all the Insight Dublin BUS RTPI data.  Exploration
# and experimentation of timeseries analysis methods shall be conducted.

rm(list=ls())

library(dplyr)
library(vioplot)
library(RMySQL)
setwd("C:/Users/King Mac/Google Drive/Coding/DIT/5. Project/Dublin-Bus-Project")

#converts the timestamp into a date time POSIXct object
dtConvert <- function(timestamp){
  return(as.POSIXct(timestamp/1000000, origin="1970-01-01"))
}

#converts two latitude and longitude co-ordinates into a distance in km.
coordConvert <- function(lat1, long1, lat2, long2){
  mypi = 3.14159265358979323846
  radius = 6378.137
  deg2rad=mypi/180
  
  lat1 = lat1*deg2rad
  lat2 = lat2*deg2rad
  long1 = long1*deg2rad
  long2 = long2*deg2rad
  
  distance=acos(sin(lat1)*sin(lat2)+cos(lat1)*cos(lat2)*cos(long2-long1))*radius
  return(distance*1000)
}

cleanIt <- function(raw){
  raw[raw=="null"]=NA#replace data "nulls" with NA's
  raw$StopID[raw$StopID==0]=NA #replace StopID 0's with NA's.
  return(raw) 
}

#+++++++++++++++++++++++++++START SCRIPT+++++++++++++++++++++++++++++++++#

mydb = dbConnect(MySQL(), user='root', password='qwort', host='localhost',dbname="dublinbus")


dbGetQuery(mydb,"SELECT COUNT(*) FROM table6;")
temp <- dbGetQuery(mydb,"SELECT Delay FROM table2;")
vioplot(temp$Delay)

allDelays <- data.frame(row.names=c("Delay"))

#Let's have a look at delays
for(i in 1:31){
  query <- paste('SELECT Delay FROM table',i,';',sep="")
  temp <- dbGetQuery(mydb,query)
  allDelays <- rbind(allDelays, temp)
}

rm(temp)

vioplot(allDelays$Delay)
title("Violinplot of All Delays for All Buses over 31 Days")

rm(allDelays)
