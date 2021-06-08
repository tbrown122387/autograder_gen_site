library(shiny)
source("ui/gradescopeUI.R")
source("ui/localSubmissionsUI.R")
source("server/gradescopeServer.R")
source("server/localSubmissionsServer.R")

ui <- navbarPage(title = "Autograding in R",
  tabPanel(
    "Gradescope",
    gradescopeUI('gradescope')
  ),
  tabPanel(
    "Running Locally",
    localSubmissionsUI("local")
  )
)


server <- function(input, output, session) {
  gradescopeServer("gradescope")
  localSubmissionsServer("local")
}

shinyApp(ui, server)
