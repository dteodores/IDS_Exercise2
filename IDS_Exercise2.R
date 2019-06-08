getwd()
setwd("C:/Users/dteodorescu/Downloads")
library(readxl)
titanic3 <- read_excel("titanic3.xls")
View(titanic3)
titanic <- titanic3
colnames(titanic)
titanic$embarked
library(dplyr)
titanic$embarked = as.character(titanic$embarked)
titanicFilledEmbarkedEmptyWithS <- titanic %>%
  mutate(embarked = ifelse(embarked == '', 'S', embarked))
titanicFilledEmbarkedEmptyWithS$embarked
titanicAgeRowsOnly <- filter(titanicFilledEmbarkedEmptyWithS, age != '')
titanicAgeMean <- mean(titanicAgeRowsOnly$age)
titanicFilledAgeWithMeanAge <- titanicFilledEmbarkedEmptyWithS %>%
  mutate(age = ifelse(is.na(age), titanicAgeMean, age))
titanicFilledAgeWithMeanAge$age
titanicFilledEmptyBoatWithNA <- titanicFilledAgeWithMeanAge %>%
  mutate(boat = ifelse(boat == '', NA, boat))
titanicFilledEmptyBoatWithNA$boat
titanicAddedHasCabinNumber <-  titanicFilledEmptyBoatWithNA %>%
  mutate(has_cabin_number = ifelse(cabin == '', 0, 1))
titanicAddedHasCabinNumber$has_cabin_number
write.csv(titanicAddedHasCabinNumber, file = "titanic_clean.csv")

