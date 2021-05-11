# template 3 file input
library(shiny)
ui <- fluidPage(titlePanel("AutoGrade R User Interface Demo 1"),
                fileInput(inputId = "file1", label="Step 1: Please Submit External Datasets "),
                textOutput(outputId = "feedback1"),
                
                fileInput(inputId = "file2", label="Step 2: Please Submit hw1_test_file.R "),
                textOutput(outputId = "feedback2"),
                
                fileInput(inputId = "file3", label="Step 3: Please Submit setup.sh "),
                textOutput(outputId = "feedback3"),
                
                fileInput(inputId = "file4", label="Step 4: Please Submit grade_one_submission.R "),
                textOutput(outputId = "feedback4"),
                
                fileInput(inputId = "file5", label="Step 5: Please Submit run_autograder "),
                textOutput(outputId = "feedback5"),
                
                fileInput(inputId = "file6", label="Step 6: Please Submit the zip file "),
                textOutput(outputId = "feedback6")
                
)
server <- function(input, output){
  output$feedback1 <- renderText({
    file1_state <- !is.null(input$file1)
    if (file1_state) {
      "File Submitted Successfully."
    }
    else{"File Not Yet Submitted."}
  })
  output$feedback2 <- renderText({
    file1_state <- !is.null(input$file2)
    if (file1_state) {
      "File Submitted Successfully."
    }
    else{"File Not Yet Submitted."}
  })
  output$feedback3 <- renderText({
    file1_state <- !is.null(input$file3)
    if (file1_state) {
      "File Submitted Successfully."
    }
    else{"File Not Yet Submitted."}
  })
  output$feedback4 <- renderText({
    file1_state <- !is.null(input$file4)
    if (file1_state) {
      "File Submitted Successfully."
    }
    else{"File Not Yet Submitted."}
  })
  output$feedback5 <- renderText({
    file1_state <- !is.null(input$file5)
    if (file1_state) {
      "File Submitted Successfully."
    }
    else{"File Not Yet Submitted."}
  })
  output$feedback6 <- renderText({
    file1_state <- !is.null(input$file6)
    if (file1_state) {
      "File Submitted Successfully."
    }
    else{"File Not Yet Submitted."}
  })
}
shinyApp(ui = ui, server = server)