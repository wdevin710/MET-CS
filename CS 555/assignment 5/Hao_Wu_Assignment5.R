library(dplyr)
df1 <- read.csv("/Users/haowu/Desktop/Boston University Graduate Study/CS 555/assignment 5/dataset.csv",header = TRUE)
df1 <- df1[-c(46), ]
#Question 1
aggregate(df1$iq, by=list(df1$group), summary)
aggregate(df1$age, by=list(df1$group), summary)
plot(df1$age,df1$iq)

#Question 2
pairwise.t.test(df1$iq, df1$group, p.adj="none")
pairwise.t.test(df1$iq, df1$group, p.adj="bonferroni")

df1.lm <- lm(iq ~ group, data = df1)
anova <- aov(df1.lm)
summary(anova)
TukeyHSD(anova)

#Question 3
df2 <- df1
df2$group <- ifelse(df1$group == 'Chemistry student', 1, 0)

is.factor(df2$group)
df2$group = factor(df2$group)
is.factor(df2$group)

df2.lm <- lm(iq ~ group, data = df2)
anova2 <- aov(df2.lm)
summary(anova2)
TukeyHSD(anova2)


#Question 4
df3.lm <- lm(iq ~ group+age, data = df1)
anova3 <- aov(df3.lm)
summary(anova3)
TukeyHSD(anova3)




