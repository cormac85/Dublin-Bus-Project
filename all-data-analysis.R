#Function: To import all .csv data from the RTPI premade database for the
#purpose of analysis and creating a suitable metric for comparison.
#Author: Cormac Nolan
#Date: 03/03/2015

#load packages here and some housekeeping
library(dplyr)
library(RMySQL)

rm(list=ls())
setwd("C:/Users/King Mac/Google Drive/Coding/DIT/5. Project/siri.20130131.csv")

#FUNCTIONS GO HERE!
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

#+++++++++++++++++++++++++++START SCRIPT+++++++++++++++++++++++++++++++++#

#STEP 1: Import required data into a set of dataframes.

#create list of file names
csvFiles = list.files(pattern="*.csv")



