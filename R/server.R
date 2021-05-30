library(shiny)
server <- function(input, output,session){
  
  output$feedback1 <- renderText({
    file1_state <<- !is.null(input$file1)
    if (file1_state) {
      "File Submitted Successfully."
    }
    else{"File Not Yet Submitted."}
  })
  
  data <- reactive({
    inFile <- input$file1
    if(!is.null(inFile)){
      read.csv(inFile$datapath)    
    }
  })
  
  output$table1 <- renderTable(data())
  
  
  output$feedback2 <- renderText({
    file2_state <<- !is.null(input$file2)
    if (file2_state) {
      "File Submitted Successfully."
    }
    else{"File Not Yet Submitted."}
  })
  
  output$feedback3 <- renderText({
    file3_state <<- !is.null(input$file3)
    if (file3_state) {
      "File Submitted Successfully."
    }
    else{"File Not Yet Submitted."}
  })
  output$feedback4 <- renderText({
    file4_state <<- !is.null(input$file4)
    if (file4_state) {
      "File Submitted Successfully."
    }
    else{"File Not Yet Submitted."}
  })
  output$feedback5 <- renderText({
    file5_state <<- !is.null(input$file5)
    if (file5_state) {
      "File Submitted Successfully."
    }
    else{"File Not Yet Submitted."}
  })
  output$feedback6 <- renderText({
    file6_state <<- !is.null(input$file6)
    if (file6_state) {
      "File Submitted Successfully."
    }
    else{"File Not Yet Submitted."}
  })
  
  observeEvent(input$checkAll, {
    all_state = c(file1_state,file2_state,file3_state,file4_state,file5_state,file6_state)
    if(!all(all_state)){
      session$sendCustomMessage(type = 'testmessage',
                                message = 'One of the files is missing!')
    }
      
  })
  
}