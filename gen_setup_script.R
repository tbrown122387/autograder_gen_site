genSetupScript <- function(packageNames){
  stopifnot(is.character(packageNames))
  scriptLines <- vector(mode = "character", 
                        length = 3 + length(packageNames))
  # boilerplate
  scriptLines[1] <- "#!/usr/bin/env bash"
  scriptLines[2] <- "apt-get install -y libxml2-dev libcurl4-openssl-dev libssl-dev
"
  scriptLines[3] <- "apt-get install -y r-base"
  # add user-requested packages
  idx <- 4
  for(pkg in packageNames){
    scriptLines[idx] <- paste0('Rscript -e "install.packages(\'', 
                              pkg,
                              '\')"')
    idx <- idx + 1
  }
  # write all of the text out as a bash script text file
  fileConn<-file("setup.sh")
  writeLines(scriptLines, fileConn)
  close(fileConn)
}
