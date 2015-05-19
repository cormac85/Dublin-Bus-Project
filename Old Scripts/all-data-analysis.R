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

#Initialise DB connection
#Use 1 if this is your first time setting up the databse.
#Use 2 if you're reconnecting to the database

#1.
#mydb = dbConnect(MySQL(), user='root', password='qwort', host='localhost', dbname="dublinbus")

#dbSendQuery(mydb, "CREATE DATABASE DublinBus;")
#dbSendQuery(mydb, "USE DublinBus")

#dbSendQuery(mydb, "drop table if exists Table1")

#2.
mydb = dbConnect(MySQL(), user='root', password='qwort', host='localhost',dbname="dublinbus")

#Read csv data into data frame and name accordingly
raw01 <- read.csv("siri.20130101.csv",header=FALSE)
names = c("Timestamp", "LineID", "Direction", "JourneyPatternID",
          "TimeFrame", "VehicleJourneyID", "Operator", "Congestion",
          "LonWGS84", "LatWGS84", "Delay", "BlockID", "VehicleID", 
          "StopID", "AtStop" )
names(raw01) <- names

raw01$Direction <- NULL #redundant

train01 <-raw01

#Some basic cleanup...
train01$Operator <- NULL #Not interested in bus operator
train01$TimeFrame <- as.character(train01$TimeFrame) #convert from factor to char
#add quotes to date as required by MYSQL
train01$TimeFrame <- paste("'", train01$TimeFrame, "'", sep="")

#Change the factor to a character and then character to int, otherwise as.integer()
#interprets the factor as the undlerlying int from the factor and not
#the "face value" of the factor.
train01$StopID <- as.integer(as.character(train01$StopID))

#
train01$JourneyPatternID <- as.character(train01$JourneyPatternID)
train01$JourneyPatternID <- paste("'", train01$JourneyPatternID, "'", sep="")
train01[train01=="null"]=0#replace data "nulls" with NA's
train01[is.na(train01)]=0

####################################################################################
### Post Cleanup Status: 
### 1. Both JourneyPatternID & StopID had NA's that were been replaced with 0.
### 2. Congestion and AtStop data should be interpreted as boolean 0's and 1's.
### 3. 0's in Delay should be interpreted as numeric 0.
### 4. In general MYSQL cannot interpret factors and so must have either numeric,
###    date or character as inputs.
### 5. Character inputs generally must have single quotes around them going into MYSQL.
####################################################################################

#Check tables exist
dbListTables(mydb)

# Using paste to create a query, displying it and throwing it at MYSQL
for(i in 1:nrow(train01)){
  query <- paste("INSERT INTO table1 VALUES(",i,",", paste(train01[i,], collapse = ", "), ")")
  query
  dbGetQuery(mydb,query)  
}

#Verifying output
temp <- dbGetQuery(mydb,"SELECT * FROM table2 limit 10;")
dbGetQuery(mydb,"SELECT COUNT(*) FROM table2;")

#Now let's loop through the full table and add all the data