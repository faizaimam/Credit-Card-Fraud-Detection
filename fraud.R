install.packages("tidyverse")
library(tidyverse)
install.packages("caret")
library(caret)
install.packages("randomForest")
library(randomForest)
#Preprocessing Data
data <-read.csv("creditcard.csv", header =T)
sum(is.na(data))
summary(data)

data$Class <- as.factor(data$Class)
data$Class <- factor(data$Class, levels = c("1", "0"),labels = c("Fraud", "Normal"))
plot(data$Class)
tapply(data$Amount, data$Class, summary)
data$Normal <- ifelse(data$Class == "Normal", 1, 0)
data$Fraud <- ifelse(data$Class == "Fraud", 1, 0)
sum(data$Normal)
sum(data$Fraud)
data$Class[data$Class == 1] <- "Fraud"

#Model Building

x <- subset(data, select =c(-Class)) 
y <- subset(data, select = Class)
nrow(x)
nrow(y)
head(x)

trainIndex <- createDataPartition(data$Class, p = .7, list = F)
train <- data[trainIndex, ]
test <- data[-trainIndex, ]
names(data)
trainX <- train[, c("Time", "V1", "V2", "V3", "V4", "V5", "V6",
                    "V7","V8","V9","V10","V11","V12","V13",   
                    "V14","V15","V16","V17","V18","V19","V20",   
                    "V21","V22","V23","V24", "V25", "V26" ,"V27" ,   
                    "V28", "Amount")]
trainY <- train$Class
testX <- test[, c("Time", "V1", "V2", "V3", "V4", "V5", "V6",
                  "V7","V8","V9","V10","V11","V12","V13",   
                  "V14","V15","V16","V17","V18","V19","V20",   
                  "V21","V22","V23","V24", "V25", "V26" ,"V27" ,   
                  "V28", "Amount")]
testY <- test$Class 

model <- randomForest(x = trainX, y=trainY, ntree = 100)
predictions <- predict(model, newdata = testX)
CM <- confusionMatrix(data = predictions, reference = testY)
accuracy <- CM$overall["Accuracy"]


