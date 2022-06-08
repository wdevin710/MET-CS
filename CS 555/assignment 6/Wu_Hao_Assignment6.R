df1 <- read.csv("/Users/haowu/Desktop/Boston University Graduate Study/CS 555/assignment 6/Assignment6_dataset.csv")
library(dplyr)
library(tidyr)

df1 <-df1 %>% 
  mutate(temp_level = ifelse(temp >=98.6, 1, 0))

sex_level <- df1%>%
  select(temp_level, sex)
summary(sex_level)
scatter.smooth(sex_level)       
library(fmsb)

df2 <- sex_level %>%
  group_by(sex,temp_level)%>%
  count()

#risk different
rik <- riskdifference(14,35,65,65,conf.level = 0.95)

#logic regression
m <-glm(temp_level ~ sex , data=sex_level , family=binomial)
summary(m)

# Odd ratio
odd_ratio <- exp(m$coefficients[2])# odd ratio
odd_ratio
## using model with sex and temp_level 
library(pROC)
df1$prob <-predict(m, type=c("response"))

#roc curve
# Get the Area under the curve
# c-statistics 
g <- roc(df1$temp_level ~ df1$prob)
g
print(g)

#plot roc curve
roc(df1$temp_level ~ df1$prob, plot=TRUE, legacy.axes=TRUE, percent=TRUE, xlab="False Positive (%)", ylab="True Positive (%)", col="blue", lwd=4)


#multiple logical regression
m1 <-glm(temp_level ~ sex + Heart.rate, data = df1, family = binomial)
summary(m1)

#the odds ratio for sex and heart rate (for a 10 beat increase)
exp(m1$coefficients[3]*10)

#using model with sex and temp_level and heart.rate
df1$prob1 <-predict(m1, type=c("response"))
roc(df1$temp_level ~ df1$prob1, plot=TRUE, legacy.axes=TRUE, percent=TRUE, xlab="False Positive (%)", ylab="True Positive (%)", col="blue", lwd=4)

