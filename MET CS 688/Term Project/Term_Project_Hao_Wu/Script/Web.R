rm(list=ls()); cat("\014") # Clear Workspace and Console
library(XML)
dir <-file.path(paste0('Data/'))
HTML.dataset <- list.files(dir, pattern ="html") # List of all saved HTML files @ location "dir"

sieve.HTML <- function(URL) {
  table <- readHTMLTable(URL) # Read HTML table into a list
}

#Load all html content
temp.HTML.text <- lapply(as.list( paste0(dir,HTML.dataset)),function(x) sieve.HTML(x)) # Get all the text from the saved HTMLs

# Text cleaning
library(tm)
corpus.txt <- VCorpus(VectorSource(temp.HTML.text))
transform.words <- content_transformer(function(x, from, to) gsub(from, to, x))
temp <- tm_map(corpus.txt, transform.words, "<.+?>", " ")
temp <- tm_map(temp, transform.words, "\t", " ")
temp <- tm_map(temp, content_transformer(tolower)) # Conversion to Lowercase
temp <- tm_map(temp, stripWhitespace)
temp <- tm_map(temp, removeWords, stopwords("english"))
temp <- tm_map(temp, removePunctuation)
remove(corpus.txt)

dtm <- as.matrix(DocumentTermMatrix(temp))


library(cluster) # Load similarity measures package
#Compare
plot.new()
par(mfrow=c(1,2))
d <- dist(dtm, method="euclidean")
cl <- hclust(as.dist(d), method="ward.D2") # Perform clustering
cl$labels=HTML.dataset # Assign labels (terms used) to cluster leaves
plot(cl,main="Euclidean Distance",xlab="Term Clustering Dendrogram using",sub = "...") # Set plot title
rect.hclust(cl, k=3, border="red") # draw dendogram with red borders around the 5 clusters  

d2 <- dist(dtm, method="binary")
cl3 <- hclust(as.dist(d2), method="ward.D2") # Perform clustering
cl3$labels=HTML.dataset # Assign labels (terms used) to cluster leaves
plot(cl3,main="Jaccard Distance",xlab="Term Clustering Dendrogram using",sub = "...") # Set plot title
rect.hclust(cl3, k=3, border="blue") # draw dendogram with red borders around the 5 clusters  

#Convert it to long format prepare for plot
library(dplyr)
library(tidyverse)
rownames(dtm) <- HTML.dataset
data <- as.data.frame(as.table(dtm))
m <- arrange(data,desc(Freq))

#Get the top freq words of all documents
Top75 <- m[1:75,]

#Get Each docs the first 3 most freq words
data <- m %>%
  group_by(Docs)%>%
  slice(1:3)

# Draw Bubble Chart
library(googleVis)

chart <- 
  gvisBubbleChart( data, 
                  idvar='Terms', 
                  xvar='Docs', yvar='Freq',
                  colorvar='Terms', sizevar='Freq',
                  options=list(
                    width=1000, height=800)
                  )

plot(chart)
cat(chart$html$chart, file = "TP.html")


