# OCR Image to Extract Text and save it as tetx file
rm(list=ls()); cat("\014") # Clear Workspace and Console
library("tesseract"); library("magick")

input <- image_read("Data/Image_1.jpg")

# 1) JPG => PNG => OCR => TXT
text <- input %>%
  image_resize("2000x") %>%
  image_convert(type = 'Grayscale') %>%
  image_trim(fuzz = 40) %>%
  image_write(format = 'png', density = '300x300') %>%
  tesseract::ocr() 

# 2) OCR a PNG => TXT
cat(text) # Display in Console
cat(as(text, "character"), sep = "\n", file = 'Data/Image_1.txt', append = FALSE) # Save as txt file



