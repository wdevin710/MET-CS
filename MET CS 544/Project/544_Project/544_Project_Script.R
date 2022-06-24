## 544 Final Project
## Hao Wu   
## Twitter daily stock prices 2013 to 2022

rm(list=ls()); cat("\014") ## clear workspace
Twitter <- read.csv(file = 'DATA/TWTR.csv')
head(Twitter)

library(dplyr)
library(ggplot2)
library(plotly)
library(tibbletime)
library(lubridate)
library(reshape2)

##Check Null value
Twitter <- na.omit(Twitter)
which(is.na(Twitter))

Twitter$Date <- as.Date(Twitter$Date)
## Drop 2013 stock data, because it is small size and useless
Twitter <- Twitter %>%
  mutate(Year = year(Date))
Twitter <- subset(Twitter, Twitter['Year'] > 2013)


## Get the varaible which we need to use
DF <- Twitter %>%
  summarise(Date = Date,Open = Open,High = High, Low = Low, Volume = round(Volume/1000000, 2))

## Set Column "Date" as date format
DF$Date <- as.Date(DF$Date)
fig <- plot_ly(DF, x = ~Date, y = ~Open, name = 'Open', type = 'scatter', mode = 'lines') 
fig <- fig %>% add_trace(y = ~Volume, name = 'Volume', mode = 'lines') 
fig <- fig %>% add_trace(y = ~High, name = 'High', mode = 'lines') 
fig <- fig %>% add_trace(y = ~Low,  name = 'Low', mode = 'lines')
fig <- fig %>% layout(title = "Variable Trend",
                      xaxis = list(title = "Date"),
                      yaxis = list (title = "Value"))
fig

## Draw Box plot
figbox <- plot_ly(y = ~DF$Open, type = "box",name="Open")
figbox <- figbox %>% add_trace(y = ~DF$Volume, name="Volume")
figbox <- figbox %>% add_trace(y = ~DF$High, name="High")
figbox <- figbox %>% add_trace(y = ~DF$Low, name="Close")
figbox <- figbox %>% layout(title = "Boxplot for Open and Volume",
                            xaxis = list(title = "Variables"),
                            yaxis = list (title = "Value"))

figbox
## Draw the distribution of all variable
y1 <- dnorm(DF$Open,mean = mean(DF$Open), sd = sd(DF$Open))
y2 <- dnorm(DF$Volume,mean = mean(DF$Volume), sd = sd(DF$Volume))
y3 <- dnorm(DF$High,mean = mean(DF$High), sd = sd(DF$High))
y4 <- dnorm(DF$Low,mean = mean(DF$Low), sd = sd(DF$Low))## Draw distribution
figdis1 <- plot_ly(DF, x = ~DF$Open, y = y1, type = 'scatter', mode = 'markers') 
figdis1 <- figdis1 %>% layout(title = "Distribution of Open",
                              xaxis = list(title = "Open"),
                              yaxis = list (title = "Destiny"))
figdis2 <- plot_ly(DF, x = ~DF$Volume, y = y2, type = 'scatter', mode = 'markers') 
figdis2 <- figdis2 %>% layout(title = "Distribution of Open",
                              xaxis = list(title = "Volume"),
                              yaxis = list (title = "Destiny"))
figdis3 <- plot_ly(DF, x = ~DF$High, y = y3, type = 'scatter', mode = 'markers') 
figdis3 <- figdis3 %>% layout(title = "Distribution of Open",
                              xaxis = list(title = "High"),
                              yaxis = list (title = "Destiny"))
figdis4 <- plot_ly(DF, x = ~DF$Low, y = y4, type = 'scatter', mode = 'markers') 
figdis4 <- figdis4 %>% layout(title = "Distribution of Open",
                              xaxis = list(title = "Low"),
                              yaxis = list (title = "Destiny"))

annotations = list( 
  list( 
    x = 0.2,  
    y = 1.0,  
    text = "Open",  
    xref = "paper",  
    yref = "paper",  
    xanchor = "center",  
    yanchor = "bottom",  
    showarrow = FALSE 
  ),  
  list( 
    x = 0.8,  
    y = 1,  
    text = "Volume",  
    xref = "paper",  
    yref = "paper",  
    xanchor = "center",  
    yanchor = "bottom",  
    showarrow = FALSE 
  ),  
  list( 
    x = 0.2,  
    y = 0.4,  
    text = "High",  
    xref = "paper",  
    yref = "paper",  
    xanchor = "center",  
    yanchor = "bottom",  
    showarrow = FALSE 
  ),
  list( 
    x = 0.8,  
    y = 0.4,  
    text = "Low",  
    xref = "paper",  
    yref = "paper",  
    xanchor = "center",  
    yanchor = "bottom",  
    showarrow = FALSE 
  ))
figdis <- subplot(figdis1, figdis2, figdis3, figdis4, nrows = 2)%>%
  layout(title = 'Distribution for all variables', annotations = annotations)


figdis


## Group by data by year & month,use mean to represent the value for more easier to understand

X <- DF %>%
  mutate(Year = year(Date),Month = month(Date),
         .after = Date)

X <- X %>%
  group_by(Year, Month)%>%
  summarise(Open = mean(Open),
            Volume = mean(Volume),
            High = mean(High),
            Low = mean(Low))


X <- X %>%
  mutate(date = make_date(Year, Month), .before=Year)%>%
  subset( select = c('date','Open','Volume','High','Low'))
fig2 <- plot_ly(X, type = 'scatter', mode = 'lines')%>%
  add_trace(x = ~date, y = ~Open, name = 'Open')%>%
  add_trace(x = ~date, y = ~Volume, name= 'Volume')%>%
  add_trace(x = ~date, y = ~High, name= 'High')%>%
  add_trace(x = ~date, y = ~Low, name= 'Low')%>%
  layout(title = "Trend of Variables by mean",
         xaxis = list(title = "Year"),
         yaxis = list (title = "Value"))
fig2

## Center limit Theorem

set.seed(100)
samples <- 1000
sample <- numeric(samples)
par(mfrow = c(2,2))


for (size in c(10, 20, 30, 40)) {
  for (i in 1:samples) {

    sample[i] <- mean(sample(DF$Open, size = size, 
                           replace = FALSE))

  }
  hist(sample, prob = TRUE, 
       main = paste("Sample Size =", size))
  cat("Sample Size = ", size, " Mean = ", mean(sample),
      " SD = ", sd(sample), "\n")
}

par(mfrow = c(1,1))

## We start to Gain or Lose Predict Model
## We need to label our dataset's stock price is increase or decrease.
## We separete train set and test set
## We use variable data1 stored train data, data2 stored test data.
#data1 <- Twitter %>%
#  subset(Year == 2016)
  
#data2 <- Twitter %>%
#  subset(Year == 2017)
a <- sample(2, nrow(Twitter), replace = TRUE, prob = c(0.6,0.4))
set.seed(100)
data1 <- Twitter[a == 1,]
data2 <- Twitter[a == 2,]

#data1 <- subset(data1,select = c(2:6))
#data2 <- subset(data2,select = c(2:6))
## We start to label it. 0 mean gain, 1 mean lose. When Open = Close, we gain.
data1$Label <- ifelse(data1$Open > data1$Close, 1,
                      ifelse(data1$Open < data1$Close , 0, 0))
data1 <- subset(data1, select = c('Open','High','Low','Volume','Label'))
data2$Label <- ifelse(data2$Open > data2$Close, 1,
                      ifelse(data2$Open < data2$Close , 0, 0))
data2 <- subset(data2, select = c('Open','High','Low','Volume','Label'))


data1$Label <- as.factor(data1$Label)
data2$Label <- as.factor(data2$Label)
library(randomForestSRC)
library(caret)
n <- length(names(data1))
set.seed(100)
## Select mtry number
for(i in 1:6){
  mtry <- rfsrc(Label~., data1, mtry=i)
  error <- mean(mtry$err.rate, na.rm = TRUE)
  print(error)
}
## Select 5 as mtry paramter
set.seed(100)

## Find out best ntree
ntree <-rfsrc(Label~.,data1,mtry=4, ntree=800, importance = TRUE)
plot(ntree)

## Start to modeling, then plot
rf <- rfsrc(Label~., data1, mtry=4, ntree = 400, importance = TRUE)
rf
## Use model to predict gain or lose, then output confusion_matrix
pred1 <-predict.rfsrc(rf,data2)
cf <- table(data2$Label, pred1$class, dnn = c('Actual','Predicted'))
cf
