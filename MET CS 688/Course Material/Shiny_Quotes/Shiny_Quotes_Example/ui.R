# ui.R 
library(shiny)

  
# Define UI for application 
shinyUI(fluidPage(
  
  # Application title (Panel 1)
  titlePanel("Quotes Search App"), 
  
  # Widget (Panel 2) 
  sidebarLayout(
    sidebarPanel(h3("Search panel"),
                 
                 # Search for
                 textInput("text.Search", label = h5("Get quotes for"), 
                           value = "AAPL"),
                 
                 # Start Search
                 submitButton("Results")

  ),
  # Display Panel (Panel 3)
    mainPanel(                   
      h1("Display Panel",align = "center"),
      htmlOutput("text1")
    )

  )
  
))





