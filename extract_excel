extract_excel <- function(PathExcel)
{

  #=============================================================================

  # PRE DOWNLOAD

  # -- console output --

  cli::cli_alert_info("Downloading DB from Excel extract...")

  # Get a list of all of the files in the Path location

  ListOfFiles <- list.files(PathExcel)

  ListOfFiles <- grep('~$', ListOfFiles, fixed = TRUE, value = TRUE, invert = TRUE)

  DatesFromFiles <- lubridate::dmy(stringr::str_remove_all(ListOfFiles, "[:alpha:]|[:punct:]"))

  ListOfFilesDF <- data.frame(FileName = ListOfFiles, CreatedDate = DatesFromFiles)

  # -- console output -- Log number of files

  cli::cli_alert("Found {length(ListOfFiles)} file{?s}.")  

  # Get the name of the latest excel file

  FileName <- paste0(PathExcel, "/", ListOfFilesDF[which.max(ListOfFilesDF$CreatedDate), 1])

  SheetNames <- FileName %>% readxl::excel_sheets()

  #=============================================================================

  # DOWNLOAD

  # -- console output --

  cli::cli_alert("Latest file: {FileName}")

  DataExtracted <- list()

  start.time <- Sys.time()

  cli::cli_progress_bar("Loading data", total = length(SheetNames))

  for (i in 1:length(SheetNames)){

    TableLoad <- SheetNames[i]

    DataExtracted[[TableLoad]] <- read_excel(FileName, sheet = TableLoad)

    # update visual cue

    cli::cli_progress_update()

  }

  end.time <- Sys.time()

  time.taken <- end.time - start.time

  time.taken <- time.taken[[1]]

  size <- object.size(DataExtracted)[1]

  # -- console output --

  if (length(DataExtracted) == length(SheetNames)){

    cli::cli_alert(c(

      "Downloaded {length(DataExtracted)} sheets with a size of {prettyunits::pretty_bytes(size)} in ",

      "{prettyunits::pretty_sec(time.taken)}"))

  }

  # Close download progress bar

  cli::cli_progress_done()

  #=============================================================================

  # POST DOWNLOAD

  DataExtracted$ExtractDate <- ListOfFilesDF[which.max(ListOfFilesDF$CreatedDate), 2]

  # -- console output --

  cli::cli_alert_success("PCCR Database Downloaded")

  return(DataExtracted)

}
