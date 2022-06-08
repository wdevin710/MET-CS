# OCR Image to Extract Text
rm(list=ls()); cat("\014") # Clear Workspace and Console
library("pdftools")
library("tesseract"); library("magick"); library('tabulizer')

# File Locations
pdf.file <- "Data/myPDFfile_pg1.pdf"
png.file <- "Data/myPDFfile_pg1.png"

# 1) Create PNG Image from PDF files (using  pdftools package)
pngfile <- pdf_convert(pdf.file, pages = 1, filenames = png.file, dpi = 100)

# 2) OCR a PNG => TXT
txt.file <- sub('.png','', png.file)
system( paste("tesseract", png.file, txt.file), wait=TRUE)




