# tidyverse

install.packages("tidyverse")

library(tidyverse)

# nycflights13

install.packages("nycflights13")

library(nycflights13)

# tibble

a <- 1:100

tibble(a, b = 2 * a)

tibble(a, b = 2 * a, c = b^2)

# error with data.frame

data.frame(a, b = 2 * a, c = b^2)

# converting to tibble
as_tibble(iris)

# flights dataset

nycflights13::flights

# tribble

athlete.info <- tribble(
  ~Name,       ~Salary, ~Endorsements, ~Sport,
  "Mayweather",  105,      0,             "Boxing",
  "Ronaldo",      52,     28,             "Soccer",
  "James",      19.3,     53,             "Basketball",
  "Messi",      41.7,     23,             "Soccer",
  "Bryant",     30.5,     31,             "Basketball"
)

athlete.info

# glimpse
glimpse(athlete.info)

glimpse(nycflights13::flights)

# Pipe

summary(athlete.info)

athlete.info %>% summary

# is.tibble

is.tibble(iris)
is_tibble(athlete.info)

## dplyr - filter

filter(flights, month == 4)

filter(flights, month == 4, day == 10)
# equivalent to flights[flights$month == 4 & flights$day == 10, ]

filter(flights, month == 6 | month == 7)

filter(flights, month == 6 | month == 7) %>% tail()

filter(flights, month %in% c(3, 5, 7))

## dplyr - arrange

athlete.info

arrange(athlete.info, Salary)

arrange(athlete.info, Sport, Name)

arrange(athlete.info, desc(Salary))

arrange(flights, year, month, day)  %>% head

# Arranging column in descending order

arrange(flights, desc(arr_delay))  %>% head

## dplyr - select

# Select columns by name
select(flights, carrier, flight, tailnum, origin, dest)

# Select all columns between carrier and dest (inclusive)
select(flights, carrier:dest)

# Select all columns except those from carrier to dest (inclusive)
select(flights, -(carrier:dest)) 

help(select)

# Rename variables with select

select(flights, departure_time = dep_time)

rename(flights, departure_time = dep_time)

#
select(flights, starts_with("d"))
select(flights, ends_with("time"))
select(flights, contains("in"))

select(flights, flight, origin, dest, everything())

## mutate


flights %>%
  mutate(gain = arr_delay - dep_delay,
         speed = (distance / air_time) * 60)  %>% 
  select(flight, arr_delay, dep_delay, gain, 
         distance, air_time, speed, everything())

# can refer to new columns

flights %>%
  mutate(air_time_in_hours = air_time/60,
         speed = distance / air_time_in_hours)  %>%
  select(flight, distance, air_time, air_time_in_hours, 
         speed, everything())

## transmute

# To keep only the new variables
flights %>%
  transmute(gain = arr_delay - dep_delay,
            speed = (distance / air_time) * 60)

## distinct

distinct(flights, origin)

distinct(flights, tailnum) %>% head

distinct(flights, carrier)

distinct(flights, origin, dest) %>% head


arrange(
  distinct(flights, origin, dest),
  origin, dest)  %>% head

## summarize

flights %>%
  summarise(delay = mean(arr_delay))

flights %>%
  summarise(delay = mean(arr_delay, na.rm = TRUE))


flights %>%
  filter(arr_delay > 0) %>%
  summarise(count = n(),
            avg_delay = mean(arr_delay))

flights %>%
  filter(arr_delay <= 0) %>%
  summarise(count = n(),
            avg_early = mean(arr_delay))

# group

flights %>%
  filter(arr_delay > 0) %>%
  group_by(year, month) %>%
  summarise(count = n(),
            avg_delay = mean(arr_delay))

flights %>%
  filter(arr_delay > 0) %>%
  group_by(origin) %>%
  summarise(count = n(),
            avg_delay = mean(arr_delay))

flights %>%
  filter(arr_delay > 0) %>%
  group_by(origin, dest) %>%
  summarise(count = n(),
            avg_delay = mean(arr_delay))


## tidyr

# sample data in wide format

set.seed(123)

sales <- 
  tibble(Store=rep(1:3, each=4),
         Year=rep(2014:2017, 3),
         Qtr_1 = round(runif(12, 10, 30)),
         Qtr_2 = round(runif(12, 10, 30)),
         Qtr_3 = round(runif(12, 10, 30)),
         Qtr_4 = round(runif(12, 10, 30))
  )
sales

# gather

sales %>%
  gather(Quarter, Revenue, Qtr_1 : Qtr_4) %>%
  head(12)

sales %>%
  gather(Quarter, Revenue, Qtr_1 : Qtr_4) %>%
  tail(12)

# Equaivalent forms

sales %>%
  gather(key = Quarter, value = Revenue, Qtr_1 : Qtr_4)

sales %>% gather(Quarter, Revenue, -Store, -Year)

sales %>% gather(Quarter, Revenue, 3:6)

sales %>% gather(Quarter, Revenue, 
                 Qtr_1, Qtr_2, Qtr_3, Qtr_4) -> long_data

# separate

long_data %>% 
  separate(Quarter, c("Time_Interval", "Interval_ID"),
           convert = TRUE) -> separate_data

separate_data

glimpse(separate_data)

# Equivalent form

long_data %>% separate(Quarter, into = c("Time_Interval", "Interval_ID"), 
                       sep = "_", convert = TRUE) -> separate_data

# unite

separate_data %>% 
  unite(Quarter, Time_Interval, Interval_ID)

# default separator is _

separate_data %>% 
  unite(Quarter, Time_Interval, Interval_ID, sep = ".")


separate_data %>% 
  unite(Quarter, Time_Interval, Interval_ID) -> unite_data

unite_data

# Other Examples

pew <- read.csv("http://kalathur.com/cs544/data/pew.csv", 
                stringsAsFactors = FALSE, check.names = FALSE)
pew


pew %>%
  gather(income, frequency, -religion)

#


billboard <- tbl_df(read.csv("http://kalathur.com/cs544/data/billboard.csv", 
                             stringsAsFactors = FALSE))
billboard

billboard %>% 
  gather(week, rank, wk1:wk76, na.rm = TRUE) -> billboard2


billboard2

billboard2 %>%
  mutate(
    week = extract_numeric(week)) %>%
  select(-date.entered)  -> billboard3

billboard3

# sort by artist, track, and week

billboard3 %>% arrange(artist, track, week)

# sort by week, rank, and artist
billboard3 %>% arrange(week, rank, artist)

