library(ggplot2)
library(tidyverse)
library(data.table)
geoMap <- read.csv("/Users/haowu/Desktop/Boston University Graduate Study/2022 SPRING/MET CS 688/WU/Data/geoMap.csv", header =TRUE, blank.lines.skip = TRUE, stringsAsFactors =  FALSE, skip = 2 )
colnames(geoMap) <- c('region','GB','GG')
summary(geoMap)
GG <- as.numeric(geoMap$GG)
GB <- as.numeric(geoMap$GB)
geoMap$GG <- GG
geoMap$GB <- GB                      
##Q1
a <- which(is.na(geoMap$GG))
a
geoMap$GG [a] <- 0
geoMap

##Q2
count <- sum(geoMap$GB > geoMap$GG)
count

##Q3
gg10 <- (geoMap$GG +10) >GB
above <- geoMap$region[gg10 == "TRUE"]
above

##Q4
q4a <- sum(gg10)
q4 <- q4a/length(geoMap$region)
q4

##Q5
rownames(geoMap) = geoMap$region
ratio <- geoMap['New Hampshire','GG']/geoMap['New Hampshire','GB']
ratio

##Q6
df <- melt(geoMap, id.vars = "region")
p = ggplot(data=df, aes(x=variable, y=value, fill=variable)) +
  geom_bar(stat="identity") +
  facet_wrap(~ region)
p


