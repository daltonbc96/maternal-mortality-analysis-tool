load_data <- function() {
  # Lendo los datos en CSV
  mexico_data <- data.table::fread("data/mexico_data.csv")
  ecuador_data <- data.table::fread("data/ecuador_data.csv")
  
  # Creación de una lista cuyos nombres son los países y cuyos valores son los marcos de datos
  list_paises <- list("México" = mexico_data, "Ecuador" = ecuador_data)
  
  return(list_paises)
}


db_lista_paises <<- load_data()
