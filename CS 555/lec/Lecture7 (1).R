################################
### lecture 7 code - CS-555
### Regression
### By: Farshid Alizadeh-Shabdiz
#### 

setwd("/Users/alizadeh/BostonUniversity/CS555_DataAnalysisVisualization/OldLectures/R-Examples-master/Datasets")
getwd()

### Loading Libraries
library(glmnet) 
library(ISLR)
set.seed(555) # makes the experince repeatable

### Data prep
summary(Hitters)   # Data of baseball players, including Salary which we try to predict here.
sum(is.na(Hitters$Salary))
Hitters = na.omit(Hitters)
with(Hitters, sum(is.na(Salary) ))


###############
### Regularizer - Ridge regression and Lasso
    
# expects predictor matrix and response matrix
x = model.matrix(Hitters$Salary ~.-1, data=Hitters)
y = Hitters$Salary


### Ridge regression
fit.ridge = glmnet(x, y, alpha=0)
#Note: alpha=0 is  Ridge regression
#      alpha=1 is Lasso
#      alpha <1 is Elstic net
plot(fit.ridge, xvar="lambda", label=TRUE)
cv.ridge = cv.glmnet(x, y, alpha=0) # glmnet built in cross validation
plot(cv.ridge)

### Lasso regression
fit.lasso = glmnet(x,y)
plot(fit.lasso, xvar="lambda", label=TRUE)
cv.lasso = cv.glmnet(x, y) # glmnet built in cross validation
plot(cv.lasso)
coef(cv.lasso)

### cross validation
dim(Hitters)
train = sample(1:263 , 180 , replace=FALSE)
# or
train = sample(seq(263) , 180 , replace=FALSE)
train
lasso.tr = glmnet(x[train,], y[train])
lasso.tr
pred = predict(lasso.tr , x[-train,])
dim(pred)
rmse = sqrt(apply((y[-train]-pred)^2, 2, mean))
plot(log(lasso.tr$lambda), rmse, type="b")
lam.best = lasso.tr$lambda[order(rmse)[1]]
lam.best
coef(lasso.tr, s=lam.best)


### Example - Credit card example
library(ISLR)
summary(Credit)

lm(formula = Balance ~ Student + Limit, data = Credit)



##############################
### Example Subset selection
#Subset selection
library(ISLR)
summary(Hitters)   # Data of baseball players, including Salary which we try to predict here.

Hitters = na.omit(Hitters)
with(Hitters, sum(is.na(Salary)))

#Best Subset Regression.
#Using "leaps" library.
library(leaps)
regfit_full = regsubsets(Salary ~ . , data = Hitters) 
summary(regfit_full)
#By default goes to the subset of size 8
#Let us increase that to 19 - all the variables.


regfit_full = regsubsets(Salary ~ . , data = Hitters , nvmax=19) 
reg.summary = summary(regfit_full)
names(reg.summary)          #Get names of the object
plot(reg.summary$cp , xlab="Number of Variables" , ylab = "Cp")
which.min(reg.summary$cp)

plot(regfit_full , scale= "Cp")
coef(regfit_full , 10)


### Forward subset selection
regfit_fwd = regsubsets(Salary ~ . , data = Hitters, nvmax=19, method ="forward") 
summary(regfit_fwd)

reg.summary = summary(regfit_fwd)
names(reg.summary)          #Get names of the object
plot(reg.summary$cp , xlab="Number of Variables" , ylab = "Cp")
which.min(reg.summary$cp)

plot(regfit_fwd , scale = "Cp")

# Cross validation - Model selection using a validation set.
#---------------------------------------
dim(Hitters)
train = sample(seq(263) , 180 , replace=FALSE)
train
regfit.fwd = regsubsets(Salary ~ . , data = Hitters[train,], nvmax=19, method="forward")

val.errors = rep(NA,19)
x.test = model.matrix(Salary~. , data=Hitters[-train,])

# Predict by hand, since there is no predict method.
for (i in 1:19){
  coefi = coef(regfit.fwd , id=i)
  pred = x.test[,names(coefi)] %*% coefi
  val.errors[i] = mean((Hitters$Salary[-train]-pred)^2)
}
plot(sqrt(val.errors) , ylab="RMSE" , ylim=c(300,400) , pch=19 , type="b") # Validation points
points(sqrt(regfit.fwd$rss[-1]/180) , col="blue" , pch=19 , type="b")     # Training points

### Extra - writing predict as a function
# We can also write predict as a function - which needs to know regsubsets class "call" 
predict.regsubsets = function(object , newdata, id, ...){
  form = as.formula(object$call[[2]] )
  mat = model.matrix(form, newdata)
  coefi = coef(object, id=id)
  mat[,names(coef)] %*% coefi
}
### End of Extra


#############################################################
# Cross validation
# 10 fold cross validation

folds = sample(rep(1:10 , length = nrow(Hitters)))
folds
table(folds)

cv.errors = matrix(NA , 10, 19)
for (k in 1:10){
  best.fit = regsubsets(Salary~.,data=Hitters[folds!=k,],nvmax=19,method="forward")
  for (i in 1:19){
    pred = predict(best.fit, Hitters[folds==k], id=i)
    cv.errors[k,i] = mean( (Hitters$Salary[folds==k]-pred)^2)
  }
} 
for (k in 1:10){
  best.fit = regsubsets(Salary~.,data=Hitters[folds!=k,],nvmax=19,method="forward")
  for (i in 1:19){
    coefi = coef(best.fit , id=i)
    x.test = model.matrix(Salary~. , data=Hitters[folds==k,])
    pred = x.test[,names(coefi)] %*% coefi
    cv.errors[k,i] = mean( (Hitters$Salary[folds==k]-pred)^2)
  }
} 

rmse.cv = sqrt(apply(cv.errors,2,mean))
plot(rmse.cv , pch=19, type="b")


### Extra ###

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

