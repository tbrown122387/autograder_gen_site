gradescopeUI <- function(id, label = "gradescopeUI") {
  ns <- NS(id)

  tagList(
    tags$head(tags$script(src = "message-handler.js")),
    textInput(
      inputId = ns("assignmentName"),
      label = "Step 1: Please write the name of each student's submission file. Each student's submission must be named this (case sensitive), or else it will not be graded.",
      placeholder = "Ex: assignment01.R"
    ),
    fileInput(
      inputId = ns("datasets"),
      label = "Step 2: Please upload all external data sets that are used in the assignment (optional).",
      multiple = TRUE,
      accept = c(".csv")
    ),
    textOutput(outputId = ns("feedbackDatasets")),
    textInput(
      inputId = ns("packages"),
      label = "Step 3: Type in all required third-party packages in a comma-separated string (optional).",
      placeholder = "Ex: tidyverse, survival"
    ),
    sidebarLayout(
      sidebarPanel = sidebarPanel(
        actionButton(ns("addTests"), "Add A Test"),
        actionButton(ns("removeTests"), "Remove A Test", style = "center")
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
    downloadButton(ns("downloadZip"), "Download Zip File")
    #actionButton(ns("checkAll"), "Click Me"),
  )
}
