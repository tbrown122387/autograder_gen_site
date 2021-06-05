localUI <- function(id, label = "localUI") {
  ns <- NS(id)

  tagList(
    titlePanel("Local Grading"),
    textInput(inputId = ns("folderName"), label = "Folder Name")
  )
}
