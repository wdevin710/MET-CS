

# Use RStudio Tools->Install Packages to install prob

#### 2.2. Probability - Sample Space


library(prob)


tosscoin(1)

tosscoin(2)

tosscoin(3)

rolldie(1)

rolldie(1, nsides = 4)

#### 2.3. Sampling from an Urn
# Good Resource
# https://www.probabilitycourse.com/chapter2/2_1_0_counting.php

# defaults for replace and ordered are FALSE

# Unordered Sampling without Replacement: Combinations  C(n,k)

urnsamples(1:3, size = 2)

urnsamples(c("r","g","b"), size = 2)

# Ordered Sampling without Replacement: Permutations

urnsamples(1:3, size = 2, 
           replace = FALSE, ordered = TRUE)

urnsamples(c("r","g","b"), size = 2, 
           replace = FALSE, ordered = TRUE)


# Ordered Sampling with Replacement  (n^k)

urnsamples(1:3, size = 2, 
           replace = TRUE, ordered = TRUE)

urnsamples(c("r","g","b"), size = 2,
           replace = TRUE, ordered = TRUE)

# Unordered Sampling with Replacement  C(n+k-1, k) = C(n+k-1, n-1)

urnsamples(1:3, size = 2, 
           replace = TRUE)

urnsamples(c("r","g","b"), size = 2,
           replace = TRUE)


#### 2.4. Counting Tools

# Unordered Sampling without Replacement: Combinations  C(n,k)
nsamp(n = 4, k = 2, replace = FALSE, ordered = FALSE)
urnsamples(1:4, size = 2, replace = FALSE, ordered = FALSE)

# Ordered Sampling without Replacement: Permutations
nsamp(n = 4, k = 2, replace = FALSE, ordered = TRUE)
urnsamples(1:4, size = 2, replace = FALSE, ordered = TRUE)

# Ordered Sampling with Replacement  (n^k)
nsamp(n = 4, k = 2, replace = TRUE, ordered = TRUE)
urnsamples(1:4, size = 2, replace = TRUE, ordered = TRUE)

# Unordered Sampling with Replacement  C(n+k-1, k) = C(n+k-1, n-1)
nsamp(n = 4, k = 2, replace = TRUE, ordered = FALSE)
urnsamples(1:4, size = 2, replace = TRUE, ordered = FALSE)

#### 2.5. Events

S <- tosscoin(3, makespace = TRUE)
S

S[2:4, ]

S[seq(1,8, by = 2), ]

S[c(2,4,6,8), ]

subset(S, toss3 == 'H')

subset(S, toss1 == 'H' & toss3 == 'H')

S <- rolldie(2, makespace = TRUE)
head(S)
tail(S)

nrow(S)

subset(S, X1 == X2)

subset(S, X1 + X2 >= 10)

subset(S, X1 == 5 | X1 == 6)
subset(S, X1 %in% 5:6)

subset(S, X1 %in% 5:6 & X2 %in% c(1,3))


S <- rolldie(3, makespace = TRUE)

nrow(S)

subset(S, isin(S, c(4,5,6), ordered = TRUE))

subset(S, isin(S, c(4,5,6)))

subset(S, isin(S, c(4,6), ordered = TRUE))

S <- cards(makespace = TRUE)

nrow(S)

head(S, n = 2)

subset(S, suit == "Club")
subset(S, suit == "Diamond")
subset(S, suit == "Heart")
subset(S, suit == "Spade")

subset(S, rank %in% 2:4)

subset(S, rank %in% c('K', 'Q'))


S <- cards(makespace = TRUE)
A <- subset(S, suit == "Heart")
B <- subset(S, rank %in% c(10, "Q"))

A

B

union(A, B)

intersect(A, B)

setdiff(A, B)

setdiff(B, A)

setdiff(S, A)

#### 2.6. Setting up the Probability Space

outcomes <- rolldie(1)
outcomes

p <- rep(1/6, times = 6)
p

probspace(outcomes, probs = p)

rolldie(1, makespace = TRUE)

p <- c(0.4, 0.15, 0.15, 0.15, 0.15, 0.2)
probspace(outcomes, probs = p)

#### 2.7. The Prob function

S <- cards(makespace = TRUE)

A <- subset(S, rank == "Q")
A

Prob(A)

Prob(S, rank == "Q")

B <- subset(S, suit == "Heart")
B

Prob(B)

Prob(S, suit == "Heart")


#### 3.2. Conditional Probability Example – Rolling Die Twice

S <- rolldie(2, makespace = TRUE)
head(S, n = 2)
tail(S, n = 2)


A <- subset(S, X1 == X2)
A
Prob(A)


B <- subset(S, X1 + X2 == 8)
B
Prob(B)


Prob(A, given = B)
Prob(B, given = A)


S <- rolldie(2, makespace = TRUE)
Prob(S, X1 == X2, given = (X1 + X2 == 8))
Prob(S, X1 + X2 == 8, given = (X1 == X2))

#### 3.3. Conditional Probability Example – Coin Toss Twice

S <- tosscoin(2, makespace = TRUE)
S


A <- subset(S, isin(S, c('H')))
A


B <- subset(S, isin(S, c('H', 'T')))
B


Prob(A, given = B)
Prob(B, given = A)

#### 3.4. Conditional Probability Example - Card Deck

L <- cards()
head(L, n = 4)


M <- urnsamples(L, size = 2)
head(M, n = 3)


length(M)
choose(52, 2)


S <- probspace(M)
Prob(S, all(rank == "A"))


Prob(S, all(suit == "Club"))

#### 3.5. Conditional Probability Example - Red and Blue balls

L <- rep(c("red", "blue"), times = c(3, 2))
L


M <- urnsamples(L, size = 2, ordered = TRUE)
M


S <- probspace(M)
head(S, n = 2)


Prob(S, isrep(S, "red", 2))
Prob(S, isrep(S, "blue", 2))


Prob(S, isin(S, c("red", "blue"), ordered = TRUE))

#### 3.7. Independent Events Example - Coin Toss

S <- tosscoin(5, makespace = TRUE)
B <- subset(S, isrep(S, "T", 5))
B


Prob(B)
1 - Prob(B)

#### 3.8. Independent Events, Repeated Experiments 

iidspace(c('H', 'T'), ntrials = 3, probs = c(0.6, 0.4))

###
iidspace(c('H', 'T'), ntrials = 3)


#### 3.10. Bayes Rule Example

bayes <- function (prior, likelihood) {
  numerators <- prior * likelihood
  return (numerators / sum(numerators)) 
}

prior <- c(0.07, 0.93)
like <- c(0.9, 0.25)

bayes(prior, like)

  
  
