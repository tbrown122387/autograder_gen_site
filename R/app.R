library(shiny)
source("ui/gradescopeUI.R")
source("server/gradescopeServer.R")

ui <- tabsetPanel(
  tabPanel("Gradescope",
    gradescopeUI
  ),
  tabPanel("Local")
)
  
  
server <- gradescopeServer

shinyApp(ui, server)