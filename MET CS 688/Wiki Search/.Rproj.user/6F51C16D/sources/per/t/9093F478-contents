library(shiny)
library(tm)
library(stringi)
library(wordcloud)
# library(proxy)
source("WikiSearch.R")

shinyServer(function(input, output) {
  output$distPlot <- renderPlot({ 
    withProgress({
      setProgress(message = "Mining Wikipedia...")
      result <- SearchWiki(input$select)
    })
    wordcloud( names(result), result, scale=c(4,0.9), colors=brewer.pal(6, "Dark2"))
  })
})
