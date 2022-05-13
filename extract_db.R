extract_db <- function()
{
  # connect to base data server and db
  DBConnectionOutput <- DBI::dbConnect(odbc::odbc(), 
                     Driver   = "SQL Server",
                     Server   = "ServerName",                       
                     Database = "DatabaseName", 
                     Port     = 50000,
                     UID = Sys.getenv("UID"),
                     PWD = Sys.getenv("PWD")
  )

  # Load data using a query
  DataQuery <- "SELECT * FROM "

  DataExtracted <- list()
  DataExtracted$Table   <-  DBI::dbGetQuery(DBConnectionOutput, paste0(DataQuery, "TableName"))

 return(DataExtracted)
}
