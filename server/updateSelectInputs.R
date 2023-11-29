updateSelectInputs <- function(input, session, lista_paises, paisInputId, deptoInputId, muniInputId, fechaInicioId, fechaFinalId) {
  # Atualiza departamentos e datas com base no país
  observeEvent(input[[paisInputId]], {
    pais_escolhido <- input[[paisInputId]]
    if (pais_escolhido != "") {
      dados_pais <- lista_paises[[pais_escolhido]]
      
      # Atualiza departamentos
      departamentos <- unique(dados_pais$departamento)
      updateSelectInput(session, deptoInputId, choices = c("", departamentos))
      
      # Atualiza datas e define os valores padrão
      minDate <- min(dados_pais$fecha_def)
      maxDate <- max(dados_pais$fecha_def)
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
      dados_filtrados <- subset(dados_pais, departamento == depto_escolhido)
      
      # Atualiza municípios
      municipios <- unique(dados_filtrados$municipio)
      updateSelectInput(session, muniInputId, choices = c("", municipios))
    }
  })
}

