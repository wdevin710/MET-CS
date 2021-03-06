# Tesseract and Other Languages
rm(list=ls()); cat("\014") # Clear Workspace and Console
library("tesseract")

# Use the tesseract_download() function to install additional languages:
# tesseract_download("deu")

(german <- tesseract("deu"))
text <- ocr("Data/127193473.png", engine = german)

cat(text) # Display in Console
cat(as(text, "character"), sep = "\n", file = 'Data/Image_1.txt', 
    append = FALSE) # Save as txt file

# Another way to save data to a file
WriteDocToText <- function(doc.Content, File.Name){ # Write content to a text file
  fileConn <- file(File.Name)
  writeLines(doc.Content, fileConn)
  close(fileConn)
}

WriteDocToText(text, 'Data/Image_1a.txt')

