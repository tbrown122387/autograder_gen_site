library(shiny)
source("gen_setup_script.R")

server <- function(input, output, session) {
  load_state <- FALSE
  ##
  ##  File input - external datasets
  ##
  output$feedback.datasets <- renderText({
    datasets.state <- !is.null(input$datasets)
    if (datasets.state) {
      file.copy(input$datasets$datapath, input$datasets$name)
      paste(input$datasets$name, "Submitted Successfully.")
    }
    else {
      "File Not Yet Submitted."
    }
  })
  
  observeEvent(input$checkAll, {
    all_state <- c(!is.null(input$datasets))
    if (!all(all_state)) {
      session$sendCustomMessage(
        type = "testmessage",
        message = "One of files is missing!"
      )
    }
  })
  
  #load the required package by user input
  
  observeEvent(input$load,{
    if(input$packages!=""){
      packageslist <- strsplit(input$packages, ",")
      for (i in packageslist){
        install.packages(i)
      }
      load_state <<- TRUE
    }
  })
  
  output$feedback.packages <-renderText({
    if(load_state){
      paste(input$datasets$name, "Load package successfully.")
    }
  })

  ##
  ##  Dealing with user defined tests
  ##
  num.tests <- reactiveValues(count = 1)

  observeEvent(input$addTests, {
    insertUI("#mainPanel",
      where = "beforeEnd",
      ui = fluidRow(
        column(
          4,
          textInput(
            paste0("testLabel", num.tests$count),
            label = NULL
          )
        ),
        column(
          4,
          textInput(
            paste0("testContent", num.tests$count),
            label = NULL
          )
        ),
        column(
          4,
          selectInput(
            paste0("testVisibility", num.tests$count),
            label = NULL,
            choices = c("visible", "hidden", "after_due_date", "after_published")
          )
        )
      )
    )

    num.tests$count <- num.tests$count + 1
  })

  ##
  ## Removing Tests
  ##
  observeEvent(input$removeTests, {
    if (num.tests$count > 1) {
      num.tests$count <- num.tests$count - 1
      removeUI(selector = paste0("div:has(> #testLabel", num.tests$count, ")")) # TODO: need to investigate selector behavior
      removeUI(selector = paste0("div:has(> #testContent", num.tests$count, ")"))
      removeUI(selector = paste0("div:has(>> #testVisibility", num.tests$count, ")")) ## >> is needed because of selectInput(). It results in a nested div
    }
  })

  ##
  ##  Download the Zip
  ##
  output$downloadZip <-
    downloadHandler(
      filename = "autograder.zip",
      content = function(file) {
        all.tests <- list(c(input$test.label, input$test.content, input$test.visibility))
        if (num.tests$count > 1) {
          for (i in 1:(num.tests$count - 1)) {
            test.label <- input[[paste0("testLabel", i, sep = "")]]
            test.content <- input[[paste0("testContent", i, sep = "")]]
            test.visibility <- input[[paste0("testVisibility", i, sep = "")]]

            all.tests[[i + 1]] <- c(test.label, test.content, test.visibility)
          }
        }
        packageNames <- unlist(strsplit(gsub(" ", "", input$packages), ","))
        
        # 4 files needed for the autograding bundle
        genSetupScript(c(packageNames, "gradeR")) #gradeR is needed
        genRunAutograder(input$assignment.name) 
        genTestFile(all.tests)
        genGradeOneScript(input$assignment.name)
        
        files.to.zip <- c("run_tests.R", "setup.sh", "run_autograder", "grade_one_submission.R")
        if (!is.null(input$datasets)) {
          files.to.zip <- c(files.to.zip, input$datasets$name)
        }
        zip(file, files.to.zip)
      }
    )
  
}
