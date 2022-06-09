# Exercise - Summarize the content of a PDF document 
rm(list=ls()); cat("\014") # Clear Workspace and Console
library(tm)
library(textmineR); library(igraph) 
source("Project_Functions.R")

# ==== 
# Load the PDF data
# pdf.loc <- file.path("data") # folder "PDF Files" with PDFs
# myFiles <- normalizePath(list.files(path = pdf.loc, pattern = "pdf",  full.names = TRUE)) # Get the path (chr-vector) of PDF file names
# # Extract content from PDF files
# Docs.corpus <- Corpus(URISource(myFiles), readerControl = list(reader = readPDF(engine = "xpdf")))

# ==== 
# Load TED Talks Data
myFiles <- normalizePath(list.files(path = "data", pattern = "txt",  full.names = TRUE))
Docs.corpus <- Corpus(URISource(myFiles), readerControl=list(reader=readPlain))

# Extract content of each document in a format needed by textmineR to find text summary
corpora <- data.frame()
for (ff in 1:length(Docs.corpus)) {
  doc.content <- Docs.corpus[[ff]]$content
  temp <- paste(doc.content, collapse = ""); #temp <- iconv(temp,"WINDOWS-1252","UTF-8")
  temp1 <- data.frame(content=temp, stringsAsFactors = FALSE)
  corpora <- rbind(corpora, temp1)
}

corpora$id <- seq_along(corpora$content) # enumerate documents with id

# Find summary for each Doc. 
Number.of.Sentences <- 7 # How many sentences will the summary have
Number.of.Topics <- 5 # Number of topics per document.
sums <- embedding(corpora, Number.of.Sentences, Number.of.Topics) # Generate summary for each Document
sums

