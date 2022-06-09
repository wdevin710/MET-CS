# OCR Image to Extract Text and save it as searchable PDF
rm(list=ls()); cat("\014") # Clear Workspace and Console
library("tesseract"); library("magick")

file_name <- "Data/Image_1.jpg"
input <- image_read(file_name)

# 1) JPG => PNG 
input %>% 
  image_resize("2000x") %>%
  image_convert(type = 'Grayscale') %>%
  image_trim(fuzz = 40) %>%
  image_write('Data/Image_1.png', format = 'png', density = '300x300') 

# 2) OCR a PNG => PDF
png.file <- sub('.jpg','.png', file_name) 
pdf.file <- sub('.jpg','', file_name) 
system( paste("tesseract", png.file, pdf.file, ' -l eng pdf'), wait=TRUE)

