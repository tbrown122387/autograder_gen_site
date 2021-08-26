gradescopeUI <- function(id, label = "gradescopeUI") {
  ns <- NS(id)

  tagList(
    tags$head(tags$script(src = "message-handler.js")),
    textInput(
      inputId = ns("assignmentName"),
      label = "Step 1: Please submit an assignment name",
      placeholder = "Ex: assignment01.R"
    ),
    fileInput(
      inputId = ns("datasets"),
      label = "Step 2: Please submit external datasets (optional)",
      multiple = TRUE,
      accept = c(".csv")
    ),
    textOutput(outputId = ns("feedbackDatasets")),
    
    ## Add packages
    textInput(
      inputId = ns("packages"),
      label = "Step 3: Type in any additional packages needed, with a comma between packages (optional)",
      placeholder = "Ex: tidyverse, survival"
    ),
    actionButton(ns("addPackages"), "Add Packages"),
    textOutput(outputId = ns("packagename")),
    
    sidebarLayout(
      sidebarPanel = sidebarPanel(
        actionButton(ns("addTests"), "Add Tests"),
        actionButton(ns("removeTests"), "Remove Tests", style = "center")
      ),
      mainPanel = mainPanel(
        column(
          4,
          textInput(ns("testLabel"),
            label = "Question Number",
            placeholder = "Ex: Question 1a."
          )
        ),
        column(
          4,
          textInput(ns("testContent"),
            label = "Test that results in Boolean",
            placeholder = "Ex: sum(q1) == 4"
          )
        ),
        column(
          4,
          selectInput(ns("testVisibility"),
            label = "Visibility",
            choices = c("visible", "hidden", "after_due_date", "after_published")
          )
        ),
        id = "mainPanel"
      )
    ),
    downloadButton(ns("downloadZip"), "Download Zip File"),
    actionButton(ns("checkAll"), "Click Me"),
  )
}
