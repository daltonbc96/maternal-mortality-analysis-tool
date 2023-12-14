library(lubridate)
library(dplyr)

simulated_data <- function() {
  # Lendo os dados dos arquivos CSV
  mexico_data <- data.table::fread("server/data/mexico_data.csv")
  ecuador_data <- data.table::fread("server/data/ecuador_data.csv")
  
  # Criando uma lista onde os nomes são os países e os valores são os dataframes
  list_paises <- list("México" = mexico_data, "Ecuador" = ecuador_data)
  
  return(list_paises)
}

#xx <- simulated_data()


# # Função modificada para gerar a lista de países com dados sintéticos
# simulated_data <- function(start_year = 2015, end_year = 2021, num_records_per_day = 10, 
#                            countries = c("Brasil", "Estados Unidos", "Paraguay"), 
#                            exclude_vars = list(Brasil = c("idade"), "Estados Unidos" = c("asistencia"), Paraguai = NULL), 
#                            cie_codes = c("CIE-1", "CIE-2", "CIE-3", "CIE-4", "CIE-5", "CIE-6", "CIE-7", "CIE-8", "CIE-9", "CIE-10")) {
#   
#   # Função interna para gerar dados para um país
#   generate_data_for_country <- function(country, exclude_vars_for_country) {
#     dates <- seq(as.Date(paste(start_year, "-01-01", sep="")), 
#                  as.Date(paste(end_year, "-12-31", sep="")), by="day")
#     num_dates <- length(dates)
#     total_records <- num_dates * num_records_per_day  
#     
#     df <- data.frame(
#       pais = rep(country, total_records),
#       sexo = sample(c("M", "F"), total_records, replace = TRUE),
#       departamento = sample(c("Departamento A", "Departamento B", "Departamento C"), total_records, replace = TRUE),
#       municipio = sample(c("Municipio X", "Municipio Y", "Municipio Z"), total_records, replace = TRUE),
#       fecha_def = sample(dates, total_records, replace = TRUE), 
#       idade = sample(18:100, total_records, replace = TRUE),
#       escolaridade = sample(c("Primaria", "Secundaria", "Superior"), total_records, replace = TRUE),
#       causa = sample(cie_codes, total_records, replace = TRUE),
#       asistencia = sample(c("Sí", "No"), total_records, replace = TRUE),
#       grupo_edad = sample(c("10-19", "20-29", "30-39", "40-49", "50-54"), total_records, replace = TRUE)
#     )
#     
#     # Excluir variáveis conforme especificado para o país
#     df <- df[, !(names(df) %in% exclude_vars_for_country)]
#     
#     return(df)
#   }
#   
#   # Gerar dados para cada país especificado
#   list_paises <- mapply(generate_data_for_country, countries, exclude_vars, SIMPLIFY = FALSE)
#   names(list_paises) <- countries
#   
#   return(list_paises)
# }
# 
# 
