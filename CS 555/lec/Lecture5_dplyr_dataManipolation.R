#####################
### Lecture Data Manipulation with R
###

# Package “dplyr” in R focussed on tools for working with data frames
# 􏰀 dplyr provides abstractions for basic data manipulation operations (called verbs)
# 􏰀 Verbs can be combined to achieve complicated data manipulation results 
# using a series of simple data processing steps (by building a data manipulation pipeline)
# 􏰀 The approach is familiar to those who use UNIX/Linux and the ”dotadiw” philosophy: 
# Do One Thing and Do It Well

# The verbs are:
# 􏰀 filter
# 􏰀 arrange
# 􏰀 select
# 􏰀 distinct
# 􏰀 mutate
# 􏰀 summarise


#Data sets and R Code is available
#https://github.com/kiat/R-Examples
setwd("/Users/alizadeh/BostonUniversity/CS555_DataAnalysisVisualization/OldLectures/R-Examples-master/Datasets")


# install.packages("tidyverse")
library(tidyverse)  # Tidyverse is a collection of data science packages, 
                    # including dplyr 
#install.pacakges('dplyr')
#library(dplyr)

#library(dbplyr) # for connecting to SQL database and translating dplyr to SQL query

delay.dat.houston <- read.csv("./airline/HoustonAirline.csv",
                              header=TRUE,
                              stringsAsFactors = FALSE)
# tbl_df allows for nice printing
delay.dat.houston <- tbl_df(delay.dat.houston)

delay.dat.houston

airport.dat  <- read.csv("./airline/airports.csv",
                              header=TRUE,
                              stringsAsFactors = FALSE)
summary(airport.dat)
tail(airport.dat)


# filter is probably the most familiar verb
# 􏰀 filter is dplyr’s version of R’s subset() function
# 􏰀 filter returns all rows (observations) for which a logical condition holds


# Inputs: data.frame and logical expressions
# 􏰀 Output: data.frame
# 􏰀 All dplyr verbs behave similarly
# 􏰀 A data.frame is inputted, and a data.frame is outputted


# Find all flight which occurred in Janurary
filter(delay.dat.houston, Month==1)

# Using airport data, find a list of iata abbreviations for houston
filter(airport.dat, state=='TX', city=='Houston')


# Package “dplyr” in R focussed on tools for working with data frames
# 􏰀 Find the subset of flight departing from Hobby Airport “HOU” for which the 
#   Actual Elapsed Time was greater than the CRS Elapsed Time 
#  (ActualElapsedTime > CRSElapsedTime)
# 􏰀 Find the subset of flights departing on the weekend

# Find the subset of flight departing from
# Hobby Airport "HOU" for which the Actual
# Elapsed Time was greater than the CRS Elapsed Time.
filter(delay.dat.houston,
         Origin == 'HOU', # iata code for Hobby
         ActualElapsedTime > CRSElapsedTime)

# Find the subset of flights departing on the weekend.
filter(delay.dat.houston, DayOfWeek == 6 | DayOfWeek == 7)
# another alternative
filter(delay.dat.houston,  DayOfWeek %in% c(6,7))


# arrange, like filter, operates on data.frame rows
# 􏰀 arrange is used for sorting data.frame rows w.r.t. a given column(s)
arrange(delay.dat.houston, DayofMonth)

arrange(delay.dat.houston, desc(Month), desc(DayofMonth))

arrange(delay.dat.houston, desc(Month), desc(DayofMonth))


# select is like filter but for columns
# 􏰀 select is used for keeping/dropping a subset of variables/columns
select(delay.dat.houston, Year, Month, DayofMonth)
select(delay.dat.houston,Year:DayofMonth)
select(delay.dat.houston,-(Year:DayofMonth))

select(delay.dat.houston, contains('Dep'))

# Create a select statement using 
# 􏰀 one of helper
# 􏰀 ends with helper

select(delay.dat.houston,
       one_of('UniqueCarrier',
         'FlightNum'
         ))
select(delay.dat.houston,
       ends_with('Time'))


# distinct finds unique values of a variable
# 􏰀 distinctreturnsthefirstobservation/rowcontainingeachvalue
distinct(delay.dat.houston, Month)

distinct(delay.dat.houston, Month,.keep_all=TRUE)

distinct(delay.dat.houston, Month,DayOfWeek)

# You can combine distinct with the select verb from previous. 

# What do you think the following will do?
select(
  distinct(
    arrange(
      filter(delay.dat.houston,DayOfWeek==6),
      desc(ActualElapsedTime)),
    UniqueCarrier,.keep_all = TRUE),
  UniqueCarrier,ActualElapsedTime)


### Piping   %>%

athlete.info <- tribble(
  ~Name,       ~Salary, ~Endorsements, ~Sport,
  "Mayweather",  105,      0,             "Boxing",
  "Ronaldo",      52,     28,             "Soccer",
  "James",      19.3,     53,             "Basketball",
  "Messi",      41.7,     23,             "Soccer",
  "Bryant",     30.5,     31,             "Basketball",
  "Bryan",      120,     31,             "Soccer"
)

athlete.info

# glimpse
glimpse(athlete.info)
# Pipe - provides the first argument of the function
summary(athlete.info)
athlete.info %>% summary
athlete.info %>% head() %>% summary
athlete.info %>% head(10) %>% summary


# Reading from the inside out we can see it:
#   􏰀 Only considers flights departing on Saturday
# 􏰀 Arranges these by ActucalElapsedTime in decrease order
# 􏰀 Selects the first row for each carrier
# 􏰀 In total this gives the largest ActualElapsedTime for Saturday departing flights for each carrier.
# 􏰀 distinctreturnsthefirstobservation/rowcontainingeachvalue

# We can do the previous example with the chaining
delay.dat.houston %>%
  filter(DayOfWeek == 6) %>%
  arrange(desc(ActualElapsedTime)) %>%
  distinct(UniqueCarrier,.keep_all=TRUE) %>%
  select(UniqueCarrier,ActualElapsedTime)


# Chain together the verbs we’ve seen so far to:
#   􏰀 Find a list of Origin Airports
# 􏰀 Find a list of (Origin,Destination) pairs
# 􏰀 Find the Origin airport which had the largest departure delay in the month of January
# 􏰀 Find the largest departure delay for each carrier for each month

# Find a list of the distinct Origin airports
delay.dat.houston %>%
  distinct(Origin)
# Find a list of distinct (Origin, Dest) pairs
delay.dat.houston %>%
  distinct(Origin, Dest)
# Origin airport with largest Janurary departure delay
delay.dat.houston %>%
  filter(Month==1) %>%
  arrange(desc(DepDelay)) %>%
  select(Month,Origin, DepDelay) %>%
  distinct(Origin,.keep_all = TRUE)

# largest departure delay for each carrier for each month
delay.dat.houston %>%
  arrange(Month,desc(DepDelay)) %>%
  select(Month,UniqueCarrier,DepDelay) %>%
  distinct(Month,UniqueCarrier,.keep_all=TRUE)

# Two verbs: mutate and summarise
# 􏰀 mutate allows us to create new variables
# summarise:
#   􏰀 summarise let’s us compute summary statistics on groups of data
# 􏰀 summarise is used in conjunction with the group by verb

# Basic example with no grouping
delay.dat.houston %>%
  summarise(MeanDistance = mean(Distance,na.rm=TRUE))

# With grouping
# n() is dplyr function counts # obs in each group
  delay.dat.houston %>% 
  group_by(UniqueCarrier) %>% 
  summarise(
    MeanDistance=mean(Distance,na.rm=TRUE), 
    NFlights = n())

# We could also redo our previous example, finding the largest
# departure delay for each carrier for each month
delay.dat.houston %>%
   group_by(Month, UniqueCarrier) %>%
   summarise(MaxDepDelay = max(DepDelay,na.rm=TRUE)) %>%
   head(5)


### ggplot2
# For each carrier plot the average Departure delay for each month.
# 􏰀 Do you notice anything strange? What might be the cause?
# 􏰀 Hint: Use summarise and faceting
# 􏰀 Hint: For each carrier also plot the number of flights per month.

library(ggplot2)
tmp <-  delay.dat.houston %>%
  group_by(Month,UniqueCarrier) %>%
  summarise(
    Dep = mean(DepDelay,na.rm=TRUE)
  )
qplot(Month,Dep,data=tmp) +
  geom_line() +
  facet_wrap(~UniqueCarrier)

#What could cause this? Try this:
  delay.dat.houston %>%
  group_by(Month,UniqueCarrier) %>%
  summarise(
    NFlights = n()
  ) -> tmp
qplot(Month,NFlights,data=tmp) +
  geom_line() +
  facet_wrap(~UniqueCarrier,scale='free_y')


# Find the percent of flights cancelled for each carrier.
# 􏰀 Use summarise to get total number of flights for each carrier
# (UniqueCarrier) and the total number of cancelled flights
# 􏰀 Create a new variable PercentCancelled based on the results above
# 􏰀 Return a data.frame with only UniqueCarrier and PercentCancelled

delay.dat.houston %>%
  group_by(UniqueCarrier) %>%
  summarise(
    NFlights = n(),
    NCancelled = sum(Cancelled)) %>%
  mutate(
    PercentCancelled = (NCancelled/NFlights)*100) %>%
  select(UniqueCarrier,
         PercentCancelled)

# For each Destination find the average Arrival and Departure delay; create associated variables AvgArrDel, AvgDepDel
# 􏰀 Plot AvgArrDel vs AvgDepDel for the three largest carriers (largest in terms of number of flights)
# 􏰀 Plot AvgArrDel vs AvgDepDel for all carriers. Use point size to indicate carrier size
delay.dat.houston %>%
  group_by(UniqueCarrier) %>%
  summarise(
    Dep = mean(DepDelay,na.rm=TRUE),
    Arr = mean(ArrDelay,na.rm=TRUE),
    NFlights = n()
  ) %>%
  select(Dep,Arr,NFlights) -> tmp
qplot(Dep,
      Arr,
      data=tmp,
      size=log(NFlights))+
  geom_abline(intercept=0,slope=1,color='red')

# For our final dplyr stop we’ll look at it’s merging capabilities. 
#Let’s start by reading in some more toy datasets
people.info <- read.table('./mergedata/PeopleInfo.csv',
                          sep=',',
                          header=TRUE)
occup.info <- read.table('./mergedata/OccupationInfo.csv',
                 sep=',',
                 header=TRUE)
people.info
occup.info

# Basic JOIN
# inner_join
# left_join
# right_join
# dplyr’s basic merging functions are:
# 􏰀 inner join : return all rows from x where there are matching values in y, 
#  and all columns from x and y. If there are multiple matches between x and y, 
#  all combination of the matches are returned.
# 􏰀 left join : return all rows from x, and all columns from x and y. 
#  Rows in x with no match in y will have NA values in the new columns. 
#  If there are multiple matches between x and y, all combinations of the matches are returned.
# 􏰀 right join :

# What do you think the following snippets will do
# Try to guess before running, then run to confirm
left_join(people.info, occup.info)
right_join(people.info, occup.info)
inner_join(people.info, occup.info)
# Do the following return the same data set?
left_join(people.info, occup.info)
right_join(occup.info, people.info)
# Do you think this will work?
people.info %>% left_join(occup.info)


# semi join returns only lhs columns, and only for ids common to both
# 􏰀 anti join returns only lhs columns, and only for ids *not* common to both
# 􏰀 full join returns all columns, for all ids, merging with inner/left/right when applicable
semi_join(people.info, occup.info)
anti_join(people.info, occup.info)
full_join(people.info, occup.info)

# Merge the airport and delay data so that we have state/city
# infromation regarding the destination
# Hint use left_join with by=c("Dest" = "iata")

delay.dat.houston %>%
  left_join(airport.dat, by=c("Dest" = 'iata') )

# Calculate the number of flights to each destination state
# For each carrier, for which state do they have the largest avearge delay?

# one option
delay.dat.houston %>%
  left_join(airport.dat,
            by=c("Dest" = 'iata')) %>%
  group_by(state) %>%
  summarise(
    NFlights = n()
  ) %>%
  select(state,NFlights)


delay.dat.houston %>%
  left_join(airport.dat,
            by=c("Dest" = 'iata')) %>%
  group_by(UniqueCarrier, state) %>%
  summarise(
    AvgDelay = mean(DepDelay,na.rm=TRUE)
  ) %>%
  select(state,UniqueCarrier, AvgDelay) %>%
  arrange(UniqueCarrier, desc(AvgDelay)) %>%
  distinct(UniqueCarrier,.keep_all = TRUE)

