# Credit-Card-Fraud-Detection

Confusion Matrix:
True Positive (Fraud): 112
False Negative (Normal predicted as Fraud): 7
False Positive (Fraud predicted as Normal): 35
True Negative (Normal): 85,287

Accuracy:
Accuracy measures the overall correctness of the model's predictions.
The overall accuracy of the model is 0.9995, indicating that it correctly predicts 99.95% of the instances.

No Information Rate: 
The no information rate represents the accuracy achieved by a naive model that always predicts the most prevalent class.
The proportion of the majority class (Normal) is 0.9983.

Kappa:
Kappa is a statistic that measures the agreement between the predicted and actual classes,
considering the agreement that could be expected by chance alone. 
In this case, the Kappa value is 0.8419, which indicates a substantial level of agreement beyond what would be expected by chance.

Sensitivity, Specificity, Positive Predictive Value, Negative Predictive Value:
These measure the model's performance in terms of correctly identifying positive and negative instances.

Sensitivity:
Sensitivity, also known as recall or true positive rate, measures the proportion of actual positive instances (Fraud) correctly identified by the model.
Here the sensitivity is 0.7619, indicating that the model correctly identifies 76.19% of the actual fraud cases.

Specificity:
Specificity measures the proportion of actual negative instances (Normal) correctly identified by the model.
A specificity of 0.9999 indicates a high level of accuracy in identifying normal instances.

Prevalence, Detection Rate:
Prevalence represents the proportion of positive instances (Fraud) in the dataset. 
Here the prevalence is 0.0017 or 0.17%.
The detection rate measures the proportion of actual positive instances (Fraud) that are correctly identified by the model.
In this case, the detection rate is 0.0013 or 0.13%.

Balanced Accuracy:
Balanced accuracy takes into account the performance on both positive and negative classes and provides an overall measure of model accuracy.
A balanced accuracy of 0.8809 indicates a good performance in predicting both fraud and normal instances.

Based on these results, the model appears to have a high overall accuracy and performs well in identifying normal instances.
However, the sensitivity for fraud cases is relatively lower, suggesting that the model may have some difficulty in correctly identifying all instances of fraud cases.
Again, the prevalence and detection rate is also very low indicating that despite having a high accuracy this is not a good model.
Further analysis and evaluation may be necessary to improve the model's performance for fraud detection.
