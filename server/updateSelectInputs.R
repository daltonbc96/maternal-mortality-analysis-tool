updateSelectInputs <- function(input, session, lista_paises, paisInputId, deptoInputId, muniInputId, fechaInicioId, fechaFinalId) {
  # Atualiza departamentos e datas com base no país
  observeEvent(input[[paisInputId]], {
    pais_escolhido <- input[[paisInputId]]
    if (pais_escolhido != "") {
      dados_pais <- lista_paises[[pais_escolhido]]
    
      # Atualiza departamentos em ordem alfabética
      departamentos <- unique(dados_pais$nivel_adm_1)
      departamentos <- sort(departamentos)
      updateSelectInput(session, deptoInputId, choices = c("", departamentos))
      
      # Converte as datas para o formato correto e atualiza as datas
      dados_pais$date_ocur <- as.Date(dados_pais$date_ocur, format = "%Y-%m-%d")
      minDate <- min(dados_pais$date_ocur, na.rm = TRUE)
      maxDate <- max(dados_pais$date_ocur, na.rm = TRUE)
      updateDateInput(session, fechaInicioId, min = minDate, max = maxDate, value = minDate)
      updateDateInput(session, fechaFinalId, min = minDate, max = maxDate, value = maxDate)
    }
  })
  
  # Atualiza municípios com base no departamento escolhido
  observeEvent(list(input[[paisInputId]], input[[deptoInputId]]), {
    pais_escolhido <- input[[paisInputId]]
    depto_escolhido <- input[[deptoInputId]]
    if (pais_escolhido != "" && depto_escolhido != "") {
      dados_pais <- lista_paises[[pais_escolhido]]
      dados_filtrados <- subset(dados_pais, nivel_adm_1 == depto_escolhido)
      
      # Atualiza municípios em ordem alfabética
      municipios <- unique(dados_filtrados$nivel_adm_2)
      municipios <- sort(municipios)
      updateSelectInput(session, muniInputId, choices = c("", municipios))
    }
  })
}



# updateSelectInputs <- function(input, session, lista_paises, paisInputId, deptoInputId, muniInputId, fechaInicioId, fechaFinalId) {
#   library(shiny)
#   library(duckdb)
#   library(dplyr)
#   
#   # Atualiza departamentos e datas com base no país
#   observeEvent(input[[paisInputId]], {
#     pais_escolhido <- input[[paisInputId]]
#     if (pais_escolhido != "") {
#       con <- duckdb::dbConnect(duckdb::duckdb(), ":memory:")
#       on.exit(duckdb::dbDisconnect(con, shutdown = TRUE))
#       dados_pais <- lista_paises[[pais_escolhido]]
#       duckdb::duckdb_register(con, "dados_pais", dados_pais)
#       
#       dados_db <- dplyr::tbl(con, "dados_pais")
#       
#       # Atualiza departamentos
#       departamentos <- dados_db %>%
#         dplyr::distinct(departamento) %>%
#         dplyr::arrange(departamento) %>%
#         dplyr::collect() %>%
#         `[[`("departamento")
#       updateSelectInput(session, deptoInputId, choices = c("", departamentos))
#       
#       # Atualiza datas e define os valores padrão
#       minDate <- dados_db %>% dplyr::summarise(minDate = min(fecha_def)) %>% dplyr::collect() %>% `[[`("minDate")
#       maxDate <- dados_db %>% dplyr::summarise(maxDate = max(fecha_def)) %>% dplyr::collect() %>% `[[`("maxDate")
#       updateDateInput(session, fechaInicioId, min = minDate, max = maxDate, value = minDate)
#       updateDateInput(session, fechaFinalId, min = minDate, max = maxDate, value = maxDate)
#     }
#   })
#   
#   # Atualiza municípios com base no departamento escolhido
#   observeEvent(list(input[[paisInputId]], input[[deptoInputId]]), {
#     pais_escolhido <- input[[paisInputId]]
#     depto_escolhido <- input[[deptoInputId]]
#     if (pais_escolhido != "" && depto_escolhido != "") {
#       con <- duckdb::dbConnect(duckdb::duckdb(), ":memory:")
#       on.exit(duckdb::dbDisconnect(con, shutdown = TRUE))
#       dados_pais <- lista_paises[[pais_escolhido]]
#       duckdb::duckdb_register(con, "dados_pais", dados_pais)
#       
#       dados_db <- dplyr::tbl(con, "dados_pais") %>%
#         dplyr::filter(departamento == depto_escolhido)
#       
#       # Atualiza municípios
#       municipios <- dados_db %>%
#         dplyr::distinct(municipio) %>%
#         dplyr::arrange(municipio) %>%
#         dplyr::collect() %>%
#         `[[`("municipio")
#       updateSelectInput(session, muniInputId, choices = c("", municipios))
#     }
#   })
# }
