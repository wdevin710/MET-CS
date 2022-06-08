df1 <- read.csv("/Users/haowu/Desktop/Boston University Graduate Study/CS 555/assignment 4/dataset.csv",header = TRUE)

#Question 1
summary(df1)
scatter.smooth(df1$Education.Level..years.,df1$Prestige.Score)
cor.test(df1$Education.Level..years.,df1$Prestige.Score)

#Question 2
linearmode <- lm(df1$Prestige.Score ~ df1$Education.Level..years, data = df1)
summary(linearmode)
linearresid <- resid(linearmode)
plot(fitted(linearmode),linearresid )
abline(0,0)

#Question 3
fit <- lm(df1$Prestige.Score ~ df1$Education.Level..years. + df1$Income.... + df1$Percent.of.Workforce.that.are.Women, data = df1)
confint(fit, level = .95)
summary(fit)

#Question 4
fit1 <- lm(df1$Prestige.Score ~ df1$Income...., data = df1)
fit2 <- lm(df1$Prestige.Score ~ df1$Percent.of.Workforce.that.are.Women, data = df1)
anova_table1 <-anova(fit1)
anova_table2 <-anova(fit2)
anova_table1
anova_table2
summary(fit1)
summary(fit2)
linearresid2 <- resid(fit1)
plot(fitted(fit1),linearresid2 )
abline(0,0)
linearresid3 <- resid(fit2)
plot(fitted(fit2),linearresid3 )
abline(0,0)
confint(fit1, level = .95)
confint(fit2, level = .95)

#Question 5
linearresid_1 <- resid(fit1)
plot(fitted(fit1),linearresid_1 )
abline(0,0)
linearresid_2 <- resid(fit2)
plot(fitted(fit2),linearresid_2 )
abline(0,0)



