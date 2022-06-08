################################
### lecture 4 code - CS-555
### Regression
### By: Farshid Alizadeh-Shabdiz
#### 

setwd("/Users/alizadeh/BostonUniversity/CS555_DataAnalysisVisualization/OldLectures/R-Examples-master/Datasets")
getwd()

student <- read.csv("students.csv" , head=TRUE)
student

#study.hours <- student$hours

attach(student)
xbar = mean(hours)
sx = sd(hours)
ybar = mean(score)
sy =  sd(score)

r = cor(hours,score)

beta1 = r*sy/sx
beta1

beta0 = ybar - beta1*xbar 
beta0

m = lm(score ~ hours)
summary(m)

plot(hours , score)
abline(m)

student$id = c(1:31)
m = lm(score ~ hours+student$id)
summary(m)

m = lm(score ~ . , data=student)
summary(m)


##### Example 3
# setwd("SET THE Working Director to THE PATH TO THIS DIRECTORY")
student <- read.csv("students.csv")
student

attach(student)

study.hours<-hours

plot(hours, score, main="Scatterplot of exam score vs. hours of study", xlab="Hours of study", ylab="Score", 
     xlim=c(0,10), ylim=c(40,100), pch=1, col="red", cex.lab=1.5)


#calculate sample correlation
cor(study.hours, score)

cor(score, study.hours)

a <- cor(score, study.hours)
print(a)

my.model <- lm(student$score~student$hours)

# print the linearValues
print(my.model)

# or and use the intercept and score to draw a line 
# abline(51.515, 5.012)

# OR

# or just pass the result values of the lm function to draw a line 
abline(my.model)

# Calculate Confidence Intervals for Model Parameters
confint(my.model)

?confint


# default level is .90
confint(my.model, level = .90)


# report a summary of my model 
summary(my.model)

# create Analysis of Variance Table
anova(my.model)



# fitted values of my model 
fitted(my.model)

# residuals of my model 
resid(my.model)

(sum(fitted(my.model)^2)) / ((sum(resid(my.model)^2)/29))
qf(0.95, df1=1, df2=29)
qf(0.975, df1=1, df2=29)

# plot fitted values 
plot(fitted(my.model), residuals(my.model), axes = T, frame.plot = T, xlab = "fitted values", ylab="residue")


plot(score,  residuals(my.model), axes = T, frame.plot = T)


# histogram of the residuals
hist(residuals(my.model))

++++++
# Something more - not required for the class 
# As an extra task describe what these plots are 
layout(matrix(c(1,2,3,4), 2, 2 ))

plot(my.model)


##### Example 4
# Assume that I have the following data sets for x and y (independent and dependent variables)
x <- c(1, 2, 3, 4, 5)
y <- c(1, 2, 3, 4, 5)

plot(x, y, xlim=c(0,6), ylim=c(0,6))
# let us put a lable on each point
text(x, y+0.4,labels=x)

errorCal <- function(beta0, beta1, x, y){
  
  errorVal <- sum( (y - (beta1 * x + beta0))^2)
  # print(paste("Beta0= ", beta0))
  # print(paste("Beta1= ", beta1))
  # print(errorVal)
  return(errorVal)
}


# Let us assume that we know the beta0 = 0 

# Know we calculate the error value for 200 different beta1 from -100 to 100. 
# Visualize it at the end and you will a see a convex function :) 

errorValues <-c()
beta1Values <-c()
count<-1
for (beta1 in seq(-100, 100, length.out = 300) ){
  beta1Values[count] <- beta1
  errorValues[count] <- errorCal(0, beta1, x , y)
  count <- count + 1
  
}



plot(errorValues)

# create a nice line 
plot(errorValues, type="l")


# text(beta1Values, errorValues+0.4,labels=x)


# We see that the minimum is on zero point. 
min(errorValues)
index<-which(errorValues == min(errorValues))
beta1Values[index]
############# END ####

