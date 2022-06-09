##Part 2
library(prob)
dice <- rolldie(3,6)
dice
##Question a
dicetotal <- rowSums(dice[c("X1","X2","X3")])
dicetotal
##Calculate each roll probability
dice$probs <- round(1/nrow(dice),digits = 5)

dice6to10 <- dice[dicetotal > 6 & dicetotal <10,]
dice6to10
Q1 <- colSums(dice6to10[4])
Q1

##Question b


## Get the index of all the three rolls are identical
threerolls_index <- dice$X1 == dice$X2 & dice$X2 == dice$X3

## Get the rows of all the three rolls are identical
threerolls <- dice[threerolls_index == "TRUE",]
threerolls

## Sum the probability
Q2 <- colSums(threerolls[4])
Q2



##Question c
##Get the index of only two rolls are identical and the answer need except the three rolls identical
tworolls_index <- (dice$X1 == dice$X2 | dice$X1 == dice$X3 |dice$X2 == dice$X3) &(!threerolls_index)
tworolls <- dice[tworolls_index == "TRUE",]
tworolls
Q3 <- colSums(tworolls[4])
Q3

##Question d
norolls_index <- dice$X1 != dice$X2 & dice$X2 != dice$X3 & dice$X1 != dice$X3
norolls <- dice[norolls_index == "TRUE",]
norolls
Q4 <- colSums(norolls[4])
Q4

##Question e
dice2total <- rowSums(tworolls[c("X1","X2","X3")])
dice2total
dice2 <- tworolls[dice2total > 6 & dice2total < 10,]
dice2
Q5 <- colSums(dice2[4])
Q5


##Part 3
##Question a
sum_of_first_N_even_squares <- function(n) {
  sum = 0 ## set a value sum as a initial value
  for (i in seq(2, by = 2, len = n)){
    sum = sum + i*i  ## take each of number in the sequence to square, then accumulative it to sum int.
    
  }
  return(sum) ## return our result
}
sum_of_first_N_even_squares(2)
sum_of_first_N_even_squares(5)
sum_of_first_N_even_squares(10)


##Question b
sum_of_first_N_even_squares_V2 <- function(n) {
  vec = seq(2, by = 2, len = n) ##Get the sequence
  sum = sum(vec^2) ## Get the sum of square of the sequence
  return(sum) ## Return the result
}
sum_of_first_N_even_squares_V2(2)
sum_of_first_N_even_squares_V2(5)
sum_of_first_N_even_squares_V2(10)

##Part 4
tsla <- read.csv("https://people.bu.edu/kalathur/datasets/TSLA.csv")
head(tsla)
##Question a

sm <- summary(tsla[5])
sm
which(tsla[5] == min(tsla[5]))
##Question b
n <- which(tsla[5] == min(tsla[5]))
n ## n is the index of which row is minimum
for( i in n){ ## for loop to print out each sentence
    cat("The minimum Tesla value of",min(tsla[5]), "is at row", i,"on", tsla[i,1],"\n")
}

##Question c
d <-which(tsla[5] == max(tsla[5]))
for( i in d){ ## for loop to print out each sentence
  cat("The maximum Tesla value of",max(tsla[5]), "is at row", i,"on", tsla[i,1],"\n")
}

##Question d
closehigh <- tsla[tsla[2]<tsla[5],] ##get the row which close price greater than open price
probd <- nrow(closehigh)/nrow(tsla) ## get the probability
probd

##Question e
vol <- tsla[tsla[6]>20000000,] ## Take the row which volumn is greater than 20 millions
probv <- nrow(vol)/nrow(tsla) ## get the probability
probv

##Question f
f <- closehigh[closehigh[6]>20000000,]## From the perious data frame which we create for the close price greater than open price
probf <- nrow(f)/nrow(tsla)
probf

##Question g
totalhold <- colSums(tsla["Open"]) ## Accumulate the price which on the open column
totalhold
netgain <-  (tsla[nrow(tsla),5]*nrow(tsla)) - totalhold  ##Use the last day close price multiple the day then minus the total price
netgain

##Question h
totallow <- colSums(tsla["Low"])
totallow
netgainlow <-(tsla[nrow(tsla),5]*nrow(tsla)) - totallow
netgainlow

##Question i
totalhigh <- colSums(tsla["High"])
totalhigh
netgainhigh <- (tsla[nrow(tsla),5]*nrow(tsla)) - totalhigh
netgainhigh








