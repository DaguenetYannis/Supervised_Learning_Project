#Gradient_Boosting

#Random Forest
rm(list=ls())
library(tidyverse)
library(ggplot2)
library(randomForest)
library(caret)
learn_set <- read.csv("learn_dataset.csv")
test_set <- read.csv("test_dataset.csv")

Lili : # Load the packages we need
library(xgboost)
library(dplyr)
library(tidyverse)
library(fastDummies)
learn_set <- read.csv("learn_dataset.csv")
Y<-learn_set$target
X<-learn_set%>%select(-target)
str(X)
#transform factor into dummy
#install.packages("fastDummies")
#dans notre cas ça crée 13704 variables=> PB ++
X<-dummy_cols(X, remove_first_dummy = TRUE) #remove first dummy pour éviter la colinéarité
