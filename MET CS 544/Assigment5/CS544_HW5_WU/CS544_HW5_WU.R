### Hao Wu
### CS 544 Assignment 5

### Part 1) Central Limit Theorem
boston <- read.csv(
  "https://people.bu.edu/kalathur/datasets/bostonCityEarnings.csv",
  colClasses = c("character", "character", "character", "integer", "character"))
head(boston)

##a)
hist(boston$Earnings, xlim = c(40000,400000),breaks= 18)
mean(boston$Earnings)
sd(boston$Earnings)
## Infer: The data is right skewed distribution.

## Question b)
set.seed(948)
samples <- 5000
sample.size <- 10
sampleb <- numeric(samples)
for (i in 1:samples){
  sampleb[i] <- mean(sample(boston$Earnings,sample.size, replace = FALSE))
}
hist(sampleb)
mean(sampleb)
sd(sampleb)

## Question c)
set.seed(948)
samples <- 5000
sample.size <- 40
samplec <- numeric(samples)
for (i in 1:samples){
  samplec[i] <- mean(sample(boston$Earnings,sample.size, replace = FALSE))
}
hist(samplec)
mean(samplec)
sd(samplec)

## Question d)
## Mean = 108680.9 SD = 50474.7
## Mean = 108794.9 SD = 15934.45
## Mean = 108599.6 SD = 7972.063
## The mean of three distribution is almost same;however, when the sample size increase, the sd is decreasing.


### Part 2)Central Limit Theorem – Negative Binomial distribution

## Question a)

set.seed(948)
r <- 3
p <- 0.5
samples <- 5000
xbar <- numeric(samples)
for( i in 1:samples){
  xbar[i] <- rnbinom(samples,size = r, prob = p)
}

par(mfrow = c(1,1))

barplot(prop.table(table(xbar)))
mean(xbar)
sd(xbar)

## Question b)
samples <- 1000
sampled <- numeric(samples)
par(mfrow = c(2,2))
for (size in c(10, 20, 30, 40)){
  for ( i in 1:samples){
    sampled[i] <- mean(sample(xbar,size, replace = FALSE))
  }
  hist(sampled, 
       main = paste("Sample Size =", size),prob = TRUE)
  cat("Sample Size = ", size, " Mean = ", mean(sampled),
      " SD = ", sd(sampled), "\n")
}
par(mfrow = c(1,1))
mean(sampled)
sd(sampled)
## Question c)
# From Question a the mean is 2.98, the sd is 2.44
# From Question b Sample Size =  10  Mean =  2.9806  SD =  0.7954095 
# Sample Size =  20  Mean =  2.96985  SD =  0.5497187 
# Sample Size =  30  Mean =  2.9754  SD =  0.4604782 
# Sample Size =  40  Mean =  2.9838  SD =  0.3765991 
# We infer that mean almost no changed however, when the number of sample decreasing the sd decreasing 
# and when the sample size increasing the sd decreasing.



library(prob)
### Part 3) Sampling
a <- as.data.frame(sort(table(boston$Department),decreasing = TRUE))
b <- a[1:5,1]
c <- subset(boston, boston$Department %in% b  )
rownames(c) <- 1:nrow(c)
head(c)
sample.size <- 50
library(sampling)

## Question a)
set.seed(948)
s <- srswor(70, nrow(c))
sample.1 <- c[s != 0, ]
table(sample.1$Department)

## Question b)
set.seed(948)
N <- nrow(c)
k <- ceiling(N / sample.size)
k
r <- sample(k, 1)
r
s <- seq(r, by = k, length = sample.size)
sample.2 <- c[s, ]

table(sample.2$Department)

## Question c)
set.seed(948)
pik <- inclusionprobabilities(
  c$Earnings, sample.size)
length(pik)
sum(pik)
s <- UPsystematic(pik)
sample.3 <- c[s != 0, ]
table(sample.3$Department)

## Question d)
set.seed(948)
order.index <- order(c$Department)
data <- c[order.index, ]
st <- sampling::strata(data, stratanames = c("Department"),
                       size = c(14,22,8,4,11,5,6) , 
                       method = "srswor")
sample.5 <- getdata(data, st)
table(sample.5$Department)


## Question e)
mean(sample.1$Earnings)
mean(sample.2$Earnings)
mean(sample.3$Earnings)
mean(sample.5$Earnings)
## When we change the meathod the mean of the earning decreasing.

