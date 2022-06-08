
#### 4.4. Reading & Writing Data


x <- scan()


x

x <- scan(sep = ",")

x

x <- scan(what = character())

x

x <- scan(what = logical())

x

x <- scan(what =
            list(age = numeric(), name = character()))

x

# Set the working directory using setwd(...)

dir()

x <- scan("athletedata.txt", what=character())

x

x <- scan("athletedata.txt", skip = 1, 
          what = list(Name = character(), 
                      Salary = numeric(),
                      Endorsements = numeric(), 
                      Sport = character()))

x

as.data.frame(x)



athlete.info <- read.table("athletedata.txt", 
                           header = TRUE)

athlete.info

athlete.info <- read.table("athletedata.txt", 
                           header = TRUE,
                           row.names = c("First", "Second", "Third", 
                                         "Fourth", "Fifth"))

athlete.info

athlete.info <- read.csv("athletedata.csv", 
                         header=TRUE)

athlete.info

athlete.info <- read.table(
  "http://kalathur.com/cs544/data/athletedata.txt", 
  header = TRUE)

athlete.info

athlete.info <- read.csv(
  "http://kalathur.com/cs544/data/athletedata.csv", 
  header = TRUE)

athlete.info

write.table(athlete.info, file="test.txt", 
            row.names = FALSE, quote = FALSE)

write.csv(athlete.info, file="test.csv", 
          row.names = FALSE, quote = FALSE)
