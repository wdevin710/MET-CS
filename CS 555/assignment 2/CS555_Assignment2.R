df1 <- read.csv("/Users/haowu/Desktop/Boston University Graduate Study/CS 555/assignment 2/Calorie.csv", header = FALSE)
typeof(df1)
names(df1) <- c("participants","non_participants")
df2 <- df1[,c(1)]
df3 <- df1[,c(2)]
hist(df2, main="histogram of the participants", xlab = "Children's calories", ylab = "Frequency", border = "black", freq = TRUE)
hist(df3, main="histogram of the non_participants", xlab = "Children's calories", ylab = "Frequency", border = "black", freq = TRUE)
summary(df2)

