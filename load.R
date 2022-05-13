load <- function(DBConnections, DataTransformed){
   # Get current date and time
  Timestamp <- as.character(Sys.time())
  
  print(paste0("Timestamp: ", Timestamp))
  
  # for each df in this list of tables
  for (i in 1:length(DataTransformed)){
    DataTransformed[[i]]$Timestamp <- Timestamp
  }
  
  # Record Timestamp for update history
  DataTransformed$DP___UpdateHistory <- data.frame(Timestamp = Timestamp)
  
  cli::cli_alert_info("Storing data")
  
  #'''
  #'Description: Saves base data (all final tables) to database 
  #'''
  
  # Generate timestamp and create UpdateHistory table
  DataSaveList <- fTimestampData(DataTransformed)
  
  # Save all tables 
  for (i in names(DataSaveList)){
    print(i)
    
    if (i == "DataDictionary"){
      
      # overwrite previous Data Dictionary table
      DBI::dbWriteTable(conn = DBConnections$WriteCleanedDataConnection,
                        name = i,
                        value = DataSaveList[[i]],
                        overwrite = TRUE)
      
    } else {
      # append to existing tables
      DBI::dbWriteTable(conn = DBConnections$WriteCleanedDataConnection,
                        name = i,
                        value = DataSaveList[[i]],
                        append = TRUE)
    }
  }
}
