rm(list=ls())

library(dplyr)
library(vioplot)
setwd("C:/Users/King Mac/Google Drive/Coding/DIT/5. Project/siri.20130131.csv")

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

raw01 <- read.csv("siri.20130101.csv",header=FALSE)
names = c("Timestamp", "LineID", "Direction", "JourneyPatternID",
          "TimeFrame", "VehicleJourneyID", "Operator", "Congestion",
          "LonWGS84", "LatWGS84", "Delay", "BlockID", "VehicleID", 
          "StopID", "AtStop" )
names(raw01) <- names

raw01$Direction <- NULL #redundant

train01 <-raw01

#let's take a sample journey and see what we can do {dplyr}
sampleJourney1 <- filter(train01, LineID == 67, VehicleJourneyID == 13649)

#loop through it to get distance travelled between each time interval,
#while storing said time interval.
sj1.aveSpeed <- matrix(nrow=0, ncol=0)#create an empty matrix

sj1.distances <- vector()#create empty vectors
sj1.times <- vector()
#loop through those vectors and calculate the distances and times.
for(i in 2:187){
  sj1.distances[i] <- coordConvert(sampleJourney1$LatWGS84[i-1],
                                sampleJourney1$LonWGS84[i-1],
                                sampleJourney1$LatWGS84[i],
                                sampleJourney1$LonWGS84[i]
                                )
  sj1.times[i] <- (sampleJourney1$Timestamp[i] - sampleJourney1$Timestamp[i-1])/1000000.0
  
}

#Add the distance and time difference vectors to the matrix, as well as
#the calculated average speed.

sj1.aveSpeed <- cbind(sj1.distances,sj1.times, sj1.distances/sj1.times)
sj1.aveSpeed <- data.frame(sj1.aveSpeed)#convert to data frame
names1 <- c("distances", "times", "aveSpeed")#add column titles
names(sj1.aveSpeed) <-names1

#set the first values as 0 (zero distance, zero time, zero speed)
sj1.aveSpeed[1,1:3] <- 0
sj1.aveSpeed$distances

vioplot(sj1.aveSpeed$distances,col="orange", names = names1[1])
vioplot(sj1.aveSpeed$times, col="orange", names = names1[2])
vioplot(sj1.aveSpeed$aveSpeed, col="orange", names = names1[3])

#Let's have a look at the calculated distance, times & speeds.
summary(sj1.aveSpeed$times)#we can see a few outliers, some unrealistic average speeds. Unknown cause.
arrange(sj1.aveSpeed[3],desc(aveSpeed) )#more clearly seen here.
median(sj1.aveSpeed$aveSpeed)#median speed over journey

