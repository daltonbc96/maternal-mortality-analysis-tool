filterData <- function(lista_paises, paisInput, deptoInput, muniInput, fechaInicioInput, fechaFinalInput) {
  if (paisInput != "") {
    dados <- lista_paises[[paisInput]]
    if (deptoInput != "") {
      dados <- subset(dados, nivel_adm_1 == deptoInput)
    }
    if (muniInput != "") {
      dados <- subset(dados, nivel_adm_2 == muniInput)
    }
    dados <- subset(dados, date_ocur >= fechaInicioInput & date_ocur <= fechaFinalInput)
    return(dados)
  } else {
    return(NULL)
  }
}




# filterData <- function(lista_paises, paisInput, deptoInput, muniInput, fechaInicioInput, fechaFinalInput) {
#   if (paisInput != "") {
#     library(duckdb)
#     library(dplyr)
#     
#     # Conectar o dataframe ao DuckDB
#     con <- duckdb::dbConnect(duckdb::duckdb(), ":memory:")
#     on.exit(duckdb::dbDisconnect(con, shutdown = TRUE)) # Garantir desconexão ao sair da função
#     
#     # Registrar o dataframe desejado no DuckDB
#     dados <- lista_paises[[paisInput]]
#     duckdb::duckdb_register(con, "dados", dados)
#     
#     # Criar objeto tbl do DuckDB e aplicar os filtros
#     dados_filtrados <- dplyr::tbl(con, "dados") %>%
#       dplyr::filter(departamento == deptoInput | deptoInput == "") %>%
#       dplyr::filter(municipio == muniInput | muniInput == "") %>%
#       dplyr::filter(fecha_def >= fechaInicioInput, fecha_def <= fechaFinalInput)
#     
#     # Coletar os dados filtrados
#     dados_finais <- dplyr::collect(dados_filtrados)
#     
#     return(dados_finais)
#   } else {
#     return(NULL)
#   }
# }




