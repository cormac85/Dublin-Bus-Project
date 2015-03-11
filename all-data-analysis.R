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

#STEP 1: Import required data into an sql database

#create list of file names
csvFiles = list.files(pattern="*.csv")

#Initialise DB connection
#Use 1 if this is your first time setting up the databse.
#Use 2 if you're reconnecting to the database

#1.
#mydb = dbConnect(MySQL(), user='root', password='qwort', host='localhost')

#dbSendQuery(mydb, "CREATE DATABASE DublinBus;")
#dbSendQuery(mydb, "USE DublinBus")

#dbSendQuery(mydb, "drop table if exists Table1")

#2.
mydb = dbConnect(MySQL(), user='root', password='qwort', host='localhost')

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
train01[train01=="null"]=NA#replace data "nulls" with NA's
# creating tables for bus data storage:

dbSendQuery(mydb, "
  CREATE TABLE Table1 (
  TimestampID INT UNSIGNED NOT NULL AUTO_INCREMENT,
  Timestamp BIGINT UNSIGNED,
  LineID SMALLINT UNSIGNED,
  JourneyPatternID VARCHAR(8),
  TimeFrame DATE,
  VehicleJourneyID INT UNSIGNED,
  Congestion BOOL,
  LonWGS84 NUMERIC(7,6),
  LatWGS84 NUMERIC(7,6),
  Delay INT,
  BlockID INT UNSIGNED,
  VehicleID INT UNSIGNED,
  StopID INT UNSIGNED,
  AtStop BOOL,
  PRIMARY KEY (TimestampID)
  );
")

#Check table exists
dbListTables(mydb)
#check columns look right
dbGetQuery(mydb, "
select * from information_schema.columns
where table_schema = 'dublinbus'
order by table_name,ordinal_position
")