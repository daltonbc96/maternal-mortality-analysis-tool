load_data <- function() {
  # Lendo los datos en CSV
  mexico_data <- data.table::fread("data/mexico_data.csv", colClasses = list(Date = "date_ocur"))
  ecuador_data <- data.table::fread("data/ecuador_data.csv", colClasses = list(Date = "date_ocur"))
  
  # Creación de una lista cuyos nombres son los países y cuyos valores son los marcos de datos
  list_paises <- list("México" = mexico_data, "Ecuador" = ecuador_data)
  
  return(list_paises)
}


db_list_countries <<- load_data()
