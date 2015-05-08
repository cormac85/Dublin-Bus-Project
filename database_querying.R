#Function: 
#Author: Cormac Nolan
#Date: 03/03/2015

#load packages here and some housekeeping
library(dplyr)
library(RMySQL)
library(vioplot)
library(ggplot2)

rm(list=ls())
setwd("C:/Users/King Mac/Google Drive/Coding/DIT/5. Project/Dublin-Bus-Project")

#FUNCTIONS GO HERE!

#converts the timestamp into a date time POSIXct object
dtConvert <- function(timestamp){
  timestamp <- timestamp/1000000
  return(as.POSIXct((timestamp), origin="1970-01-01"))
}

#converts two latitude and longitude co-ordinates into a distance in metres.
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

# Takes a connection to the database, the day of the month of the dataset 
# and the line ID (i.e. the name of  the busroute) and returns a 
# dataset with the time, distance and average speed of each record 
# of each vehicle journey ID on that day. 
getJourneyAveSpeeds <- function(lineID, day, mydb){
  query <- paste("SELECT * FROM table",day," WHERE LineID =", lineID, sep='')
  
  lineID.Data <- dbGetQuery(mydb, query)
  
  journey.names <- distinct(select(lineID.Data, VehicleJourneyID))
  num.journeys <- nrow(journey.names)
  
  #get the largest possible number of rows required
  max.num.vehicle.journeys <- sort(table(lineID.Data$VehicleJourneyID), decreasing=TRUE)[[1]]
  
  #create a matrix for speed, distance and time for each vehicle journey ID.
  # The num rows is determined by the vehiclejourneyID with the most records.
  # The num columns is determined by the number of unique vehicle journey id's
  journey.aveSpeed <- matrix(nrow=max.num.vehicle.journeys, ncol=num.journeys)
  colnames(journey.aveSpeed) <- journey.names[,1]
  journey.distances <- matrix(nrow=max.num.vehicle.journeys, ncol=num.journeys)
  colnames(journey.distances) <- journey.names[,1]
  journey.times <- matrix(nrow=max.num.vehicle.journeys, ncol=num.journeys)
  colnames(journey.times) <- journey.names[,1]
  # loop through those vectors and calculate the distances in metres and times in seconds
  # between the recorded locations of the bus.
  for(j in 1:num.journeys){
    journey.data <- filter(lineID.Data, VehicleJourneyID == journey.names[j,])
    for(i in 2:nrow(journey.data)){
      journey.distances[i,j] <- coordConvert(journey.data$LatWGS84[i-1],
                                             journey.data$LonWGS84[i-1],
                                             journey.data$LatWGS84[i],
                                             journey.data$LonWGS84[i]
                                             )
      journey.times[i,j] <- (journey.data$Timestamp[i] - journey.data$Timestamp[i-1])/1000000
      
    }
  }
  #Make sure the first row is 0 distance and time
  journey.distances[1,] <- 0
  journey.times[1,] <- 0

  # get the average speed
  journey.aveSpeed <-  journey.distances/journey.times
  journey.aveSpeed[1,] <- 0  #make sure first row is 0
  
  return(journey.aveSpeed)
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

#Store names of all columns in database.
names = c("Timestamp", "LineID", "JourneyPatternID",
          "TimeFrame", "VehicleJourneyID", "Congestion",
          "LonWGS84", "LatWGS84", "Delay", "BlockID", "VehicleID", 
          "StopID", "AtStop" )

#Check tables exist
dbListTables(mydb)

#Verifying output
query <- dbGetQuery(mydb,"SELECT * FROM table2 limit 10;")
dbGetQuery(mydb,"SELECT COUNT(*) FROM table2;")


#############################
### QUERYING THE DATABASE ###
#############################
#let's take a sample journey and see what we can do
#sampleJourney1 <- filter(train01, LineID == 67, VehicleJourneyID == 13649)
sampleJourney <- dbGetQuery(mydb, 
                    "SELECT * FROM table1 WHERE LineID = '67' AND VehicleJourneyID = 13649")
 

all67 <- dbGetQuery(mydb, 
                    "SELECT * FROM table1 WHERE LineID = '67'")


#loop through it to get distance travelled between each time interval,
#while storing said time interval.
sj1.aveSpeed <- matrix(nrow=0, ncol=0)#create an empty matrix

sj1.distances <- vector()#create empty vectors
sj1.times <- vector()
# loop through those vectors and calculate the distances in metres and times in seconds
# between the recorded locations of the bus.
for(i in 2:nrow(sampleJourney)){
  sj1.distances[i] <- coordConvert(sampleJourney$LatWGS84[i-1],
                                   sampleJourney$LonWGS84[i-1],
                                   sampleJourney$LatWGS84[i],
                                   sampleJourney$LonWGS84[i]
                                   )
  sj1.times[i] <- (sampleJourney$Timestamp[i] - sampleJourney$Timestamp[i-1])/1000000
  
}

#Add the distance and time difference vectors to the matrix, as well as
#the calculated average speed in metres per second.

sj1.aveSpeed <- cbind(sj1.distances,sj1.times, sj1.distances/sj1.times)
sj1.aveSpeed <- data.frame(sj1.aveSpeed)#convert to data frame
names1 <- c("distances", "times", "aveSpeed")#add column titles
names(sj1.aveSpeed) <-names1

#set the first values as 0 (zero distance, zero time, zero speed)
sj1.aveSpeed[1,1:3] <- 0
head(sj1.aveSpeed$distances)

vioplot(sj1.aveSpeed$distances,col="orange", names = names1[1])
vioplot(sj1.aveSpeed$times, col="orange", names = names1[2])
vioplot(sj1.aveSpeed$aveSpeed, col="orange", names = names1[3])

#Let's have a look at the calculated distance, times & speeds.
summary(sj1.aveSpeed)#
# average speed sorted in descending order and in km/hr
arrange(sj1.aveSpeed,desc(aveSpeed) )
median(sj1.aveSpeed$aveSpeed)# Median speed of this journey within the bounding box.


# Let's try the same as above using a function for all vehicle journeys for a
#particular bus route
medians <- vector()
# Let's look at all days in the month for the same bus route.
for(i in 1:31){
  aveSpeeds67 <- as.data.frame(getJourneyAveSpeeds(67,i, mydb))
  medians[i] <- median(apply(aveSpeeds67, 2, function(x) median(x,na.rm=TRUE)))
}

qplot(1:31,medians, geom=c("point"), method="auto",
      main="Day of the Month vs Median Speed of all 67 Buses on that Day",
      ylab="Median Speed (m/s)", xlab="Day of the Month of January 2013") +
  ylim(0,5.5)+
  stat_smooth(fill="grey50", size=2, alpha=0.5)


