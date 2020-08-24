

library(shiny)

# Define UI for application that draws a clusplot
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Red or White?"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
        helpText("Using characteristics determine the type of wines"),
        numericInput("residual.sugar", "the amount of sugar remaining after fermentation stops", 3.00, min = 0.60, max = 65.80, step=0.1),
        numericInput("alcohol", "the percent alcohol content of the wine", 10.30, min = 8.00, max = 14.90, step=0.1)
        
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("Plot"),
       h4("Confusion matrix of prediction:"),
       verbatimTextOutput("output")
    )
  )
))
