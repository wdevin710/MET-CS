# Analyze MLD GS Language Detection
rm(list=ls()); cat("\014") # Clear Workspace and Consolelibrary("cld2"); library("cld3")
library("readr"); library("magrittr")

# 1) Your Code HERE: Load the file names that need to be processed into "files.txt"
files.txt <- list.files('Data/sentence data', pattern ="txt")

## CLD2
Result.cld2.DF <- data.frame()
for (ff in 1:length(files.txt)) { 
  fn <- files.txt[ff]
  txt.data <- read_tsv(paste0('Data/sentence data/', fn))
  Lg.Data.Code <- cld2::detect_language(txt.data[[1]]) # Get Language Code
  Lg.Data.Lg <- cld2::detect_language(txt.data[[1]], lang_code = FALSE) # Get Language
  Lg.Data.Code <- Lg.Data.Code[!is.na(Lg.Data.Code)]; Lg.Data.Lg <- Lg.Data.Lg[!is.na(Lg.Data.Lg)]  # Remove NA From Language Code & Language
  
  Predicted.Lg.Code <- names(sort(table(Lg.Data.Code), decreasing=TRUE)[1]) # Find Dominant Language Code 
  Predicted.Lg <- names(sort(table(Lg.Data.Lg), decreasing=TRUE)[1]) # Find Dominant Language 
  
  # 2) Your Code HERE: Extract the language 2 letter code from the file name ()
  GT.Lg <-  substr(fn,start = 10, stop = 11)# Extract the ground truth Language code from the file name (i.e. get "ar" from "sentence_ar.txt")
  Correct <- GT.Lg == Predicted.Lg.Code
  
  temp1 <- data.frame(GS_Lg_Code=GT.Lg, Pred_Lg_Code=Predicted.Lg.Code, Correct=Correct, Pred_Lg=Predicted.Lg, stringsAsFactors = FALSE)
  Result.cld2.DF <- rbind(Result.cld2.DF, temp1)
}

knitr::kable(Result.cld2.DF) # Display result of Language Detection

## CLD3
Result.cld3.DF <- data.frame()
for (ff in 1:length(files.txt)) { 
  fn <- files.txt[ff]
  txt.data <- read_tsv(paste0('Data/sentence data/', fn))
  Lg.Data.Code <- cld3::detect_language(txt.data[[1]]) # Get Language Code
  Lg.Data.Code <- Lg.Data.Code[!is.na(Lg.Data.Code)];   # Remove NA From Language Code & Language
  
  Predicted.Lg.Code <- names(sort(table(Lg.Data.Code), decreasing=TRUE)[1]) # Find Dominant Language Code 
  
  # 2) Your Code HERE: Extract the language 2 letter code from the file name ()
  GT.Lg <-  substr(fn,start = 10, stop = 11)# Extract the ground truth Language code from the file name (i.e. get "ar" from "sentence_ar.txt")
  Correct <- GT.Lg == Predicted.Lg.Code
  
  temp1 <- data.frame(GS_Lg_Code=GT.Lg, Pred_Lg_Code=Predicted.Lg.Code, Correct=Correct, stringsAsFactors = FALSE)
  Result.cld3.DF <- rbind(Result.cld3.DF, temp1)
}
knitr::kable(Result.cld3.DF)
