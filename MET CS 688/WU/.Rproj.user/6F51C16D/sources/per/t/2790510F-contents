## Functions in R


# a function with no arguments

sayHello <- function () {
  return("Hello ... Welcome to R!")
}

# Invoking the function

sayHello()

# Storing the result of the function

result <- sayHello()
result

# a function with one argument

mySquare <- function (x) {
  return(x*x)
}

# Invoking the function

mySquare(5)
paste("Square of 5 is", mySquare(5))

# Storing the result

y <- mySquare(5)
y
paste("Square of 5 is", y)

# nest function invocations

mySquare(mySquare(5))

# a function with two arguments

hypotenuse <- function (x, y) {
  z_squared <- (x*x + y*y)
  return (sqrt(z_squared))
}

# Invoking the function

hypotenuse(3, 4)
paste("Hypotenuse of right triangle with sides 3 and 4 is", 
      hypotenuse(3, 4))

# Simplify the function with fewer lines

hypotenuse <- function (x, y) {
  return (sqrt(x*x + y*y))
}

hypotenuse(3, 4)
paste("Hypotenuse of right triangle with sides 3 and 4 is", 
      hypotenuse(3, 4))

# Storing the result

z <- hypotenuse(3, 4)
z
paste("Hypotenuse of right triangle with sides 3 and 4 is", z)


# nest function invocations

hypotenuse(hypotenuse(3, 4), 12)

# function with vector input

sumOfOnlyPositive <- function (x) {
  return (sum(x[x > 0]))
}

temps <- c(10, -20, 20, -10)
sum(temps)

sumOfOnlyPositive(temps)

sumOfOnlyPositive(c(10, -20, 20, -10))

sumOfAbsolute <- function (x) {
  return(sum(abs(x)))
}

sumOfAbsolute(c(10, -20, 20, -10))

abs(temps)

# Boolean functions

isPositive <- function (x) {
  return (x > 0)
}

isPositive(10)

isPositive(-10)

isPositive(c(10, -10))

# If one result is needed

allPositive <- function (x) {
  return(all(x > 0))
}

allPositive(c(10, 20, 30))

allPositive(c(10, -10, 20))

#

isTeenager <- function (x) {
  return (x >= 13 & x <= 19)
}

isTeenager(15)

isTeenager(20)

#### 5.1. Functions (From Lecture)

inc.1 <- function (x) {
  return (x + 1)
}

inc.1 <- function (x) {
  x + 1
}

inc.1(10)
inc.1(x = 10)

inc.1(c(10,20,30))
inc.1(10:20)


# x - y used below on purpose
inc.2 <- function (x, y) {
  return (x - y)
}

inc.2(10, 20)
inc.2(x = 10, y = 20)
inc.2(y = 20, x = 10)
inc.2(10, y = 20)
inc.2(y = 20, 10)
inc.2(10)

# optional arguments
inc.3 <- function (x, y = 100) {
  return (x + y)
}

inc.3(10)
inc.3(10, 20)

inc.4 <- function (x = 5, y = 7) {
  return (x + y)
}

inc.4()
inc.4(2)
inc.4(2, 3)
inc.4(y = 3)



#### 5.3. Control Structures

x <- c(10, 15)
y <- c(20, 5)

if (x < y) {
  my.max <- y
  my.min <- x
} else {
  my.max <- x
  my.min <- y
}

my.max
my.min

my.max <- if (x < y) y else x

my.max

my.max <- ifelse(x < y, y, x)
my.max

# as a function returning two value max, min

my.maxmin <- function (x, y) {
  if (x < y) {
    return (c(y, x))
  } else {
    return (c(x, y))
  }
}

my.maxmin(100, 200)
my.maxmin(100, 20)

## Loops - for statement

x <- c(10, 20, 30, 40, 50)

for (i in x) {
  cat("Square of ", i, " = ", i*i, "\n")
}

i

# Squares of first n numbers

n <- 10

for (i in 1:n) {
  cat("Square of ", i, " = ", i*i, "\n")
}

# Squares of odd numbers upto n

n <- 10

for (i in seq(1,n, by = 2)) {
  cat("Square of ", i, " = ", i*i, "\n")
}

# Write your own version of max

my.max <- function (x) {
  result <- -Inf
  for (number in x) {
    if (number > result) {
      result <- number
    }
  }
  return (result)
}

my.max(c(100, 50, 200, 80))

# Test with R max function

max(c(100, 50, 200, 80))


# Loops - while statement

# Sum of first n numbers

n <- 10
sum <- 0
i <- 1

while (i <= n) {
  sum <- sum + i
  i <- i+1
}
cat("Sum of first ", n, " numbers = ", sum)

# Sum of first x numbers not to exceed given limit

limit <- 550
sum <- 0
i <- 0

while (TRUE) {
  i <- i+1
  sum <- sum + i
  if (sum >= limit) break
}

if (sum > limit) {
  sum <- sum - i
  i <- i-1
}

cat("Sum of first ", i, " numbers = ", sum)

# Loops - repeat statement

# Squares of odd numbers upto n

n <- 10
i <- 1
repeat {
  cat("Square of ", i, " = ", i*i, "\n")
  i <- i+2
  if (i > n) break
}


## More examples of functions

my.reverse <- function (x) {
  return (x[length(x):1])
}


my.reverse(c(10, 50, 100))

my.reverse(20:30)

# if return is missing, last statement in the function returns the value

my.reverse <- function (x) {
  x[length(x):1]
}

my.reverse(c(10, 50, 100))

my.reverse(20:30)

#

my.factorial <- function (n) {
  if (n <= 0) {
    return (1)
  } else {
    return (n * my.factorial(n-1))
  }
}

my.factorial(5)

