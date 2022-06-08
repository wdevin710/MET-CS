## CS 544 Module 3 Assignment
## Hao Wu
## Part 1)
df <- read.csv("http://people.bu.edu/kalathur/datasets/myPrimes.csv")
##Question a
table(df$LastDigit)
barplot(table(df$LastDigit), 
        col = "black",
        xlab = "Type", ylab = "Frequency")

##Question b
table(df$FirstDigit)
barplot(table(df$FirstDigit), 
        col = "black",
        xlab = "Type", ylab = "Frequency")

##Question c

##Plot a 1): The prime number almost exist when the Last Digit is odd. 
##       2): In the case where the prime number is less than 10000, the Last digit is 1, 3, 7, 
##           and 9 have similar probabilities of being prime numbers
##Plot b 1): As the first digit increases gradually, the probability that the 
##           number is the prime number decreases.
##       2): The change of the first digit has little effect on whether 
##           the number is prime or not, almost negligible.

## Part 2)
us_quarters <- read.csv("http://people.bu.edu/kalathur/datasets/us_quarters.csv")
##Question a
Denver_max_State <- us_quarters[which.max(us_quarters$DenverMint),1]
Denver_max_State

Philly_max_State <-  us_quarters[which.max(us_quarters$PhillyMint),1]
Philly_max_State

Denver_min_State <- us_quarters[which.min(us_quarters$DenverMint),1]
Denver_min_State
Philly_min_State <- us_quarters[which.min(us_quarters$PhillyMint),1]
Philly_min_State

##Question b
TotalCoin <- (sum(us_quarters$DenverMint) + sum(us_quarters$PhillyMint))/4
TotalCoin

##Question c   
a <- cbind(us_quarters$DenverMint,us_quarters$PhillyMint)  
barplot(a ~ us_quarters$State,
        col = c("blue","grey"),
        legend = c("DenverMint","PhillyMint"),beside = TRUE)
##Inference 1) Mint gaps in some states are very large, and there may be outliers when we analyze。
##Inference 2) Except for very few states, when one kind of mint is abundant, another kind of mint is also abundant.


##Question d
colnames(a) <- c("DenverMint","PhillyMint")
plot(a)
##Inference 1) The data has many outliers.
##Inference 2) There is a positive relationship.

##Question c
boxplot(a)
##Inference 1) PhillyMint's outlier is more than DenverMint's outlier
##Inference 2) Both distribution is skewed.

##Question d
Denver <- fivenum(us_quarters$DenverMint)
us_quarters$State[which(us_quarters$DenverMint < (Denver[2] - 1.5*(Denver[4] - Denver[2])) | 
                        us_quarters$DenverMint > (Denver[4] + 1.5*(Denver[4] - Denver[2])))]
Philly <- fivenum(us_quarters$PhillyMint)
us_quarters$State[which(us_quarters$PhillyMint < (Philly[2] - 1.5*(Philly[4] - Philly[2])) | 
                          us_quarters$PhillyMint > (Philly[4] + 1.5*(Philly[4] - Philly[2])))]


##Part 3)
stocks <- read.csv("http://people.bu.edu/kalathur/datasets/stocks.csv")
head(stocks)
##Question a
pairs(stocks[,2:7])

##Question b
round(cor(stocks[,2:7]),2)

##Question c
summary(stocks)
apply(round(cor(stocks[,2:7]),2),2,mean)
## 1) Stock MSFT have a higher correlation with other stock
## 2) Stock GOOG have the biggest range, Stock AAPL have the smallest range
## 3) Stock TSLA have a lower correlation with other stock
## 4) TSLA Stock have a correaltion with FB which is closer to zero

##Question d
cm <- round(cor(stocks[,2:7]),2)
cm
for(i in 1:ncol(cm)){
  Top3 <- as.matrix(head(sort(cm[i,-i],decreasing = TRUE),n=3))
  ##Use sort method get only one row for each stock, but without the target stock
  ##Use head method to get Largest 3 correlation and store it in Top variable
  cat("Top 3 for Stock",colnames(cm)[i],  "\n",rownames(Top3),"\n",Top3[,1],"\n")
}

##Part 4)
scores <- read.csv("http://people.bu.edu/kalathur/datasets/scores.csv")
head(scores)
##Question 1
hist(scores$Score,breaks = 8)
hist_score <- hist(scores$Score,breaks = 8)
hist_score
for(i in 1:length(hist_score$counts)){
  cat(hist_score$counts[i],"students in range","(",hist_score$breaks[i],",",hist_score$breaks[i+1],"]","\n")
}

##Question 2
hist(scores$Score,breaks =c(30,50,70,90))
hist2 <- hist(scores$Score,breaks =c(30,50,70,90))
for(i in 1:length(hist2$counts)) {
  Grade <- c("C","B","A")
  cat(hist2$counts[i],"students in",Grade[i]," range","(",hist2$breaks[i],",",hist2$breaks[i+1],"]","\n")
}

