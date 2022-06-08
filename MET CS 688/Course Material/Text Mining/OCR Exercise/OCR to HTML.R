# Convert image of scanned PDF file into HTML
rm(list=ls()); cat("\014") # Clear Workspace and Console
library("pdftools")
library("tesseract"); library("magick")

pdf.file <- "Data/www/myPDFfile_pg1.pdf"
png.file <- "Data/www/myPDFfile_pg1.png"
hocr.file <- "Data/www/myPDFfile_pg1.png"

# 1) Convert PDF => PNG
file.remove(png.file) # Remove existing PNG file
# system( paste("convert -density 200", pdf.file, '-alpha remove -quality 200 -scale 125%', png.file), wait=TRUE)
pdf.file <- pdf_convert(pdf.file, pages = 1, filenames = png.file, dpi = 200)

# 2) OCR the PNG file, Extract text & Create searchable HTML
system( paste("tesseract", png.file, hocr.file, ' --oem 1 -l eng hocr'), wait=TRUE) # OCR PNG & Convert to HTML 

# At the end just rename ".hocr" file into ".html" and open it in a browswer.


# Conversions from PNG to any other different type:  
# system( paste("tesseract", png.file, 'www/OCR/myPDFfile --oem 1 -l eng txt'), wait=TRUE) # OCR PNG => Text (oem=1 LSTM)
# system( paste("tesseract", png.file, 'www/OCR/myPDFfile --oem 1 -l eng alto'), wait=TRUE) # OCR PNG => Text same as text
# system( paste("tesseract", png.file, 'www/OCR/myPDFfile --oem 1 -l eng hocr'), wait=TRUE) # OCR PNG => XML (x1,y2,x2,y2)
# system( paste("tesseract", png.file, 'www/OCR/myPDFfile --oem 1 -l eng tsv'), wait=TRUE) # OCR PNG => TSV (x,y,w,h)
# system( paste("tesseract", png.file, 'www/OCR/myPDFfile --oem 1 -l eng makebox'), wait=TRUE) # OCR PNG => Letter Coord (x1,y2,x2,y2)
# system( paste("tesseract", png.file, 'www/OCR/myPDFfile --oem 1 -l eng pdf'), wait=TRUE) # OCR PNG => PDF
