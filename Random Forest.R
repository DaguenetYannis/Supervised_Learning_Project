#Random Forest
rm(list=ls())
library(tidyverse)
library(ggplot2)
library(randomForest)
library(caret)
learn_set <- read.csv("learn_dataset.csv")
test_set <- read.csv("test_dataset.csv")


#Premier test
#Experimenting_result  <- randomForest(target ~., data=learn_set, ntree=10)
#summary(Experimenting_result$mse)
set.seed(15)
split <- createDataPartition(learn_set$target, p = 0.7)
learning_set <- learn_set[split[[1]], ]
validation_set <- learn_set[-split[[1]],]

#Constructing the random forest
Rand_Forest <- randomForest(target ~., data=learning_set, ntree=10)
predictions <- predict(Rand_Forest, validation_set)
predictions_mse <- mean(predictions[[1]]-learning_set$target)^2

#Constructing and applying the loop
numbers <- c(2, 5, 10, 25, 40)
predictions_mse <- rep(NA, length(numbers))
j<-1

for (i in numbers){
  Rand_Forest <- randomForest(target ~., data=learning_set, ntree=i, mtry = 5)
  predictions <- predict(Rand_Forest, validation_set)
  predictions_mse[j] <- mean(predictions[[1]]-learning_set$target)^2
  j <- j+1
}

#deal with NA
#predictions_mse_NA <- na.omit(predictions_mse)

#Create a dataframe and plot MSEs
#predictions_mse_ggplot <- data.frame(predictions_mse_NA, numbers)
predictions_mse_ggplot <- data.frame(predictions_mse, numbers)
predictions_mse_ggplot %>% ggplot(aes(x = numbers,
                                      y = predictions_mse))+
                          geom_point()+
                          geom_line()

#Observe statistics
summary(predictions_mse_ggplot$predictions_mse_NA)

#Create a loop over another parameter
numbers <- seq(2, 502, by = 50)
predictions_mse2 <- rep(NA, length(numbers))
j<-1

for (i in numbers){
  Rand_Forest <- randomForest(target ~., data=learning_set, maxnodes = i , ntree=15, mtry = 5)
  predictions <- predict(Rand_Forest, validation_set)
  predictions_mse2[j] <- mean(predictions[[1]]-learning_set$target)^2
  j <- j+1
}

predictions_mse_ggplot2 <- data.frame(predictions_mse2, numbers)
predictions_mse_ggplot2 %>% ggplot(aes(x = numbers,
                                      y = predictions_mse2))+
  geom_point()+
  geom_line()

#Other parameter
set.seed(15)
numbers <- seq(1,8)
predictions_mse <- rep(NA, length(numbers))
j<-1

for (i in numbers){
  Rand_Forest <- randomForest(target ~., data=learning_set, ntree=3, mtry = i)
  predictions <- predict(Rand_Forest, validation_set)
  predictions_mse[j] <- mean(predictions[[1]]-learning_set$target)^2
  j <- j+1
}

Rand_Forest$predicted
predictions

ggplot_les_predictions_wesh <- data.frame(Rand_Forest$predicted, predictions)

predictions_mse_ggplot <- data.frame(predictions_mse, numbers)
predictions_mse_ggplot %>% ggplot(aes(x = numbers,
                                      y = predictions_mse))+
  geom_point()+
  geom_line()
