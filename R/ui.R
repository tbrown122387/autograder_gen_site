library(shiny)
ui <- fluidPage(
                tags$head(tags$script(src = "message-handler.js")),
                titlePanel("AutoGrade R"),
                fileInput(inputId = "file1", label="Step 1: Please Submit External Datasets ",multiple =TRUE, accept = c(".csv")),
                textOutput(outputId = "feedback1"),
                
                fileInput(inputId = "file2", label="Step 2: Please Submit the assignment submission expected from students (e.g. homework1.R) ",accept = c(".R")),
                textOutput(outputId = "feedback2"),
                
                fileInput(inputId = "file3", label="Step 3: Please Submit setup.sh ",accept = c(".sh")),
                textOutput(outputId = "feedback3"),
                
                fileInput(inputId = "file4", label="Step 4: Please Submit grade_one_submission.R ",accept = c(".R")),
                textOutput(outputId = "feedback4"),
                
                fileInput(inputId = "file5", label="Step 5: Please Submit run_autograder "),
                textOutput(outputId = "feedback5"),
                
                fileInput(inputId = "file6", label="Step 6: Please Submit the zip file ",accept = c(".zip")),
                textOutput(outputId = "feedback6"),
                
                
                actionButton("checkAll", "Click Me")
                
)
