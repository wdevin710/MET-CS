################################
### lecture 8 code - CS-555
### Regression
### By: Farshid Alizadeh-Shabdiz
#### 

# setwd("SET THE Working Director to THE PATH TO THIS DIRECTORY")
setwd("/Users/alizadeh/BostonUniversity/CS555_DataAnalysisVisualization/OldLectures/R-Examples-master/Datasets")
getwd()


#################################
### Example 1 - CEO salaries
data <- read.csv("CEO_salary.csv")
attach(data)

# Divid the Salary by 1000 to be able to better show the values.
salary1 <- salary/1000

# Now we create a New Data frame out of age, heit and Salary
data1 <- data.frame(age, height, salary1)

plot(salary1, age)

plot(salary1, height)

# You can also the following command to replace the column inside the original dataframe.
# data[,"salary"] <- salary1

# Calulate Correlation Coefficient
cor(data1)

# Plot Scatterplot Matrix
pairs(data1)

# Fit a Multiple Linear Regression model into data.
# Variables are Salary and age
lm(formula = salary1 ~ age + height)

# or better store the resulted model into a variable for further use.

m <- lm(salary1~age+height)

# Summar function can calculate almost everything that you need.
summary(m)

# Calulate R squared Manually and the P-Value

# Total Sume of Squared.
totalss <- sum((salary1 - mean(salary1))^2)

# Regression and Residual Sum of the Squered.
regss <- sum((fitted(m) - mean(salary1))^2)
resiss <- sum((salary1-fitted(m))^2)

# Calulate the F Value.
fstatistic <- (regss/2)/(resiss/97)

# The P-Value for F-Statistic.
pvalue <- 1-pf(fstatistic, df1=2, df2=97)

# Calulate R squared.
R2 <- regss/totalss

# Regression Diagnostics
# Residual Plots
resid(m)
par(mfrow=c(2,2))


plot(age, resid(m), axes=TRUE, frame.plot=TRUE, xlab='age', ylab='residue')
plot(height, resid(m), axes=TRUE, frame.plot=TRUE, xlab='height', ylab='residue')

plot(fitted(m), resid(m), axes=TRUE, frame.plot=TRUE, xlab='fitted values', ylab='residue')

hist(resid(m))

confint(m , level=0.99)

# influence function 
# This function provides the basic quantities which are used in forming a wide variety
# of diagnostics for checking the quality of regression fits.
influence(m)
# Checking for influence points 
# Cooks distance
cooks.dist <- cooks.distance(m)
# Where the cook's distance is higher than 4/(n-k-1) (k is the number if parameters in equation)
# 4/(102 - 2 -1) = 4/97
which(cooks.dist > (4/(nrow(data1)-2-1)))


##################
### 3G view of Salary data
# MacOS needs the installation of XQuartz
library(rgl)

plot3d(age, height, salary1, tyope="5", size=0.75, xlab="Age", ylab="Height"
       , zlab="Annual Salary")


### Example 2 - States poverty of 50 states + District of Columbia
# Read the data first
states <- read.csv("https://raw.githubusercontent.com/kiat/R-Examples/master/Datasets/states.csv")

attach(states)

data = data.frame(poverty, metro_res, white, hs_grad, female_house)

## Panel.cor function is a copy from the following web site
# https://www.r-bloggers.com/2011/03/five-ways-to-visualize-your-pairwise-comparisons/
panel.cor <- function(x, y, digits=2, prefix="", cex.cor) 
{
  usr <- par("usr"); on.exit(par(usr)) 
  par(usr = c(0, 1, 0, 1)) 
  r <- abs(cor(x, y)) 
  txt <- format(c(r, 0.123456789), digits=digits)[1] 
  txt <- paste(prefix, txt, sep="") 
  if(missing(cex.cor)) cex <- 0.8/strwidth(txt) 
  
  test <- cor.test(x,y) 
  # borrowed from printCoefmat
  Signif <- symnum(test$p.value, corr = FALSE, na = FALSE, 
                   cutpoints = c(0, 0.001, 0.01, 0.05, 0.1, 1),
                   symbols = c("***", "**", "*", ".", " ")) 
  
  text(0.5, 0.5, txt, cex = cex * r) 
  text(.8, .8, Signif, cex=cex, col=2) 
}


pairs(data ,upper.panel = panel.cor)


# Linear Regression model 
# data <-data.frame(poverty, metro_res, white, hs_grad, female_house)
m <- lm(poverty~female_house+white)

# Summar function can calculate almost everything that you need. 
summary(m)

# Using anova table 
anova_table <-anova(m)
anova_table

SSE <-anova_table$`Sum Sq`[3]
SSE

SST <-anova_table$`Sum Sq`[1]+anova_table$`Sum Sq`[2]+anova_table$`Sum Sq`[3]
SST

R2 <- (anova_table$`Sum Sq`[1]+anova_table$`Sum Sq`[2]) / SST

# adjusted R^2
# adjusted_R2 <-  1 - (SSE/SST )  * (( n - 1 ) / ( n - k - 1) )
# n number of samples
# k number of independent varaibles 

adjusted_R2 <-  1 - (SSE/SST )  * (( length(poverty) - 1 ) / ( length(poverty) - 2 - 1) )


# Second model - Simple Linear Regression Only considering the female_house 
m2 <- lm(poverty~female_house)
anova_table2<-anova(m2)
anova_table2

totalss_anova2 <-anova_table2$`Sum Sq`[1]+anova_table2$`Sum Sq`[2]
totalss_anova2

# Third  model - Simple Linear Regression Only considering the white
m3 <- lm(poverty~white)

summary(m3)
anova_table3<-anova(m3)
anova_table3

totalss_anova3 <-anova_table3$`Sum Sq`[1]+anova_table3$`Sum Sq`[2]
totalss_anova3

