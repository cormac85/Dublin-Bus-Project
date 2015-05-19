# Author: Cormac Nolan
# Date: 19/05/2015
# Purpose: Explore, error check and visualise the tidied target 
# dataset from Dublin Bus Insight Project GPS data.

library(dplyr)
library(ggplot2)

rm(list=ls())

setwd("C:/Users/King Mac/Google Drive/Coding/DIT/5. Project/Dublin-Bus-Project")

# import
target.data <- read.csv("target.data.final.journeyMedians.csv")

#This one is ~300mb, load only if needed.
# read.csv("target.data.final.raw.csv")


#Summary Statistics
summary(target.data)

p <- ggplot(target.data, aes(factor(DaySection), medianSpeeds))
p + geom_violin(aes(fill=factor(DaySection))) +
  labs(x="Day Section (1-4)", y="Median Journey Speed",
       title="Violin Plot of Average Speeds in Different Day Sections on All Days") +
  theme(plot.title=element_text(size=rel(1.8),face="bold"), 
        axis.text=element_text(size=rel(1.2))) +
  theme(axis.title=element_text(size=rel(1.3),face="bold"))+
  theme(legend.position="none") +
  geom_boxplot(width=0.1, outlier.colour = "blue", outlier.size = 3)

#The speeds here are ridiculous on the outliers. Median and mean are well within
# expected speeds. Need to delete outliers with a robust method.

# Max speed for a bus is 100 kph on dualcarriageways (~28 m/s). We will exclude all
# median speeds above 50 and see where we lie. We'll also remove speeds = 0.

target.data.noOutliers <- filter(target.data, medianSpeeds < 50)

target.data.noOutliers <- filter(target.data.noOutliers, medianSpeeds != 0)

summary(target.data.noOutliers)
summary(target.data)


p <- ggplot(target.data.noOutliers, aes(factor(DaySection), medianSpeeds))
p + geom_violin(aes(fill=factor(DaySection))) +
  labs(x="Day Section (1-4)", y="Median Journey Speed",
       title="Violin Plot of Average Speeds in Different Day Sections on All Days (Outliers Removed)") +
  theme(plot.title=element_text(size=rel(1.8),face="bold"), 
        axis.text=element_text(size=rel(1.2))) +
  theme(axis.title=element_text(size=rel(1.3),face="bold"))+
  theme(legend.position="none") +
  geom_boxplot(width=0.1, outlier.colour = "blue", outlier.size = 3)
#Plot looks reasonable. BUT! The fat bottom tail of the plots either represent some 
# seriously noisy data or a methodological error. Let's look at this fat bottom to the 
# distributions

p <- ggplot(filter(target.data.noOutliers, medianSpeeds < 0.25), aes(factor(DaySection), medianSpeeds))
p + geom_violin(aes(fill=factor(DaySection))) +
  labs(x="Day Section (1-4)", y="Median Journey Speed",
       title="Violin Plot of Average Speeds in Different Day Sections on All Days (Outliers Removed)") +
  theme(plot.title=element_text(size=rel(1.8),face="bold"), 
        axis.text=element_text(size=rel(1.2))) +
  theme(axis.title=element_text(size=rel(1.3),face="bold"))+
  theme(legend.position="none") +
  geom_boxplot(width=0.1, outlier.colour = "blue", outlier.size = 3)

by_section <- group_by(filter(target.data.noOutliers,medianSpeeds < 0.25), Day, DaySection)
View(summarise(by_section,
          count=n(),
          median = median(medianSpeeds)
          )
)

#So we make one dataset without the lower distribution. Selection criterion was eyeballed
# from the graph. Change this later to something rigorous if time.
target.data.noOutliers.noLower <- filter(target.data.noOutliers, medianSpeeds >= 0.25)

p <- ggplot(target.data.noOutliers.noLower, aes(factor(DaySection), medianSpeeds))
p + geom_violin(aes(fill=factor(DaySection))) +
  labs(x="Day Section (1-4)", y="Median Journey Speed",
       title="Violin Plot of Median Speeds in Different Day Sections on All Days (Outliers & Low Distribution Removed)") +
  theme(plot.title=element_text(size=rel(1.8),face="bold"), 
        axis.text=element_text(size=rel(1.2))) +
  theme(axis.title=element_text(size=rel(1.3),face="bold"))+
  theme(legend.position="none") +
  geom_boxplot(width=0.1, outlier.colour = "blue", outlier.size = 3)

summary(target.data.noOutliers.noLower)

by_section <- group_by(target.data.noOutliers.noLower, Day, TowardsCentre)
View(summarise(by_section,
               count=n(),
               median = median(medianSpeeds)
)
)

#plotting by day
p <- ggplot(target.data.noOutliers.noLower, aes(factor(Day), medianSpeeds))
p + geom_violin(aes(fill=factor(Day))) +
  labs(x=" Days of January 2013", y="Median Journey Speed",
       title="Violin Plot of Median Speeds on All Days (Outliers & Low Distribution Removed)") +
  theme(plot.title=element_text(size=rel(1.8),face="bold"), 
        axis.text=element_text(size=rel(1.2))) +
  theme(axis.title=element_text(size=rel(1.3),face="bold"))+
  theme(legend.position="none")+
  geom_boxplot(width=0.3, outlier.colour = "blue", outlier.size = 3)

