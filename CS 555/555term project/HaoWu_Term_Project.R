data <- read.csv("/Users/haowu/Desktop/Boston University Graduate Study/CS 555/term project/kc_house_data.csv")
library(dplyr)
library(tidyverse)
library(corrplot)
library(ISLR)
#randomly select 500 rows obs.
df1 <- sample_n(data, 500)
summary(df1)

#drop id, data and zipcode
col_remove <- c("id","date","zipcode")
df2 <- df1 %>%
  select(- one_of(col_remove))

#get correlation
corrplot(cor(df2))

df3 <- df2[,c("bathrooms","price","grade","sqft_living","sqft_living15")]
pairs(df3)
scatter.smooth(df3$grade, df3$price)
scatter.smooth(df3$sqft_living, df3$price)
scatter.smooth(df3$bathrooms, df3$price)
scatter.smooth(df3$sqft_living15, df3$price)


df3.lm <- lm(price ~ grade+sqft_living+bathrooms+sqft_living15, df3)
summary(df3.lm)
anova_table <-aov(df3.lm)
summary(anova_table)
linearresid1 <- resid(df3.lm)
plot(fitted(df3.lm),linearresid1 )
abline(0,0)




#Grade
grade.lm <- lm(price ~ sqft_living+bathrooms+sqft_living15, df3)
summary(grade.lm)
anova_grade <- aov(grade.lm)
summary(anova_grade)
linearresid2 <- resid(grade.lm)
plot(fitted(grade.lm),linearresid2 )
abline(0,0)

#sqft_living
sqft.lm <- lm(price ~ grade+bathrooms+sqft_living15, df3)
summary(sqft.lm)
anova_sqft <- aov(sqft.lm)
summary(anova_sqft)
linearresid3 <- resid(sqft.lm)
plot(fitted(sqft.lm),linearresid3 )
abline(0,0)

#sqft_living15
sqft15.lm <- lm(price ~ grade+bathrooms+sqft_living, df3)
summary(sqft15.lm)
anova_sqft15 <- aov(sqft15.lm)
summary(anova_sqft15)
linearresid4 <- resid(sqft15.lm)
plot(fitted(sqft15.lm),linearresid4 )
abline(0,0)

#Bathrooms
bath.lm <- lm(price ~ grade+sqft_living15+sqft_living, df3)
summary(bath.lm)
anova_bath <- aov(bath.lm)
summary(anova_bath)
linearresid5 <- resid(bath.lm)
plot(fitted(bath.lm),linearresid5 )
abline(0,0)

