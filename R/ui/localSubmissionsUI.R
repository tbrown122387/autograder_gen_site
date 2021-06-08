localSubmissionsUI <- function(id, label = "localUI") {
  ns <- NS(id)

  tagList(
    titlePanel("Generate a grading bundle to run locally"),
    textInput(
      inputId = ns("sample"),
      label = "Sample Text Input",
      placeholder = "Enter text here!"
    ),
    textOutput(outputId = ns("sampleOutput"))
  )
}
