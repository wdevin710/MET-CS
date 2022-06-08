library(tm)
library(SnowballC)

## Get the direction of each folder
system.file("texts", "20Newsgroups", package = "tm")
Doc1.TestPath <- "/Library/Frameworks/R.framework/Versions/4.0/Resources/library/tm/texts/20Newsgroups/20news-bydate-test/sci.space"
Doc1.TrainPath <- "/Library/Frameworks/R.framework/Versions/4.0/Resources/library/tm/texts/20Newsgroups/20news-bydate-train/sci.space"
Doc2.TestPath <- "/Library/Frameworks/R.framework/Versions/4.0/Resources/library/tm/texts/20Newsgroups/20news-bydate-test/rec.autos"
Doc2.TrainPath <- "/Library/Frameworks/R.framework/Versions/4.0/Resources/library/tm/texts/20Newsgroups/20news-bydate-train/rec.autos"
Temp1 <- DirSource(Doc1.TestPath)
Temp2 <- DirSource(Doc1.TrainPath)
Temp3 <- DirSource(Doc2.TestPath)
Temp4 <- DirSource(Doc2.TrainPath)

##Only save the first 100 text document for each
Doc1.Test <- Corpus(URISource(Temp1$filelist[1:100]),readerControl=list(reader=readPlain))
Doc1.Train <- Corpus(URISource(Temp2$filelist[1:100]),readerControl=list(reader=readPlain))
Doc2.Test <- Corpus(URISource(Temp3$filelist[1:100]),readerControl=list(reader=readPlain))
Doc2.Train <- Corpus(URISource(Temp4$filelist[1:100]),readerControl=list(reader=readPlain))

##Obtain the merged Corpuus
Doc <- c(Doc1.Train,Doc1.Test,Doc2.Train,Doc2.Test)

##Preprocessing the text
transform.chr <- content_transformer(function(x, pattern) gsub(pattern, " ", x))
Doc <- tm_map(Doc, transform.chr, "@|#")    
Doc <- tm_map(Doc, removeNumbers)
Doc <- tm_map(Doc, removePunctuation)
Doc <- tm_map(Doc, removeWords, stopwords("english"))
Doc <- tm_map(Doc, removeWords, c("address","MA"))
Doc <- tm_map(Doc, stemDocument)

## Create the Document-Term Matrix and seperate the train/test range (Rec is positive and go first, Sci is negative go next)
dtm <- DocumentTermMatrix(Doc,control=list(wordLengths=c(2,Inf), bounds=list(global=c(5,Inf))))                  
train.doc <- dtm[c(201:300,1:100),]
test.doc <- dtm[c(301:400,101:200),]

## Create the tag factor for my classification
Tags <- factor(c(rep("Positive",100),rep("Negative",100)))
Tags <- factor(Tags, levels = rev((levels(Tags))))
table(Tags)

##Classifty text using the Knn() function
library(class)
set.seed(0)
prob.test <- knn(train.doc,test.doc, Tags, k=2, prob = TRUE)
prob.test


##Create a data frame to stored our knn output
RecClassified <- (prob.test==Tags)[1:100]
SciClassified <- (prob.test==Tags)[101:200]
a <- 1:length(prob.test)
b <- levels(prob.test)[prob.test]
c <- attr(prob.test,"prob")
d <- c(RecClassified,SciClassified)
result <- data.frame(Doc=a,Predict=b,Prob=c,Correct=d)
result
## Calculate the percentage of correct(TRUE) classifications
sum(result$Correct =="TRUE")/length(result$Doc)

##Create confusion matrix for classification
table(prob.test,Tags)
TP <- sum(RecClassified=="TRUE")
FP <- sum(RecClassified!="TRUE")
TN <- sum(SciClassified=="TRUE")
FN <- sum(SciClassified!="TRUE")
CM <- data.frame(Rec=c(TP,FN),Sci=c(FP,TN),row.names=c("Rec","Sci"))
CM

## Precision
Precision <- TP/(TP+FP)
Precision

## Recall
Recall <- TP/(TP+FN)
Recall

## F-Score
FScore <- 2*(Precision*Recall/(Precision+Recall))
FScore

