df1 <- read.csv("/Users/haowu/Desktop/Boston University Graduate Study/CS 555/assignment 3/dataset.csv", header = FALSE)
names(df1) <- c("Number_of_meals_with_fish","Total_Mercury_in_mg/g")
scatter.smooth(df1,xlab ="Number_of_meals_with_fish", ylab ="Total_Mercury_in_mg/g")
cor(df1)#
a <- df1[,c(1)]#Number_of_meals_with_fish
b <- df1[,c(2)]#Total_Mercury_in_mg/g
fit <- lm(b ~ a)
fit
summary(fit)
c <-anova(fit)#anova table
write.csv(c, file ="Anova table.csv")