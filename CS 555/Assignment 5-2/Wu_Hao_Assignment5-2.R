library(tidyverse)
library(dplyr)
library(corrplot)
library(MASS)
library(ISLR)
Median <- median(Auto$mpg)
df1 <- Auto%>%
       select( mpg,cylinders,displacement,horsepower,weight,acceleration,year,origin)%>%
mutate(mpg01 =  ifelse(mpg < Median, 0,1) )  
  
corrplot(cor(df1))
pairs(df1)

dt = sort(sample(nrow(df1), nrow(df1)*.8))
train<-df1[dt,]
test<-df1[-dt,]


lm <- glm(mpg01 ~ cylinders+horsepower+weight+year+displacement, data=train, family=binomial)

lm.prob <- predict(lm,test, type ="response")
lm.pred <- rep(0,length(lm.prob))
lm.pred[lm.prob > 0.5] <- 1
table(lm.pred,test$mpg01)
mean(lm.pred == test$mpg01)

#Question 2
df2 <- Weekly
summary(df2)

corrplot(cor(df2[,1:8]))

df2.lm<-glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume, data=df2,family=binomial)
summary(df2.lm)
df2.prob <- predict(df2.lm, type ="response")
df2.pred <- rep("Down", length(df2.prob))
df2.pred[df2.prob > 0.5] <- 'Up'
table(df2.pred, df2$Direction)
mean(df2.pred == df2$Direction)

Week.train <- df2%>%
  filter( Year < 2009)
Week.test <- df2%>%
  filter(Year >2008)
Week.lm <- glm(Direction ~ Lag2 , data = Week.train, family = binomial)
Week.prob <- predict(Week.lm, Week.test, type = "response")
Week.pred <- rep("Down", length(Week.prob))
Week.pred[Week.prob >0.5] = "Up"
table(Week.pred, Week.test$Direction)
mean(Week.pred == Week.test$Direction)

