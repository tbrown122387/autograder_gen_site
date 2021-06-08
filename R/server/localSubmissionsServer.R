localSubmissionsServer <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      output$textOutput <- renderText({
        input$sample
      })
    }
  )
}
