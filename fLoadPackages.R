fLoadPackages <- function(...) {
  
  libs <- unlist(list(...))
  req <- unlist(lapply(X = libs, FUN = require, character.only=TRUE))
  need <- libs[req==FALSE]
  
  if(length(need)>0){ 
    install.packages(need)
    lapply(need,require,character.only=TRUE)
  }
}

fLoadPackages('odbc','RODBC','DBI','tidyverse')
