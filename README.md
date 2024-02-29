# 7.0-Multiple-Regression

Simple vs. Multiple Regression
The most apparent distinction between simple and multiple regression is that for simple regression we are using only one variable to predict Y, whereas with multiple regression we are using more than one variable to predict Y.

![image](https://github.com/Xnrrrrrr/7.0-Multiple-Regression/assets/133546385/7d5350d1-eae5-4a4d-beb0-ee93462c29e3)


Simple Regression: Ŷ = b0 + b1X

Multiple Regression: Ŷ = b0 + b1X1+ b2X2 + bnXn

Due to these differences, the components of the regression equation will remain the same but the calculation for the Y-intercept and slope change.

![image](https://github.com/Xnrrrrrr/7.0-Multiple-Regression/assets/133546385/ca891127-1361-4993-9e7a-cccd7e3fdd67)

 

The calculations for the coefficient of determination (R2) also change.


In addition to changes in how several of our estimates are calculated, having more than one predictor in our model means we’ll need to revise how we run the regression model, interpret the results, and check our assumptions. Each of these will be discussed in turn.

 

Multiple Regression – Demo Data
For this demo we will use the mtcars data set. It is one of many data sets that is automatically loaded into R once you install it. It was taken from the 1974 Motor Trend US magazine and includes fuel consumption (y variable) along with 10 aspects of automobile design and performance (x variables) for 32 automobiles (1973-74 models).

The mtcarsnvn data set that we have loaded here is based on this data. However, the names of the predictors have been relabeled for notational simplicity for running our regression model.

![image](https://github.com/Xnrrrrrr/7.0-Multiple-Regression/assets/133546385/7ea2f924-2e28-427c-8f57-a377d00c66a3)


We’ll focus on the following subset of variables in this demo:

y   - the gas mileage of the vehicle
x1 - the number of cylinders of the engine
x2 - engine displacement
x3 - power of the engine
x4 - vehicle weight
x5 - acceleration performance
 

How to Run and Interpret a Multiple Regression Model in R
Similar to Simple Regression, we will use the lm() function to run our multiple regression model. However, in order to add in additional predictors we’ll use the ‘+’ symbol followed by the name of the next predictor.

newModel = lm(outcome ~ predictor 1 + predictor 2 + predictor n, data = dataFrame, na.action = an action)
 

Below is screenshot of the sample output you would get from running this analysis on the mtcars data set.

![image](https://github.com/Xnrrrrrr/7.0-Multiple-Regression/assets/133546385/38029c27-29f8-46d5-a445-13555bc58598)


 

You would interpret these results like you would in Lesson 7 and report the slope, direction, and significance of each predictor, the percent of variation in Y explained by the model (report both Multiple R2 and Adjusted R2), the statistical significance of the model, the practical significance of the model (sqrt of Multiple R2), and the regression equation.

For Multiple Regression Analysis your Adjusted R2 is more accurate than your Multiple R2. Multiple R2 increases as you add more predictors to your model. You can therefore artificially increase your R2 by just adding more predictors. Your Adjusted R2 is more accurate because it takes into account the number of predictors in the model.

In the model that we’ve run we can see that only one variable (i.e., x5) significantly predicts y. We may want to test alternative models but if we ran all the possible combinations by hand we would have to run about 32 (i.e., 25) regression models. Our goal in regression is to predict the largest amount of variability in Y with the fewest possible predictors (i.e., with the simplest model). There are multiple ways to approach this as highlighted below:

 

Ways to determine which predictors to include in your final model:

Use a logical selection based on an educated guess
-ve: may have multiple variables equally good at predicting Y
Use principal components and factor analysis
-ve: advanced process; beyond the scope of the class
Use stepwise, backward elimination, or forward elimination regression procedures
-ve: enters variables one at a time and may not uncover the best subset of predictors
Use the best-subsets or all-subsets approach
-ve: uses brute force to test all possible models; as the number of predictors increase, the number of subsets increase exponentially
In this class we will use the best-subsets approach. This approach uses brute-force, i.e., it will run regression analyses on every possible combination of predictors in the data. For example, if you had 8 predictors, it would run 256 (i.e., 28) regression analyses and report the ones with the highest Adjusted R2 value or some other parameter that we specify.

Before we run the best-subsets procedure, we will need to install the leaps and car packages in R. We can do this with the following syntax:

install.packages("leaps")
library(leaps)

install.packages("car")
library(car)
 

Once you’ve installed and loaded both packages, we can determine what subset of the five predictors (x1, x2, x3, x4, x5) make the best regression model. We will use the regsubsets() and subsets() functions to do this.

The first command calls the regsubsets() function and stores it in an object that we’ve labelled “bestsubsets”.

The arguments in the function include:

The regression model: y ~ x1 + x2 + x3 + x4 + x5
The data set: data = mtcarsnvn
The number of subsets “nbest” that we’ve requested for each subset size, in this case nbest = 1
 

This is executed in the following syntax:

bestsubsets = regsubsets(y ~ x1 + x2 + x3 + x4 + x5, data = mtcarsnvn, nbest = 1)
 

The second command that we’ll use is the subsets() function. The arguments in this function include:

The object containing the output from the regsubsets() function: “bestsubsets”
The statistic that will be used to pick the best models: “statistic = “adjr2” ”; adjr2 stands for Adjusted R2
 

This is executed in the following syntax:

subsets(bestsubsets, statistic = "adjr2")
 

When this syntax is executed, the result is a plot.

![image](https://github.com/Xnrrrrrr/7.0-Multiple-Regression/assets/133546385/e0777913-eb8e-4793-abb7-de1cc637fd19)


The plot shows that:

The single best one-variable model includes variable x5
The single best two-variable model contains x1 and x5.
The single best three-variable model includes x1, x3, and x5.
The single best four-variable model has x1, x2, x3, and x5.
The single best five-variable model includes x1, x2, x3, x4, and x5.
Note If your variable names are longer than two characters, R may shorten their names when displaying them in the plot. R would also separate each predictor with a dash. Also note that after your Plot is generated you will need to click "Finish" in the top right hand corner of the graphic before running any other syntax in R. 

To determine which of these 5 models include predictors that significantly predict y, you would need to run 5 separate regression models using the lm() function. A summary of the Adjusted R2 from these models and the significance of the predictors is provided in the table below.

![image](https://github.com/Xnrrrrrr/7.0-Multiple-Regression/assets/133546385/378c748c-9441-422e-bf39-9ce9adfeb728)


Model
Regression Model
Adjusted R2
Significant Predictors
1

0.7446	x5
2

0.8185	x1 and x5
3

0.8263	only x5
4

0.8262	only x5
5

0.8227	only x5
Given that our goal is to maximize the prediction of y with the least number of predictors, the Model 2 seems to be the best fit for the data.

Testing Assumptions: Multicollinearity
When running a multiple regression analysis, we will still need to check the same assumptions as Simple Regression. These assumptions are discussed in the previous lesson. An additional assumption that needs to be evaluated in multiple regression is multicollinearity.

Multicollinearity
![image](https://github.com/Xnrrrrrr/7.0-Multiple-Regression/assets/133546385/69d721fc-995d-495b-94c6-dd8159db3e7f)


Multicollinearity exists when there is a strong correlation between two or more predictors in a regression model. Perfect collinearity means that two predictors completely overlap (i.e., R = 1), which is often rare.

 

As collinearity increases three problems arise:

Untrustworthy b coefficients; these values are not representative of the population estimates
Limits the amount of variability explained in Y
Interferes with the ability to assess the importance of each predictor
 

We can evaluate multicollinearity using two approaches:

Run a correlation matrix and examine the correlations among your predictors. Values that are highly correlated (absolute values of .8 or higher) could be a problem.
#Generates a correlation matrix on all the variables in your data set
cor(data)

#Generates a correlation matrix on a subset of variables based on their variable names
cor(data[, c("X1", "X2", "Xn")])

#Generates a correlation matrix on a subset of variables based on their column numbers
cor(data[2:7])

Note: Remember to replace data with the name of your data frame and X1, X2, and Xn with the names of your predictors.

Examine the VIF and tolerance of the predictors
VIF stands for Variance Inflation Factor. It is calculated in several steps.
First, the following regression models are tested:
Model 1: X1 = α0 + α2X2 + αnXn
Model 2: X2 = α0 + α1X1 + αnXn
Model n: Xn = α0 + α1X1 + α2X2

Then the R2 from each of these models are used to calculate the VIF for each predictor using the equation below:
Luckily you won’t need to do this by hand. We’ll use the vif() function in R to calculate our VIF for each predictor. The syntax for this is shown below.
#loads the package needed to run the vif() function
library(car) 

#calculates vif
vif(reg.model) 

#calculates tolerance
1/vif(reg.model) 

You can use the following cutoffs when interpreting the VIF and tolerance:
VIF: values greater than 10 is cause for concern
Tolerance: values lower than 0.2 is a potential problem and lower than 0.1 is a serious problem
