---
output: 
  html_document:
    df_print: paged
---
## Credit Card Fraud Detection Model

### 1. Packages

```{r eval =TRUE, warning = FALSE, message = FALSE}
library(tidyverse)
library(caret)
library(randomForest)
```

### 2. Data Description

The data used here is from: https://www.kaggle.com/datasets/mlg-ulb/creditcardfraud.

This dataset contains transactions made by credit cards in September 2013 by European cardholders. The dataset has been collected and analysed during a research collaboration of Worldline and the Machine Learning Group (http://mlg.ulb.ac.be) of ULB (Université Libre de Bruxelles) on big data mining and fraud detection.

This dataset presents transactions that occurred in two days, where we have 492 frauds out of 284,807 transactions. The dataset is highly unbalanced, the positive class (frauds) account for 0.172% of all transactions.

It contains only numerical input variables which are the result of a PCA transformation. Due to confidentiality issues, the original features and more background information about the data could not be obtained. Features `V1`,`V2`, … `V28` are the principal components obtained with PCA, the only features which have not been transformed with PCA are `Time`and `Amount`. Feature `Time` contains the seconds elapsed between each transaction and the first transaction in the dataset. The feature `Amount` is the transaction Amount, this feature can be used for example-dependent cost-sensitive learning. Feature `Class` is the response variable and it takes value 1 in case of fraud and 0 otherwise.


#### 2.1 Loading Data

```{r comment = ""}
data <-read.csv("creditcard.csv", header =T)
data
```


#### 2.2 Preprocessing Data

Taking the `Class`variable transforming it from integer to factor with levels- "1" and "0" as Fraud and Normal case respectively.
R takes the first value of the label as the positive class by default, so make sure to choose the positive class as the first level.

```{r comment = ""}
data$Class <- as.factor(data$Class)
data$Class <- factor(data$Class, levels = c("1", "0"),labels = c("Fraud", "Normal"))
head(data)
```

### 3. Modeling


#### 3.1 Splitting the dataset into train and test set

```{r comment = ""}
set.seed(73)

x <- subset(data, select =c(-Class)) 
y <- subset(data, select = Class)
nrow(x) == nrow(y)

trainIndex <- createDataPartition(data$Class, p = .7, list = F)
train <- data[trainIndex, ]
test <- data[-trainIndex, ]

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
```

#### 3.2 Random Forest Model

Random Forest is a popular machine learning algorithm and is particularly useful when dealing with complex and high-dimensional datasets. The model is an ensemble learning method that combines multiple decision trees, known as the "forest," to make more accurate and robust predictions. Each decision tree in the forest is trained on a random subset of the data and a random subset of features, which helps to reduce overfitting and improve generalization.

```{r}
model <- randomForest(x = trainX, y=trainY, ntree = 100)
predictions <- predict(model, newdata = testX)

```


#### Confusion Matrix

A confusion matrix is primarily employed to evaluate the performance of a classification model. It is a square matrix that compares the predicted classifications of the model with the actual labels of the data. The matrix organizes the outcomes into four categories: true positives (correctly predicted positive instances), true negatives (correctly predicted negative instances), false positives (incorrectly predicted positive instances), and false negatives (incorrectly predicted negative instances). By examining these elements, the confusion matrix provides valuable insights into the model's accuracy, precision, recall, and F1 score, which are crucial performance metrics. This allows us to gain a comprehensive understanding of how well our model is performing and make informed decisions on potential improvements and adjustments.


```{r comment = "" }
CM <- confusionMatrix(data = predictions, reference = testY)
CM
accuracy <- CM$overall["Accuracy"]
accuracy
```

From the output, we get,

Confusion Matrix:
True Positive (Fraud): 120
False Negative (Normal predicted as Fraud): 7
False Positive (Fraud predicted as Normal): 27
True Negative (Normal): 85,287

Accuracy: 
Accuracy measures the overall correctness of the model's predictions. The overall accuracy of the model is 0.9996, indicating that it correctly predicts 99.96% of the instances.

No Information Rate:
The no information rate represents the accuracy achieved by a naive model that always predicts the most prevalent class. The proportion of the majority class (Normal) is 0.9983.

Kappa:
Kappa is a statistic that measures the agreement between the predicted and actual classes, considering the agreement that could be expected by chance alone. In this case, the Kappa value is 0.8757, which indicates a substantial level of agreement beyond what would be expected by chance.

Sensitivity, Specificity, Positive Predictive Value, Negative Predictive Value:
These measure the model's performance in terms of correctly identifying positive and negative instances.

Sensitivity: 
Sensitivity, also known as recall or true positive rate, measures the proportion of actual positive instances (Fraud) correctly identified by the model. Here the sensitivity is 0.816327, indicating that the model correctly identifies 81.63% of the actual fraud cases.

Specificity:
Specificity measures the proportion of actual negative instances (Normal) correctly identified by the model. A specificity of 0.999918 indicates a high level of accuracy in identifying normal instances.

Prevalence, Detection Rate:
Prevalence represents the proportion of positive instances (Fraud) in the dataset. Here the prevalence is 0.001720 or 0.17%. The detection rate measures the proportion of actual positive instances (Fraud) that are correctly identified by the model. In this case, the detection rate is 0.001404 or 0.14%.

Balanced Accuracy:
Balanced accuracy takes into account the performance on both positive and negative classes and provides an overall measure of model accuracy. A balanced accuracy of 0.908122 indicates a good performance in predicting both fraud and normal instances.

Based on these results, the model appears to have a high overall accuracy and performs well in identifying normal instances. 

However, the sensitivity for fraud cases is relatively lower, suggesting that the model may have some difficulty in correctly identifying all instances of fraud cases. Again, the prevalence and detection rate is also very low indicating that despite having a high accuracy this is not a good model. 
As this is a highly imbalanced dataset, high accuracy does not mean good model here which checks out with the results of the Confusion Matrix. Thus we have to balance the dataset first for this fraud detection model. 

