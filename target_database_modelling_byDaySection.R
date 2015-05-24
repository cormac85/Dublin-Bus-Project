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

# Now create an aggregate speed over each DaySection

by_section <- group_by(target.data.noOutliers.noLower, Day, DaySection, TowardsCentre)
data.aggregate <- summarise(by_section, count=n(), medianSpeeds = median(medianSpeeds))

######################################
# Section 1
# Use the data from one daysection to model against the aggregate of 
# the speeds in the subsequent daysection(s).
######################################

######################################
# Section 2
# Straightforward timeseries modelling on a day's worth of data (can
# this be done over the entire set of data? training and testing splits?)
######################################
train <- filter(data.aggregate, Day >= 1, Day <=23, TowardsCentre == 1, DaySection != 1)
train.away <- filter(data.aggregate, Day >= 1, Day <=23, TowardsCentre == 0, DaySection != 1)
test <- filter(data.aggregate, Day >= 24, Day <=31, TowardsCentre == 1, DaySection != 1)
test.away <- filter(data.aggregate, Day >= 24, Day <=31, TowardsCentre == 0, DaySection != 1)

ggplot(train, aes(factor(DaySection),medianSpeeds))+
  geom_violin(aes(fill = factor(DaySection))) + 
  geom_jitter(height = 0) +
  theme(legend.position="none")

fcast.length = 20
######################################
# Section 2.1 auto.arim forecasting (https://www.otexts.org/fpp/8/7) using 'forecast'

#Towards Centre
arima1.fit.noOutliers.noLower <- auto.arima(train$medianSpeeds, trace=T, 
                                            seasonal=F, parallel=T, stepwise=F )
arima1.fcast.noOutliers.noLower <- forecast(arima1.fit.noOutliers.noLower, h=fcast.length)

# Away from centre
arima1.fit.noOutliers.noLower.away <- auto.arima(train.away$medianSpeeds, trace=T, 
                                            seasonal=F, parallel=T, stepwise=F )
arima1.fcast.noOutliers.noLower.away <- forecast(arima1.fit.noOutliers.noLower.away,
                                                 h=fcast.length)
######################################
# Section 2.2 NNet forecasting using 'forecast' package.
#Using full dataset
nnetar.fit.noOutliers.noLower <- nnetar(train$medianSpeeds)
nnetar.fcast.noOutliers.noLower <- forecast(nnetar.fit.noOutliers.noLower, h =fcast.length)

#Away
nnetar.fit.noOutliers.noLower.away <- nnetar(train.away$medianSpeeds)
nnetar.fcast.noOutliers.noLower.away <- forecast(nnetar.fit.noOutliers.noLower.away, h =fcast.length)

######################################
# Section 2.3 'forecast' package ets() function.
# Uses multiple competing exponential smoothing functions to predict.
# Validates via AIC (?)

# Towards
ets.fit.damped.noOutliers.noLower <- ets(train$medianSpeeds, damped=T)
ets.fit.noOutliers.noLower <- ets(train$medianSpeeds, damped=F)

ets.fcast.damped.noOutliers.noLower <- forecast(ets.fit.damped.noOutliers.noLower,
                                                h =fcast.length)
ets.fcast.noOutliers.noLower <- forecast(ets.fit.noOutliers.noLower,
                                         h =fcast.length)

# Away
ets.fit.damped.noOutliers.noLower.away <- ets(train.away$medianSpeeds, damped=T)
ets.fit.noOutliers.noLower.away <- ets(train.away$medianSpeeds, damped=F)

ets.fcast.damped.noOutliers.noLower.away <- forecast(ets.fit.damped.noOutliers.noLower.away,
                                                     h =fcast.length)
ets.fcast.noOutliers.noLower.away <- forecast(ets.fit.noOutliers.noLower.away,
                                              h =fcast.length)

######################################
#Section 3: Model testing & comparison
######################################
plot(ets.fcast.damped.noOutliers.noLower)
plot(ets.fcast.noOutliers.noLower)
plot(nnetar.fcast.noOutliers.noLower)
plot(arima1.fcast.noOutliers.noLower)
plot(ets.fcast.damped.noOutliers.noLower.away)
plot(ets.fcast.noOutliers.noLower.away)
plot(nnetar.fcast.noOutliers.noLower.away)
plot(arima1.fcast.noOutliers.noLower.away)

Acf(residuals(arima1.fit.noOutliers.noLower))
Acf(residuals(nnetar.fit.noOutliers.noLower))
Acf(residuals(ets.fit.noOutliers.noLower))
Acf(residuals(ets.fit.damped.noOutliers.noLower))
Acf(residuals(arima1.fit.noOutliers.noLower.away))
Acf(residuals(nnetar.fit.noOutliers.noLower.away))
Acf(residuals(ets.fit.noOutliers.noLower.away))
Acf(residuals(ets.fit.damped.noOutliers.noLower.away))

Box.test(residuals(arima1.fit.noOutliers.noLower), lag=24, fitdf=4, type="Ljung")
Box.test(residuals(nnetar.fit.noOutliers.noLower), lag=24, fitdf=4, type="Ljung")
Box.test(residuals(ets.fit.damped.noOutliers.noLower), lag=24, fitdf=4, type="Ljung")
Box.test(residuals(ets.fit.noOutliers.noLower), lag=24, fitdf=4, type="Ljung")
Box.test(residuals(arima1.fit.noOutliers.noLower.away), lag=24, fitdf=4, type="Ljung")
Box.test(residuals(nnetar.fit.noOutliers.noLower.away), lag=24, fitdf=4, type="Ljung")
Box.test(residuals(ets.fit.damped.noOutliers.noLower.away), lag=24, fitdf=4, type="Ljung")
Box.test(residuals(ets.fit.noOutliers.noLower.away), lag=24, fitdf=4, type="Ljung")


#Model errors.
accuracy(ets.fcast.damped.noOutliers.noLower)
accuracy(ets.fcast.noOutliers.noLower)
accuracy(arima1.fcast.noOutliers.noLower)
accuracy(nnetar.fcast.noOutliers.noLower)
accuracy(ets.fcast.damped.noOutliers.noLower.away)
accuracy(ets.fcast.noOutliers.noLower.away)
accuracy(arima1.fcast.noOutliers.noLower.away)
accuracy(nnetar.fcast.noOutliers.noLower.away)

# Testing models versus the test dataset
test.model.ets <- ets(test$medianSpeeds, 
                      model = ets.fit.noOutliers.noLower)
test.model.ets.damped <- ets(test$medianSpeeds,
                             model = ets.fit.damped.noOutliers.noLower)
test.model.arima1 <- Arima(test$medianSpeeds, 
                           model = arima1.fit.noOutliers.noLower)
test.model.ets.away <- ets(test.away$medianSpeeds, 
                           model = ets.fit.noOutliers.noLower.away)
test.model.ets.damped.away <- ets(test.away$medianSpeeds, 
                                  model = ets.fit.damped.noOutliers.noLower.away)
test.model.arima1.away <- Arima(test.away$medianSpeeds, 
                                model = arima1.fit.noOutliers.noLower.away)


accuracy(test.model.ets)
accuracy(test.model.ets.damped)
accuracy(test.model.arima1)
accuracy(test.model.ets.away)
accuracy(test.model.ets.damped.away)
accuracy(test.model.arima1.away)

# Playing around with forecast() with the NNetar model to calculate a RMSE

nnetar.fit.test <- nnetar(train$medianSpeeds)
nnetar.fcast.test <- forecast(nnetar.fit.test, h =nrow(test))
plot(nnetar.fcast.test)

forecast_nums <- as.vector(nnetar.fcast.test$mean)

forecast_nums <- cbind(forecast_nums, test$medianSpeeds)
rmse <- sqrt(mean((forecast_nums[,1]-forecast_nums[,2])^2))
rmse

plot(forecast_nums)