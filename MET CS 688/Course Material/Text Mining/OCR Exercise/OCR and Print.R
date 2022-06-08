# OCR PDF page, Find Coordinates and recreate page with OCR'ed text
rm(list=ls()); cat("\014") # Clear Workspace and Console
library(tesseract)
library(grid)
eng <- tesseract("eng")
pdf.file <- normalizePath(list.files(path = "Data/", pattern = "pdf",  full.names = TRUE))[1]
pdf.file <- "Data/135737664.pdf"

image.file <- pdftools::pdf_convert(pdf.file, format = 'tiff', pages = 1, dpi = 400)
results <- tesseract::ocr_data(image.file, engine = eng)
results.XML <- tesseract::ocr(image.file, engine = eng, HOCR=TRUE)
results

# Get Words & their coordiates
words <- unlist(lapply(results$word, function(x)  x))
wcoord <- do.call('rbind', lapply(results$bbox, function(x) as.numeric( unlist(strsplit(x, ",")))))

# Re-Scale coordinates
z <- data.frame(words=words, coord=wcoord, stringsAsFactors = FALSE)
co.x <- z$coord.1/max(z$coord.1); co.y <- (max(z$coord.2) - z$coord.2)/max(z$coord.2)
zz <- data.frame(words=words, x=co.x, y=co.y, stringsAsFactors = FALSE)


# ==== Plot extracted text into a grid
grid.newpage()
draw.text <- function(txt, x, y, just) {
  grid.text(txt, x, y, just=just, gp=gpar(col="grey", fontsize=8))
  # grid.text(txt, x=x[j], y=y[i], just=just)
  # grid.text(deparse(substitute(just)), x=x[j], y=y[i] + unit(2, "lines"),
  #           gp=gpar(col="grey", fontsize=8))
}


draw.text(zz$words, zz$x, zz$y, "left")

