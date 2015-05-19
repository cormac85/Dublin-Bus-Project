#Function: 
#Author: Cormac Nolan
#Date: 11/04/2015

#load packages here and some housekeeping
library(dplyr)
library(RMySQL)

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
    if(nrow(journey.data) > 1){
      for(i in 2:nrow(journey.data)){
      
        journey.distances[i,j] <- coordConvert(journey.data$LatWGS84[i-1],
                                               journey.data$LonWGS84[i-1],
                                               journey.data$LatWGS84[i],
                                               journey.data$LonWGS84[i]
        )
        journey.times[i,j] <- (journey.data$Timestamp[i] - journey.data$Timestamp[i-1])/1000000
      }
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

getDirections <- function(data){

  #get names of journeys
  journey.names <- distinct(select(data, VehicleJourneyID))
  num.journeys <- nrow(journey.names)
  
  # create new data field with the journey names and the direction of travel
  directions <- journey.names
  directions["TowardsCentre"] <- NA
  
  # calculate if journeys are into or out of centre.
  for(i in 1:num.journeys){
    journey.single <- filter(data, VehicleJourneyID == journey.names[i,1])
    
    if((journey.single[1, 3] - journey.single[nrow(journey.single),3]) > 0 ){
      directions[directions$VehicleJourneyID == journey.names[i,1],]$TowardsCentre = 0
    } else if((journey.single[1, 3] - journey.single[nrow(journey.single),3]) < 0 ){
      directions[directions$VehicleJourneyID == journey.names[i,1],]$TowardsCentre = 1
    } else{
      directions[directions$VehicleJourneyID == journey.names[i,1],]$TowardsCentre = NA
    }
  }

  return(directions)
}

# Returns the daysection given an hour of the day
getDaySection <- function(x){
  sapply(x, function(x){
    if(x >= 0 && x < 6){
      return(1) 
    }else if(x >= 6 && x < 12){
      return(2) 
    }else if(x >= 12 && x < 18){
      return(3) 
    }else if(x >= 18 && x < 24){
      return(4) 
    }else {
      return(NA) 
    }
  })}


# Takes the final dataset and calculates the distance between each consecutive record.
# It then returns the entire dataset.
getDistances <- function(x){
  
  x["AveSpeed"] <- NA # Create new aveSpeed column
  
  # Put the distances travelled into this column
  for(i in 1:(nrow(x)-1) ){
    lat1 <- x[i,4]
    long1 <- x[i,3]
    lat2 <- x[i+1,4]
    long2 <- x[i+1,3]
    
    x[i+1,7] <- coordConvert(lat1, long1, lat2, long2)
    
  }
  return(x)
}

# Takes the final datset with distances between records calculated,
# it then calculates the time difference and returns the dataset with
# the average speeds calculated at each point.
getAverageSpeeds <- function(x){

  for(i in 1:(nrow(x)-1) ){    
    time.diff <- ((x[i+1,1] - x[i,1]) / 1000000)
    x[i+1,7] <- x[i+1,7] / time.diff
  }
  
  return(x)
  
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

# Get dataset for modelling. First step is to prototype the process of
# extracting the data I want before putting it into fucntion(s).
#
# This prototype Dataset should have columns: 
# Timestamp,  Day Section,  TowardsCity, JourneyPattern, AverageSpeed.

#Get the 67 data on day 1 with the data I require.
lineID=67
day = 1
query <- paste("SELECT Timestamp, VehicleJourneyID, LonWGS84,LatWGS84 FROM table",
               day," WHERE LineID =", lineID, sep='')

lineID.Data <- dbGetQuery(mydb, query)

#get the VehicleJourneyID's for the 67 on that day & number of the journeys.
journey.names <- distinct(select(lineID.Data, VehicleJourneyID))
num.journeys <- nrow(journey.names)


# Use custom function to get the direction in which each bus is travelling.
# Then update the lineID data with the directions.
directions <- getDirections(lineID.Data)

lineID.Data["TowardsCentre"] <- NA

for(i in 1:num.journeys){
  lineID.Data[lineID.Data$VehicleJourneyID == directions[i,1],]$TowardsCentre = directions[i,2]
}

# Calculate the day section, first create column and convert timestamp to datetime
lineID.Data["DaySection"] <- NA
lineID.Data.Final = lineID.Data %>% rowwise() %>% mutate(DaySection = dtConvert(Timestamp))
lineID.Data$DaySection <- NULL
lineID.Data$TowardsCentre <- NULL

# Now convert that to hour of the day and make integer
lineID.Data.Final$DaySection <- as.integer(strftime(lineID.Data.Final$DaySection, format="%H"))

# Finally convert hour to day section using the following conversion:
# (0:5: = 1, 6:11=2, 12:5=3, 6:11=4)
lineID.Data.Final$DaySection <- getDaySection(lineID.Data.Final$DaySection)

#calculate the average speed between each subsequent record for each journeyID
# This will be divided up into 4 steps

# Step 1: Sort dataset by journey ID and then timestamp
lineID.Data.Final <- arrange(lineID.Data.Final, VehicleJourneyID, Timestamp)

# Step 2: Get distance between each subsequent point
# Needs cleanup when one vehiclejourney transitions to the next
lineID.Data.Final <- getDistances(lineID.Data.Final)

# Create new record variable, it's the index.
lineID.Data.Final["Record"] <- 1:nrow(lineID.Data.Final)
# Create empty vector to hold the references to the first chronological instance
# of a vehicle journey.
first.vehiclejourney.references <- vector()

# Get the references and put them in this vector
for(i in 1:num.journeys){
  first.vehiclejourney.references[i] <- lineID.Data.Final[lineID.Data.Final$VehicleJourneyID == journey.names[i,1],][[1,8]]
}


# Get list of where distance values are invalid, ie the first member of each set
temp <- sapply(lineID.Data.Final$Record, function(x){
  if(is.element(x,first.vehiclejourney.references) )
    x = T
  else
    x=F
  }    
)

# use list to set each invalid distance measurement to NA
lineID.Data.Final[temp,7] = NA

# Step 3: Calculate the time difference between each step in our Final 
# dataset and divide into distance to get average speed.
lineID.Data.Final <- getAverageSpeeds(lineID.Data.Final)


#Step 4: Clean the Dataset
lineID.Data.Final.NoNA <- na.omit(lineID.Data.Final)
lineID.Data.Final.NoNA$LatWGS84 <- NULL
lineID.Data.Final.NoNA$LonWGS84 <- NULL

#Scratchpad


# Clean up the workspace
rm(lineID)
rm(day)
rm(query) 
rm(journey.names)
rm(num.journeys)
rm(i)