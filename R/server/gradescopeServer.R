source("gen_setup_script.R")

gradescopeServer <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      ns <- NS(id)

      ##
      ##  File input - external datasets
      ##
      output$feedbackDatasets <- renderText({
        datasetsState <- !is.null(input$datasets)
        if (datasetsState) {
          file.copy(input$datasets$datapath, input$datasets$name)
          paste(input$datasets$name, "Submitted Successfully.")
        }
        else {
          "File Not Yet Submitted."
        }
      })

      observeEvent(input$checkAll, {
        allState <- c(!is.null(input$datasets))
        if (!all(allState)) {
          session$sendCustomMessage(
            type = "testmessage",
            message = "One of files is missing!"
          )
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
                ns(paste0("testLabel", num.tests$count)),
                label = NULL
              )
            ),
            column(
              4,
              textInput(
                ns(paste0("testContent", num.tests$count)),
                label = NULL
              )
            ),
            column(
              4,
              selectInput(
                ns(paste0("testVisibility", num.tests$count)),
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
            all.tests <- list(c(input$testLabel, input$testContent, input$testVisibility))
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
            genSetupScript(c(packageNames, "gradeR")) # gradeR is needed
            genRunAutograder(input$assignmentName)
            genTestFile(all.tests)
            genGradeOneScript(input$assignmentName)

            files.to.zip <- c("run_tests.R", "setup.sh", "run_autograder", "grade_one_submission.R")
            if (!is.null(input$datasets)) {
              files.to.zip <- c(files.to.zip, input$datasets$name)
            }
            zip(file, files.to.zip)
          }
        )
    }
  )
}
