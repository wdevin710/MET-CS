# server.R 
library(shiny)
library(quantmod)

# Define server logic required to implement search
shinyServer(function(input, output) {
  
  output$text1 <- renderUI({ 
    Str1 <- paste("You have searched forquotes on:", toupper(input$text.Search))

    result <- getQuote(toupper(input$text.Search), what=yahooQF("Last Trade (Price Only)"))

    dataOutput <- paste("<li>",strong(result),"</li>")
    Str2 <- "Search Results:"
    HTML(paste(Str1, Str2, dataOutput, sep = '<br/>'))
  })


})




  
