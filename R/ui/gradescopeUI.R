gradescopeUI <- fluidPage(
  tags$head(tags$script(src = "message-handler.js")),
  titlePanel("AutoGrade R"),
  textInput(
    "assignment.name",
    "Step 1: Please submit an assignment name",
    placeholder = "Ex: assignment01.R"
  ),
  fileInput(
    inputId = "datasets",
    label = "Step 2: Please submit external datasets (optional)",
    multiple = TRUE,
    accept = c(".csv")
  ),
  textOutput(outputId = "feedback.datasets"),
  textInput(
    "packages",
    "Step 3: Type in any additional packages needed, with a comma between packages (optional)",
    placeholder = "Ex: tidyverse, survival"
  ),
  strong("Step 4: Write tests that result in a Boolean"),
  sidebarLayout(
    sidebarPanel = sidebarPanel(
      actionButton("addTests", "Add Tests"),
      actionButton("removeTests", "Remove Tests", style = "center")
    ),
    mainPanel = mainPanel(
      column(
        4,
        textInput("test.label",
                  label = "Question Number",
                  placeholder = "Ex: Question 1a."
        )
      ),
      column(
        4,
        textInput("test.content",
                  label = "Test that results in Boolean",
                  placeholder = "Ex: sum(q1) == 4"
        )
      ),
      column(
        4,
        selectInput("test.visibility",
                    label = "Visibility",
                    choices = c("visible", "hidden", "after_due_date", "after_published")
        )
      ),
      id = "mainPanel"
    )
  ),
  downloadButton("downloadZip", "Download Zip File"),
  actionButton("checkAll", "Click Me"),
)
