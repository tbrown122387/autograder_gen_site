##
##  TODO: These functions all create files in the R/ directory, which works locally, 
##  but isn't great long term. I think using temp files or keeping the files in-memory 
##  would help when multiple people are using the website.
##

genSetupScript <- function(packageNames) {
  stopifnot(is.character(packageNames))
  scriptLines <- vector(
    mode = "character",
    length = 3 + length(packageNames)
  )
  # boilerplate
  scriptLines[1] <- "#!/usr/bin/env bash"
  scriptLines[2] <- "apt-get install -y libxml2-dev libcurl4-openssl-dev libssl-dev
"
  scriptLines[3] <- "apt-get install -y r-base"
  # add user-requested packages
  idx <- 4
  for (pkg in packageNames) {
    scriptLines[idx] <- paste0(
      'Rscript -e "install.packages(\'',
      pkg,
      '\')"'
    )
    idx <- idx + 1
  }
  # write all of the text out as a bash script text file
  fileConn <- file("setup.sh")
  writeLines(scriptLines, fileConn)
  close(fileConn)
}

genRunAutograder <- function(assignment.name) {
  stopifnot(is.character(assignment.name))
  scriptLines <- vector(mode = "character", length = 4)

  copyFileLine <- sprintf("cp /autograder/submission/%s /autograder/source/%s", assignment.name, assignment.name)
  scriptLines[1] <- "#!/usr/bin/env bash"
  scriptLines[2] <- copyFileLine
  scriptLines[3] <- "cd /autograder/source"
  scriptLines[4] <- "Rscript grade_one_submission.R"
  fileConn <- file("run_autograder")
  writeLines(scriptLines, fileConn)
  close(fileConn)
}

genTestFile <- function(all.tests) {
  scriptLines <- vector(mode = "character", length = length(all.tests) * 2 + 1)
  scriptLines[1] <- "library(testthat)"
  for (i in 1:length(all.tests)) {
    oneTest <- all.tests[[i]]
    scriptOneTest <- makeOneTest(oneTest[1], oneTest[2], oneTest[3])
    scriptLines[[i * 2]] <- scriptOneTest[1]
    scriptLines[[i * 2 + 1]] <- scriptOneTest[2]
  }
  fileConn <- file("run_tests.R")
  writeLines(scriptLines, fileConn)
  close(fileConn)
}

makeOneTest <- function(label, content, visibility) {
  scriptLines <- vector(mode = "character", length = 2)
  scriptLines[1] <- sprintf("test_that('%s (%s)', {", label, visibility)
  scriptLines[2] <- sprintf("expect_true(%s)})", content)
  scriptLines
}

genGradeOneScript <- function(assignment.name) {
  scriptLines <- vector(mode = "character", length = 2)
  scriptLines[1] <- "library(gradeR)"
  scriptLines[2] <- sprintf("calcGradesForGradescope('%s', 'run_tests.R')", assignment.name)
  fileConn <- file("grade_one_submission.R")
  writeLines(scriptLines, fileConn)
  close(fileConn)
}
