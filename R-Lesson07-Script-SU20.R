#Step 1: Load the csv file "cyber_attack-v2" in R using read.csv () function.

cyberData <- read.csv("cyber-attack-v2.csv", header=TRUE)

#Step 2: Run a regression analysis using the lm() function.

cyberAttacks <- lm(num_attack ~response_time + cyber_literate_users + num_device, data=cyberData)
#where num_acctack is the outcome variable; respose_time, cyber_literate_users, and num_device are predictors.

#Step 3: Use summary() function to generate output of the regression analysis.

summary(cyberAttacks)

# Step 4: We will use the best-subsets approach in this class to identify the model (among all possible models) that predicts the largest amount of variability in Y with the fewest possible predictors (i.e., with the simplest model).
         # Before we run the best-subsets procedure, we will need to install the leaps and car packages in R. We can do this with the following syntax:

install.packages("leaps")
library(leaps)

install.packages("car")
library(car)

# Step 5: Once you’ve installed and loaded both packages, we can determine what subset of the three predictors (x1, x2, x3) makes the best regression model. 
        # We will use the regsubsets() and subsets() functions to do this.

bestSubsets <- regsubsets(num_attack ~response_time + cyber_literate_users + num_device, data=cyberData, nbest=1)

        #where response_time, cyber_literate_users, num_device are predictors; cyberData is the dataframe; nbest is the # of best model for each number of predictors that is set to 1.
        # regsubset () function is used to run all possible regression analyses based on the requested subset size, which is 1 in this case.
summary(bestSubsets)

subsets(bestSubsets, statistic="adjr2")
        #where bestSubset is the object we created to store the all possible regression analysis results.
        # 'statistic' is used to tell R what statistic is used to determine the best subset.

# Step 6: Review the graph (Statistics:adjr2 vs Subset size) and determine the single best models for one, two, and three variables.
        #To determine which of these 3 models include predictors that significantly predict y, you would need to run 3 separate regression models using the lm() function.
        
        # Model 1: 
          model1Reg <- lm (num_attack~num_device, data=cyberData)
          summary (model1Reg)
        # Model 2:
          model2Reg <- lm (num_attack ~ response_time + num_device, data=cyberData)
          summary (model2Reg)
        # Model 3
          model3Reg <- lm (num_attack ~ response_time + cyber_literate_users + num_device, data=cyberData)
          summary (model3Reg)
          
  
# Step 7: Now check the assumption of multicollinearity
          
          #Generates a correlation matrix on all the variables in your data set
          cor(cyberData)
          
          #Generates a correlation matrix on a subset of variables based on their variable names
          cor(cyberData[, c("response_time", "num_device", "cyber_literate_users")])
          
# Step 8: Evaluate multicollinearity by examining the VIF and tolerance of the predictors
          
          #loads the package needed to run the vif() function
          library(car) 
          
          #calculates vif
          vifModel3 <- vif(model3Reg) 
          summary(vifModel3)
          
          #calculates tolerance
          toleranceModel3 <- 1/vifModel3
          summary(toleranceModel3)
          
      
