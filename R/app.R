library(shiny)
source("ui/gradescopeUI.R")
source("ui/localSubmissionsUI.R")
source("server/gradescopeServer.R")

ui <- navbarPage(title = "Autograding in R",
  tabPanel(
    "Gradescope",
    gradescopeUI('gradescope')
  ),
  tabPanel(
    "Running Locally",
    localUI("local")
  )
)


server <- function(input, output, session) {
  gradescopeServer("gradescope")
}

shinyApp(ui, server)
