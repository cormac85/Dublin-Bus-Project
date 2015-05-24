#Author: Cormac Nolan 
#Date: 2015/05/24

# This script has the following purposes:

# 1. Use the data from one daysection to model against the aggregate of 
# the speeds in the subsequent daysection(s).
# 2.  Straightforward timeseries modelling on a day's worth of data (can
# this be done over the entire set of data? training and testing splits?)
# 3. Simple classification of a bus as performing "well", "normal" or 
# "badly" (compare day of week with day of week? use daysections?)


library(dplyr)
library(ggplot2)
library(nnet)
library(caret)
library(forecast)

rm(list=ls())

setwd("C:/Users/King Mac/Google Drive/Coding/DIT/5. Project/Dublin-Bus-Project")

# import
# target.data <- read.csv("target.data.final.journeyMedians.csv") #Use if needed
target.data.noOutliers <- read.csv("target.data.noOutliers.csv")
target.data.noOutliers.noLower <- read.csv("target.data.noOutliers.noLower.csv")

#make sure they're sorted by timestamp
target.data.noOutliers <- arrange(target.data.noOutliers, medianTime)
target.data.noOutliers.noLower <- arrange(target.data.noOutliers.noLower, medianTime)


# Section 1
# Use the data from one daysection to model against the aggregate of 
# the speeds in the subsequent daysection(s).

# Section 2
# Straightforward timeseries modelling on a day's worth of data (can
# this be done over the entire set of data? training and testing splits?)
train <- filter(target.data.noOutliers.noLower, Day >= 1, Day <=23, TowardsCentre == 1)
train.away <- filter(target.data.noOutliers.noLower, Day >= 1, Day <=23, TowardsCentre == 0)
test <- filter(target.data.noOutliers.noLower, Day >= 24, Day <=31, TowardsCentre == 1)
test.away <- filter(target.data.noOutliers.noLower, Day >= 24, Day <=31, TowardsCentre == 0)

ggplot(train, aes(x=medianTime, y=medianSpeeds))+geom_line()

fcast.length = 50

# Section 2.1 auto.arim forecasting (https://www.otexts.org/fpp/8/7) using 'forecast'
arima1.fit.noOutliers.noLower <- auto.arima(train$medianSpeeds, trace=T, 
                                            seasonal=F, parallel=T, stepwise=F )
summary(arima1.fit.noOutliers.noLower)

arima1.fcast.noOutliers.noLower <- forecast(arima1.fit.noOutliers.noLower, h=fcast.length)


# Section 2.2 NNet forecasting using 'forecast' package
nnetar.fit.noOutliers.noLower <- nnetar(train$medianSpeeds)
                                 )

nnetar.fcast.noOutliers.noLower <- forecast(nnetar.fit.noOutliers.noLower, h =fcast.length)


# Section 2.3 'forecast' package ets() function.
# Uses multiple competing linear and exponential smoothing functions to predict.
# Validates via AIC (?)

ets.fit.damped.noOutliers.noLower <- ets(train$medianSpeeds, damped=T)
ets.fit.noOutliers.noLower <- ets(train$medianSpeeds, damped=F)

Acf(residuals(ets.fit.damped.noOutliers.noLower))
Acf(residuals(ets.fit.noOutliers.noLower))

ets.fcast.damped.noOutliers.noLower <- forecast(ets.fit.damped.noOutliers.noLower, h =fcast.length)
ets.fcast.noOutliers.noLower <- forecast(ets.fit.noOutliers.noLower, h =fcast.length)

plot(ets.fcast.damped.noOutliers.noLower)
plot(ets.fcast.noOutliers.noLower)

#Section 2.4: Model testing & comparison

Acf(residuals(arima1.fit.noOutliers.noLower))
Box.test(residuals(arima1.fit.noOutliers.noLower), lag=24, fitdf=4, type="Ljung")

Acf(residuals(nnetar.fit.noOutliers.noLower))
Acf(residuals(ets.fit.noOutliers.noLower))
Acf(residuals(ets.fit.damped.noOutliers.noLower))

#Model errors. NNet seems to win out, must check for overfitting.
accuracy(ets.fcast.damped.noOutliers.noLower)
accuracy(ets.fcast.noOutliers.noLower)
accuracy(arima1.fcast.noOutliers.noLower)
accuracy(nnetar.fcast.noOutliers.noLower)

test.model.ets <- ets(test$medianSpeeds, model = ets.fit.noOutliers.noLower)
test.model.ets.damped <- ets(test$medianSpeeds, model = ets.fit.damped.noOutliers.noLower)
test.model.arima1 <- Arima(test$medianSpeeds, model = arima1.fit.noOutliers.noLower)
accuracy(test.model.ets)
accuracy(test.model.ets.damped)
accuracy(test.model.arima1)