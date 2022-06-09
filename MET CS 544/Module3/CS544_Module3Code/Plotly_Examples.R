# https://plot.ly/r/
# https://github.com/plotly/datasets


## RStudio -> Tools -> Install Packagess... (plotly)


library(plotly)

##

head(iris)

## Box Plots

p <- plot_ly(iris, x = ~Sepal.Length, type="box", name = 'SL')
p

p <- add_trace(p, x = ~Sepal.Width, name = 'SW')
p

p <- add_trace(p, x = ~Petal.Length, name = 'PL')
p

p <- add_trace(p, x = ~Petal.Width, name = 'PW')
p

p <- layout(p, yaxis = list(title = 'Measure'))
p

## Simplified code Using Pipe

plot_ly(iris, y = ~Sepal.Length, type="box", name = 'SepalLength') %>%
  add_trace(y = ~Sepal.Width, name = 'SepalWidth') %>%
  add_trace(y = ~Petal.Length, name = 'PetalLength') %>%
  add_trace(y = ~Petal.Width, name = 'PetalWidth') %>%
  layout(yaxis = list(title = 'Measure')) -> p

p

##

help(midwest)

plot_ly(midwest, x = ~percollege, color = ~state, type = "box")

# Vertical Boxplot

plot_ly(y = ~rnorm(50), type = "box") %>%
  add_trace(y = ~rnorm(50, 1))

# Horizontal Boxplot

plot_ly(x = ~rnorm(50, mean = 80, sd=5), type = "box") %>%
  add_trace(x = ~rnorm(50, mean = 60, sd=15))


# 

plot_ly(y = ~rnorm(50), type = "box", boxpoints = "all", 
        jitter = 0, pointpos = 0)

plot_ly(y = ~rnorm(50), type = "box", boxpoints = "all", 
        jitter = 0.2, pointpos = -1.5)


##

subplot(
  
  plot_ly(y = c(35,40,50,65,72,73,73,74,75,81,83,87,92), 
          type = "box", boxpoints = "all", 
          jitter = 0.2, pointpos = -1.5),
  plot_ly(y = c(65,66,70,72,72,73,73,74,74,79,95,99), 
          type = "box", boxpoints = "all", 
          jitter = 0.2, pointpos = -1.5),
  plot_ly(y = c(35,40,55,65,66,70,72,72,73,73,74,74,79,95,99), 
          type = "box", boxpoints = "all", 
          jitter = 0.2, pointpos = -1.5),
  plot_ly(y = c(71,72,73,73,74,75,77,81,83,87,91,92), 
          type = "box", boxpoints = "all", 
          jitter = 0.2, pointpos = -1.5),
  
  nrows = 1,
  shareY = TRUE
)

# R boxplot limits for outliers

x <- c(35,40,50,65,72,73,73,74,75,81,83,87,92)
f <- fivenum(x)
f
c(f[2] - 1.5*(f[4]-f[2]), f[4] + 1.5*(f[4]-f[2]))


# plotly boxplot limits for outliers

f <- quantile(x, type=5)
f
c(f[2] - 1.5*(f[4]-f[2]), f[4] + 1.5*(f[4]-f[2]))




## Scatter Plot


p <- plot_ly(iris, x = ~Sepal.Width, y = ~Sepal.Length) 
p

p <- add_markers(p, color = ~Petal.Length, size = ~Petal.Width)
p

p <- add_markers(p, symbol = ~Species)
p

##

iris %>%
  plot_ly(x = ~Sepal.Width, y = ~Sepal.Length) %>%
  add_markers(color = ~Petal.Length, size = ~Petal.Width) %>%
  add_markers(symbol = ~Species) 

  
## Histogram & Scatter plots


head(economics)

plot_ly(economics, x = ~pop)

plot_ly(economics, x = ~date, y = ~pop)

plot_ly(economics, x = ~date, y = ~unemploy)


p <- plot_ly(economics, x = ~date, y = ~unemploy*100/pop)
p
p <- add_lines(p)
p

##

economics %>% 
  plot_ly(x = ~date, y = ~unemploy*100/pop) %>% 
  add_lines()

##

economics %>% 
  plot_ly(x = ~date, y = ~uempmed) %>% 
  add_lines()

##

plot_ly(economics, x = ~date, color = I("black")) %>%
  add_lines(y = ~uempmed, name="Unemp Median Duration") %>%
  add_lines(y = ~psavert, color = I("red"), name="Savings Rate")  


##

help(txhousing)

head(txhousing)

tx <- group_by(txhousing, city)
tx

p <- plot_ly(tx, x = ~date, y = ~median)
p

# plots one line per city since p knows city is a grouping variable

p <- add_lines(p, alpha = 0.2, name = "Texan Cities", hoverinfo = "none")
p

p <- add_lines(p,name = "Houston", data = filter(txhousing, city == "Houston"))
p

##

help("txhousing")

txhousing

txhousing %>%
  group_by(city) %>%
  plot_ly(x = ~date, y = ~median) %>%
  add_lines(alpha = 0.2, name = "Texan Cities", hoverinfo = "none") %>%
  filter(city == "Houston") %>%
  add_lines(name = "Houston") 

##


head(mpg)


subplot(
  plot_ly(x = 1:25, y = 1:25, symbol = I(1:25), name = "pch"),

  plot_ly(mpg, x = ~cty, y = ~hwy, symbol = ~paste0(cyl," cyl."))
    
)

##

# 3D scatterplot

plot_ly(mpg, x = ~cty, y = ~hwy, z = ~cyl) %>%
  add_markers(color = ~cyl)
  

##

# create visualizations of the diamonds dataset

table(diamonds$cut, diamonds$clarity)
addmargins(table(diamonds$cut, diamonds$clarity))


plot_ly(diamonds, x = ~cut)
plot_ly(diamonds, x = ~cut, y = ~clarity)
plot_ly(diamonds, x = ~cut, color = ~clarity, colors = "Accent")

# Color palettes

library(RColorBrewer)
display.brewer.all()


# Basic Bar Chart

plot_ly(
  x = c("giraffes", "orangutans", "monkeys"),
  y = c(20, 14, 23),
  name = "SF Zoo",
  type = "bar"
)

# Grouped Bar Chart

Animals <- c("giraffes", "orangutans", "monkeys")
SF_Zoo <- c(20, 14, 23)
LA_Zoo <- c(12, 18, 29)
df <- data.frame(Animals, SF_Zoo, LA_Zoo)
df

p <- plot_ly(df, x = ~Animals, y = ~SF_Zoo, type = 'bar', name = 'SF Zoo') %>%
  add_trace(y = ~LA_Zoo, name = 'LA Zoo') %>%
  layout(yaxis = list(title = 'Count'), barmode = 'group')

p

# Stacked Bar Chart

Animals <- c("giraffes", "orangutans", "monkeys")
SF_Zoo <- c(20, 14, 23)
LA_Zoo <- c(12, 18, 29)
df <- data.frame(Animals, SF_Zoo, LA_Zoo)
df

p <- plot_ly(df, x = ~Animals, y = ~SF_Zoo, type = 'bar', name = 'SF Zoo') %>%
  add_trace(y = ~LA_Zoo, name = 'LA Zoo') %>%
  layout(yaxis = list(title = 'Count'), barmode = 'stack')

p

# Customizing bar widths

x= c(1, 2, 3, 5.5, 10)
y= c(10, 8, 6, 4, 2)
width = c(0.8, 0.8, 0.8, 3.5, 4)
df <- data.frame(x, y, width)
df

p <- plot_ly(df) %>%
  add_bars(
    x= ~x,
    y= ~y,
    width = ~width
  )

p


# Rotated Bar Chart Labels

x <- c('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December')
y1 <- c(20, 14, 25, 16, 18, 22, 19, 15, 12, 16, 14, 17)
y2 <- c(19, 14, 22, 14, 16, 19, 15, 14, 10, 12, 12, 16)
df <- data.frame(x, y1, y2)
df


plot_ly(df, x = ~x, y = ~y1, type = 'bar', name = 'Primary Product', marker = list(color = 'rgb(49,130,189)')) %>%
  add_trace(y = ~y2, name = 'Secondary Product', marker = list(color = 'rgb(204,204,204)')) %>%
  layout(xaxis = list(title = "", tickangle = -45),
         yaxis = list(title = ""),
         margin = list(b = 100),
         barmode = 'group')


#The default order will be alphabetized unless specified as below:

df$x

df$x <- factor(df$x, levels = df[["x"]])
df$x

plot_ly(df, x = ~x, y = ~y1, type = 'bar', 
             name = 'Primary Product', 
             marker = list(color = 'rgb(49,130,189)')) %>%
  add_trace(y = ~y2, name = 'Secondary Product', 
            marker = list(color = 'rgb(204,204,204)')) %>%
  layout(xaxis = list(title = "", tickangle = -45),
         yaxis = list(title = ""),
         margin = list(b = 100),
         barmode = 'group')



# Customizing Bar Base  (positive and negative values)

plot_ly() %>%
  add_bars(
    x = c("2016", "2017", "2018"),
    y = c(500,600,700),
    base = c(-500,-600,-700),
    marker = list(
      color = 'red'
    ),
    name = 'expenses'
  ) %>%
  add_bars(
    x = c("2016", "2017", "2018"),
    y = c(300,400,700),
    base = 0,
    marker = list(
      color = 'blue'
    ),
    name = 'revenue'
  )




## https://github.com/plotly/datasets

## Dot plots
df <- read.csv("https://raw.githubusercontent.com/plotly/datasets/master/school_earnings.csv")
df


plot_ly(df, x = ~Women, y = ~School, name = "Women", type = 'scatter',
             mode = "markers", marker = list(color = "pink")) %>%
  add_trace(x = ~Men, y = ~School, name = "Men",type = 'scatter',
            mode = "markers", marker = list(color = "blue")) %>%
  layout(
    title = "Gender earnings disparity",
    xaxis = list(title = "Annual Salary (in thousands)"),
    margin = list(l = 100)
  )

# order by Men's salary

df <- df[order(df$Men), ]
df

df$School <- factor(df$School, levels = df$School[order(df$Men)])
df$School

plot_ly(df, x = ~Women, y = ~School, name = "Women", type = 'scatter',
             mode = "markers", marker = list(color = "pink")) %>%
  add_trace(x = ~Men, y = ~School, name = "Men",type = 'scatter',
            mode = "markers", marker = list(color = "blue")) %>%
  layout(
    title = "Gender earnings disparity",
    xaxis = list(title = "Annual Salary (in thousands)"),
    margin = list(l = 100)
  )


## Dumbbell Plots

df <- read.csv("https://raw.githubusercontent.com/plotly/datasets/master/school_earnings.csv")
df


p1 <- plot_ly(df, color = I("gray80")) %>%
  add_segments(x = ~Women, xend = ~Men, y = ~School, yend = ~School, showlegend = FALSE) %>%
  add_markers(x = ~Women, y = ~School, name = "Women", color = I("pink")) %>%
  add_markers(x = ~Men, y = ~School, name = "Men", color = I("blue")) %>%
  layout(
    title = "Gender earnings disparity",
    xaxis = list(title = "Annual Salary (in thousands)"),
    margin = list(l = 65)
  )

p1

df$School

# order factor levels by income gap
df$School <- factor(df$School, levels = df$School[order(df$Gap)])
df$School

p2 <- plot_ly(df, color = I("gray80")) %>%
  add_segments(x = ~Women, xend = ~Men, y = ~School, yend = ~School, showlegend = FALSE) %>%
  add_markers(x = ~Women, y = ~School, name = "Women", color = I("pink")) %>%
  add_markers(x = ~Men, y = ~School, name = "Men", color = I("blue")) %>%
  layout(
    title = "Gender earnings disparity",
    xaxis = list(title = "Annual Salary (in thousands)"),
    margin = list(l = 65)
  )

p2

# order factor levels by men's salary
df$School <- factor(df$School, levels = df$School[order(df$Men)])
df$School

p3 <- plot_ly(df, color = I("gray80")) %>%
  add_segments(x = ~Women, xend = ~Men, y = ~School, yend = ~School, showlegend = FALSE) %>%
  add_markers(x = ~Women, y = ~School, name = "Women", color = I("pink")) %>%
  add_markers(x = ~Men, y = ~School, name = "Men", color = I("blue")) %>%
  layout(
    title = "Gender earnings disparity",
    xaxis = list(title = "Annual Salary (in thousands)"),
    margin = list(l = 65)
  )

p3

subplot(p1, p2, p3)


## Bubble Charts

df <- read.csv("https://raw.githubusercontent.com/plotly/datasets/master/school_earnings.csv")
df

plot_ly(df, x = ~Women, y = ~Men, text = ~School, 
             type = 'scatter', mode = 'markers',
             marker = list(size = ~Gap, opacity = 0.5)) %>%
  layout(title = 'Gender Gap in Earnings per University',
         xaxis = list(showgrid = FALSE),
         yaxis = list(showgrid = FALSE))


# Setting Marker color

plot_ly(df, x = ~Women, y = ~Men, text = ~School, 
             type = 'scatter', mode = 'markers',
             marker = list(size = ~Gap, opacity = 0.5, 
                           color = 'rgb(255, 65, 54)')) %>%
  layout(title = 'Gender Gap in Earnings per University',
         xaxis = list(showgrid = FALSE),
         yaxis = list(showgrid = FALSE))


# Mapping a color variable

plot_ly(df, x = ~Women, y = ~Men, text = ~School, 
             type = 'scatter', mode = 'markers', 
             color = ~Gap, colors = 'Reds',
             marker = list(size = ~Gap, opacity = 0.5)) %>%
  layout(title = 'Gender Gap in Earnings per University',
         xaxis = list(showgrid = FALSE),
         yaxis = list(showgrid = FALSE))


# Styled Bubble Chart

df <- read.csv("https://raw.githubusercontent.com/plotly/datasets/master/gapminderDataFiveYear.csv")
head(df)

unique(df$year)

unique(df$continent)

data_2007 <- df[which(df$year == 2007),]  # subset(df, year == 2007)
head(data_2007)

data_2007 <- data_2007[order(data_2007$continent, data_2007$country),]
head(data_2007)

colors <- c('#4AC6B7', '#1972A4', '#965F8A', '#FF7070', '#C61951')


summary(data_2007$pop)

max(data_2007$pop) / min(data_2007$pop)

slope <- 2e-05

data_2007$size <- sqrt(data_2007$pop * slope)

summary(data_2007$size)

max(data_2007$size) / min(data_2007$size)


colors <- c('#4AC6B7', '#1972A4', '#965F8A', '#FF7070', '#C61951')

plot_ly(data_2007, x = ~gdpPercap, y = ~lifeExp, color = ~continent, size = ~size, colors = colors,
             type = 'scatter', mode = 'markers', 
             sizes = c(min(data_2007$size), max(data_2007$size)),
             marker = list(symbol = 'circle', sizemode = 'diameter',
                           line = list(width = 2, color = '#FFFFFF')),
             text = ~paste('Country:', country, '<br>Life Expectancy:', lifeExp, '<br>GDP:', gdpPercap,
                           '<br>Pop.:', pop)) %>%
  layout(title = 'Life Expectancy v. Per Capita GDP, 2007',
         xaxis = list(title = 'GDP per capita (2007 dollars)',
                      gridcolor = 'rgb(255, 255, 255)',
                      range = c(2, 6),
                      type = 'log',
                      zerolinewidth = 1,
                      ticklen = 5,
                      gridwidth = 2),
         yaxis = list(title = 'Life Expectancy (years)',
                      gridcolor = 'rgb(255, 255, 255)',
                      range = c(35, 90),
                      zerolinewidth = 1,
                      ticklen = 5,
                      gridwith = 2),
         paper_bgcolor = 'rgb(235, 161, 52)',
         plot_bgcolor = 'rgb(243, 243, 243)'
         )




# Multiple Charts

help(airquality)
head(airquality)

airquality_sept <- airquality[which(airquality$Month == 9),]
airquality_sept$Date <- as.Date(paste(airquality_sept$Month, airquality_sept$Day, 1973, sep = "."), 
                                format = "%m.%d.%Y")

airquality_sept

plot_ly(airquality_sept) %>%
  add_trace(x = ~Date, y = ~Wind, type = 'bar', name = 'Wind',
            marker = list(color = '#C9EFF9'),
            hoverinfo = "text",
            text = ~paste(Wind, ' mph')) %>%
  add_trace(x = ~Date, y = ~Temp, type = 'scatter', mode = 'lines', name = 'Temperature', yaxis = 'y2',
            line = list(color = '#45171D'),
            hoverinfo = "text",
            text = ~paste(Temp, '°F')) %>%
  layout(title = 'New York Wind and Temperature Measurements for September 1973',
         xaxis = list(title = ""),
         yaxis = list(side = 'left', title = 'Wind in mph', 
                      showgrid = FALSE, zeroline = FALSE),
         yaxis2 = list(side = 'right', overlaying = "y", title = 'Temperature in degrees F', 
                       showgrid = FALSE, zeroline = FALSE))


## 3 D

help(volcano)

dim(volcano)

volcano[c(1:5), c(1:10)]


plot_ly(z = ~volcano)

plot_ly(z = ~volcano, type = "surface")


## 


df <- read.csv("https://raw.githubusercontent.com/plotly/datasets/master/gapminderDataFiveYear.csv")
head(df)

unique(df$year)

unique(df$continent)



## Animations

df_all <- df

slope <- 2e-05

df_all$size <- sqrt(df_all$pop * slope)


df_all %>%
  plot_ly(
    x = ~gdpPercap, 
    y = ~lifeExp, 
    size = ~size, 
    sizes = c(min(df_all$size), max(df_all$size)),
    color = ~continent, 
    frame = ~year, 
    text = ~country, 
    hoverinfo = "text",
    type = 'scatter',
    mode = 'markers'
  ) %>%
  layout(
    xaxis = list(
      type = "log"
    ))

df_all %>%
  plot_ly(x = ~gdpPercap, y = ~lifeExp, color = ~continent, 
          size = ~size, colors = colors,
          frame=~year,
        type = 'scatter', mode = 'markers', 
        sizes = c(min(data_2007$size), max(data_2007$size)),
        marker = list(symbol = 'circle', sizemode = 'diameter',
                      line = list(width = 2, color = '#FFFFFF')),
        text = ~paste('Country:', country, '<br>Life Expectancy:', lifeExp, '<br>GDP:', gdpPercap,
                      '<br>Pop.:', pop)) %>%
  layout(title = 'Life Expectancy v. Per Capita GDP, 2007',
         xaxis = list(title = 'GDP per capita (2007 dollars)',
                      gridcolor = 'rgb(255, 255, 255)',
                      range = c(2, 6),
                      type = 'log',
                      zerolinewidth = 1,
                      ticklen = 5,
                      gridwidth = 2),
         yaxis = list(title = 'Life Expectancy (years)',
                      gridcolor = 'rgb(255, 255, 255)',
                      range = c(20, 90),
                      zerolinewidth = 1,
                      ticklen = 5,
                      gridwith = 2),
         paper_bgcolor = 'rgb(235, 161, 52)',
         plot_bgcolor = 'rgb(243, 243, 243)'
  ) %>%
   animation_slider(
    currentvalue = list(prefix = "YEAR ", font = list(color="red"))
  )



