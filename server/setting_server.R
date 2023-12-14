library(shiny)
library(plotly)
library(dplyr)



source("server/mainFunctions/validationInputs.R")
source("server/mainFunctions/plots.R")
source("server/createCustomCard.R")
source("server/selectedIndicator.R")
source("server/updateSelectInputs.R")
source("server/filterData.R")

#source("server/renderScatterPlotlyGraph.R")

#source("server/simulatedData.R")
#source("server/renderizar_tabela.R")
#source("server/createBarPlot.R")
#source("server/createAreaPlot.R")





server <- function(input, output, session) {
  
  


  
  error_message11 <- reactiveVal()
  error_message22 <- reactiveVal()
  
  loadingStatus11 <- reactiveValues()
  loadingStatus22 <- reactiveValues()
  

  parent_items <- c("Número de Mortalidade Materna", "Número de Muertes por Aspectos Socio-Demográficos y de Atención", "Número de Muertes por Causas Específicas", "Indicadores Combinados")
  
  
  
  indicators_caracterizacion <- jsonlite::read_json("server/indicators/indicators_caracterizacion.json")
  
  #atribui labels ao shiny tree
  output$indicadores_tree_caracterizacion_1 <- renderTree({ 
    indicators_caracterizacion
  })
  
  output$indicadores_tree_caracterizacion_2 <- renderTree({ 
    indicators_caracterizacion
  })
  
  
  
  #atualizar campos de filtragem de acordo com lista de paises
  updateSelectInputs(input, session, lista_paises, "pais1", "departamento1", "municipio1", "fecha_inicio1", "fecha_final1")
  
  updateSelectInputs(input, session, lista_paises, "pais2", "departamento2", "municipio2", "fecha_inicio2", "fecha_final2")
  
  updateSelectInputs(input, session, lista_paises, "pais11", "departamento11", "municipio11", "fecha_inicio11", "fecha_final11")
  
  updateSelectInputs(input, session, lista_paises, "pais22", "departamento22", "municipio22", "fecha_inicio22", "fecha_final22")
  
  
  updateSelectInputs(input, session, lista_paises, "pais13", "departamento13", "municipio13", "fecha_inicio13", "fecha_final13")
  
  updateSelectInputs(input, session, lista_paises, "pais24", "departamento24", "municipio24", "fecha_inicio24", "fecha_final24")
  
  
  updateSelectInputs(input, session, lista_paises, "pais14", "departamento14", "municipio14", "fecha_inicio14", "fecha_final14")
  
  updateSelectInputs(input, session, lista_paises, "pais25", "departamento25", "municipio25", "fecha_inicio25", "fecha_final25")
  
  
  
  
  validateAndUpdateMessage(input, output, "pais11", "indicadores_tree_caracterizacion_1", error_message11, "btnGerar11", "error_message_display")
  
  validateAndUpdateMessage(input, output, "pais22", "indicadores_tree_caracterizacion_2", error_message22, "btnGerar22", "error_message_display2")
  
  
  
  showOrHideRowBasedOnSelection <- function(idRow) {
    observe({
      if (isValueSelected("listaCaracterizacion1", idRow) || isValueSelected("listaCaracterizacion2", idRow)) {
        shinyjs::show(idRow)
      } else {
        shinyjs::hide(idRow)
      }
    })
  }
  
  
  showOrHideRowBasedOnSelection("A34, O00-O99")
  showOrHideRowBasedOnSelection("ODS 3.1.1 A34, O00-O95, O98-O99")
  showOrHideRowBasedOnSelection("Por Causas Obstétricas Directas (A34, O00-O94) Y Obstétricas Indirectas (O98-O99)")
  showOrHideRowBasedOnSelection("Aborto O00-O07")
  showOrHideRowBasedOnSelection("Enfermedad Hipertensiva Del Embarazo, Edema Y Proteinuria O10-O16")
  showOrHideRowBasedOnSelection("Hemorragia Del Embarazo, Parto Y Puerperio O20, O44-O46, O67, O72")
  showOrHideRowBasedOnSelection("Sepsis Y Otras Infecciones Puerperales A34, O85-O86")
  showOrHideRowBasedOnSelection("Otras Complicaciones Principalmente Del Embarazo Y Parto O21, O23-O43, O47-O66, O68-O71, O73-O75")
  showOrHideRowBasedOnSelection("Otras Complicaciones Principalmente Puerperales O88-O92")
  showOrHideRowBasedOnSelection("Complicaciones Venosas En El Embarazo, Parto Y Puerperio O22, O87")
  showOrHideRowBasedOnSelection("Causas Obstétricas Indirectas Infecciosas O98")
  showOrHideRowBasedOnSelection("Causas Obstétricas Indirectas No Infeciosas O99")
  showOrHideRowBasedOnSelection("Muertes Maternas Tardías O96")
  showOrHideRowBasedOnSelection("Muertes Maternas Por Secuelas O97")
  showOrHideRowBasedOnSelection("Muerte Obstétrica De Causa No Especificada O95")
  showOrHideRowBasedOnSelection("Grupo De Edad 1 (10-19, 20-24, 25-29,30-39,40-49,50-54)")
  showOrHideRowBasedOnSelection("Grupo De Edad 2 (10-19,20-29,30-39, 40-54)")
  showOrHideRowBasedOnSelection("Lugar De Ocurrencia De La Defunción")
  showOrHideRowBasedOnSelection("Recibió Atención Medica Antes De Morir")
  showOrHideRowBasedOnSelection("Aseguramiento/Derechohabiencia")
  showOrHideRowBasedOnSelection("Ocupación")
  showOrHideRowBasedOnSelection("Estado Civil")
  showOrHideRowBasedOnSelection("Personal Que Certifico La Defunción")
  showOrHideRowBasedOnSelection("Por Causa Y Año")
  showOrHideRowBasedOnSelection("Por Causa Y Por Grupo De Edad 1")
  showOrHideRowBasedOnSelection("Por Causa Y Por Grupo De Edad 2")
  showOrHideRowBasedOnSelection("Por Causa Y Lugar De Defunción")
  showOrHideRowBasedOnSelection("Por Causa Y Atención Recibida")
  showOrHideRowBasedOnSelection("Grupo Étnico/Raza")
  
  
  
  
 
  
  dados_filtrados_caracterizacion_1 <- reactiveVal()
  
  
  observeEvent(input$btnGerar11, {
    updateGlobalSelections("listaCaracterizacion1", character(0))
    dados_filtrados_caracterizacion_1(NULL) 
   
    show_modal_spinner()

   
    dados_filtrados11 <- filterData(lista_paises, input$pais11, input$departamento11, input$municipio11, input$fecha_inicio11, input$fecha_final11)
    dados_filtrados_caracterizacion_1(dados_filtrados11)
    selectedValues1 <- getSelectedNames(input$indicadores_tree_caracterizacion_1, parent_items)
    updateGlobalSelections("listaCaracterizacion1", selectedValues1)
    
 
   
     
    
    # "Número de Mortalidade Materna"
    ## A34, O00-O99
    if ( isValueSelected("listaCaracterizacion1", "A34, O00-O99") && !is.null(dados_filtrados_caracterizacion_1())) {
      
      output$plotOutput11 <- renderUI({
        loadingStatus11$graph1 <- TRUE 
        plot <- createCustomCard("A34, O00-O99", createLinePlot(dados = dados_filtrados_caracterizacion_1(), timeVar = "date_ocur", xLabel =  "Período", yLabel=  "Número de Muertes", groupVar = "num_mortalidad_grupo_1", isMM = T))
        loadingStatus11$graph1 <- FALSE
        return(plot)
        
      })
      
    }else{

      output$plotOutput11 <- NULL
    }
    
    ## "ODS 3.1.1 A34, O00-O95, O98-O99"
    if (isValueSelected("listaCaracterizacion1", "ODS 3.1.1 A34, O00-O95, O98-O99") && !is.null(dados_filtrados_caracterizacion_1())) {
      output$plotOutput21 <- renderUI({
        loadingStatus11$graph2 <- TRUE
        plot <- createCustomCard("ODS 3.1.1 A34, O00-O95, O98-O99", createLinePlot(dados = dados_filtrados_caracterizacion_1(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes",groupVar = "num_mortalidad_grupo_2", isMM = T))
        loadingStatus11$graph2 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput21 <- NULL
    }
    
    ## "Por Causas Obstétricas Directas (A34, O00-O94) Y Obstétricas Indirectas (O98-O99)"
    if (isValueSelected("listaCaracterizacion1", "Por Causas Obstétricas Directas (A34, O00-O94) Y Obstétricas Indirectas (O98-O99)") && !is.null(dados_filtrados_caracterizacion_1())) {
      output$plotOutput31 <- renderUI({
        loadingStatus11$graph3 <- TRUE
        plot <- createCustomCard("Por Causas Obstétricas Directas (A34, O00-O94) Y Obstétricas Indirectas (O98-O99)", createLinePlot(dados = dados_filtrados_caracterizacion_1(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "num_mortalidad_grupo_3", isMM = T))
        loadingStatus11$graph3 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput31 <- NULL
    }
    
    ## "Aborto O00-O07"
    if (isValueSelected("listaCaracterizacion1", "Aborto O00-O07") && !is.null(dados_filtrados_caracterizacion_1())) {
      output$plotOutput41 <- renderUI({
        loadingStatus11$graph4 <- TRUE
        plot <- createCustomCard("Aborto O00-O07", createLinePlot(dados = dados_filtrados_caracterizacion_1(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "causa_aborto", isMM = T))
        loadingStatus11$graph4 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput41 <- NULL
    }
    
    
    
    
    ## "Enfermedad Hipertensiva Del Embarazo, Edema Y Proteinuria O10-O16"
    if (isValueSelected("listaCaracterizacion1", "Enfermedad Hipertensiva Del Embarazo, Edema Y Proteinuria O10-O16") && !is.null(dados_filtrados_caracterizacion_1())) {
      output$plotOutput51 <- renderUI({
        loadingStatus11$graph5 <- TRUE
        plot <- createCustomCard("Enfermedad Hipertensiva Del Embarazo, Edema Y Proteinuria O10-O16", createLinePlot(dados = dados_filtrados_caracterizacion_1(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "causa_enfermedad_hipertensiva", isMM = T))
        loadingStatus11$graph5 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput51 <- NULL
    }
    
    
    ## "Hemorragia Del Embarazo, Parto Y Puerperio O20, O44-O46, O67, O72"
    if (isValueSelected("listaCaracterizacion1", "Hemorragia Del Embarazo, Parto Y Puerperio O20, O44-O46, O67, O72") && !is.null(dados_filtrados_caracterizacion_1())) {
      output$plotOutput61 <- renderUI({
        loadingStatus11$graph6 <- TRUE
        plot <- createCustomCard("Hemorragia Del Embarazo, Parto Y Puerperio O20, O44-O46, O67, O72", createLinePlot(dados = dados_filtrados_caracterizacion_1(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "causa_hemorragia", isMM = T))
        loadingStatus11$graph6 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput61 <- NULL
    }
    
    ## "Sepsis Y Otras Infecciones Puerperales A34, O85-O86"
    if (isValueSelected("listaCaracterizacion1", "Sepsis Y Otras Infecciones Puerperales A34, O85-O86") && !is.null(dados_filtrados_caracterizacion_1())) {
      output$plotOutput71 <- renderUI({
        loadingStatus11$graph7 <- TRUE
        plot <- createCustomCard("Sepsis Y Otras Infecciones Puerperales A34, O85-O86", createLinePlot(dados = dados_filtrados_caracterizacion_1(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "causa_sepsis_infecciones_puerperales", isMM = T))
        loadingStatus11$graph7 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput71 <- NULL
    }
    
    ## "Otras Complicaciones Principalmente Del Embarazo Y Parto O21, O23-O43, O47-O66, O68-O71, O73-O75"
    if (isValueSelected("listaCaracterizacion1", "Otras Complicaciones Principalmente Del Embarazo Y Parto O21, O23-O43, O47-O66, O68-O71, O73-O75") && !is.null(dados_filtrados_caracterizacion_1())) {
      output$plotOutput81 <- renderUI({
        loadingStatus11$graph8 <- TRUE
        plot <- createCustomCard("Otras Complicaciones Principalmente Del Embarazo Y Parto O21, O23-O43, O47-O66, O68-O71, O73-O75", createLinePlot(dados = dados_filtrados_caracterizacion_1(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "causa_otras_complicaciones_embarazo_parto", isMM = T))
        loadingStatus11$graph8 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput81 <- NULL
    }
    
    ## "Otras Complicaciones Principalmente Puerperales O88-O92"
    if (isValueSelected("listaCaracterizacion1", "Otras Complicaciones Principalmente Puerperales O88-O92") && !is.null(dados_filtrados_caracterizacion_1())) {
      output$plotOutput91 <- renderUI({
        loadingStatus11$graph9 <- TRUE
        plot <- createCustomCard("Otras Complicaciones Principalmente Puerperales O88-O92", createLinePlot(dados = dados_filtrados_caracterizacion_1(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "causa_otras_complicaciones_embarazo_puerperales", isMM = T))
        loadingStatus11$graph9 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput91 <- NULL
    }
    
    ## "Complicaciones Venosas En El Embarazo, Parto Y Puerperio O22, O87"
    if (isValueSelected("listaCaracterizacion1", "Complicaciones Venosas En El Embarazo, Parto Y Puerperio O22, O87") && !is.null(dados_filtrados_caracterizacion_1())) {
      output$plotOutput101 <- renderUI({
        loadingStatus11$graph10 <- TRUE
        plot <- createCustomCard("Complicaciones Venosas En El Embarazo, Parto Y Puerperio O22, O87", createLinePlot(dados = dados_filtrados_caracterizacion_1(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "causa_complicaciones_venosas", isMM = T))
        loadingStatus11$graph10 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput101 <- NULL
    }
    
    ## "Causas Obstétricas Indirectas Infecciosas O98"
    if (isValueSelected("listaCaracterizacion1", "Causas Obstétricas Indirectas Infecciosas O98") && !is.null(dados_filtrados_caracterizacion_1())) {
      output$plotOutput111 <- renderUI({
        loadingStatus11$graph11 <- TRUE
        plot <- createCustomCard("Causas Obstétricas Indirectas Infecciosas O98", createLinePlot(dados = dados_filtrados_caracterizacion_1(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "causa_causas_obstetricas_indirectas_infecciosas", isMM = T))
        loadingStatus11$graph11 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput111 <- NULL
    }
    
    ## "Causas Obstétricas Indirectas No Infeciosas O99"
    if (isValueSelected("listaCaracterizacion1", "Causas Obstétricas Indirectas No Infeciosas O99") && !is.null(dados_filtrados_caracterizacion_1())) {
      output$plotOutput121 <- renderUI({
        loadingStatus11$graph12 <- TRUE
        plot <- createCustomCard("Causas Obstétricas Indirectas No Infeciosas O99", createLinePlot(dados = dados_filtrados_caracterizacion_1(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "causa_causas_obstetricas_indirectas_no_infecciosas", isMM = T))
        loadingStatus11$graph12 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput121 <- NULL
    }
    
    ## "Muertes Maternas Tardías O96"
    if (isValueSelected("listaCaracterizacion1", "Muertes Maternas Tardías O96") && !is.null(dados_filtrados_caracterizacion_1())) {
      output$plotOutput131 <- renderUI({
        loadingStatus11$graph13 <- TRUE
        plot <- createCustomCard("Muertes Maternas Tardías O96", createLinePlot(dados = dados_filtrados_caracterizacion_1(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "causa_muertes_maternas_tardias", isMM = T))
        loadingStatus11$graph13 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput131 <- NULL
    }
    
    ## "Muertes Maternas Por Secuelas O97"
    if (isValueSelected("listaCaracterizacion1", "Muertes Maternas Por Secuelas O97") && !is.null(dados_filtrados_caracterizacion_1())) {
      output$plotOutput141 <- renderUI({
        loadingStatus11$graph14 <- TRUE
        plot <- createCustomCard("Muertes Maternas Por Secuelas O97", createLinePlot(dados = dados_filtrados_caracterizacion_1(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "causa_muertes_maternas_por_secuelas", isMM = T))
        loadingStatus11$graph14 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput141 <- NULL
    }
    
    ## "Muerte Obstétrica De Causa No Especificada O95"
    if (isValueSelected("listaCaracterizacion1", "Muerte Obstétrica De Causa No Especificada O95") && !is.null(dados_filtrados_caracterizacion_1())) {
      output$plotOutput151 <- renderUI({
        loadingStatus11$graph15 <- TRUE
        plot <- createCustomCard("Muerte Obstétrica De Causa No Especificada O95", createLinePlot(dados = dados_filtrados_caracterizacion_1(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "causa_muerte_obstetrica_no_especificada", isMM = T))
        loadingStatus11$graph15 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput151 <- NULL
    }
    
    ## "Grupo De Edad 1 (10-19, 20-24, 25-29,30-39,40-49,50-54)"
    if (isValueSelected("listaCaracterizacion1", "Grupo De Edad 1 (10-19, 20-24, 25-29,30-39,40-49,50-54)") && !is.null(dados_filtrados_caracterizacion_1())) {
      output$plotOutput161 <- renderUI({
        loadingStatus11$graph16 <- TRUE
        plot <- createCustomCard("Grupo De Edad 1 (10-19, 20-24, 25-29,30-39,40-49,50-54)", createLinePlot(dados = dados_filtrados_caracterizacion_1(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "grupo_edad_1", isMM = T))
        loadingStatus11$graph16 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput161 <- NULL
    }
    
    ## "Grupo De Edad 2 (10-19,20-29,30-39, 40-54)"
    if (isValueSelected("listaCaracterizacion1", "Grupo De Edad 2 (10-19,20-29,30-39, 40-54)") && !is.null(dados_filtrados_caracterizacion_1())) {
      output$plotOutput171 <- renderUI({
        loadingStatus11$graph17 <- TRUE
        plot <- createCustomCard("Grupo De Edad 2 (10-19,20-29,30-39, 40-54)", createLinePlot(dados = dados_filtrados_caracterizacion_1(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "grupo_edad_2", isMM = T))
        loadingStatus11$graph17 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput171 <- NULL
    }
    
    
    ## "Lugar De Ocurrencia De La Defunción"
    if (isValueSelected("listaCaracterizacion1", "Lugar De Ocurrencia De La Defunción") && !is.null(dados_filtrados_caracterizacion_1())) {
      output$plotOutput181 <- renderUI({
        loadingStatus11$graph18 <- TRUE
        plot <- createCustomCard("Lugar De Ocurrencia De La Defunción", createLinePlot(dados = dados_filtrados_caracterizacion_1(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "lugar_ocur", isMM = T))
        loadingStatus11$graph18 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput181 <- NULL
    }
    
    ## "Recibió Atención Medica Antes De Morir"
    if (isValueSelected("listaCaracterizacion1", "Recibió Atención Medica Antes De Morir") && !is.null(dados_filtrados_caracterizacion_1())) {
      output$plotOutput191 <- renderUI({
        loadingStatus11$graph19 <- TRUE
        plot <- createCustomCard("Recibió Atención Medica Antes De Morir", createLinePlot(dados = dados_filtrados_caracterizacion_1(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "recebio_atencion", isMM = T))
        loadingStatus11$graph19 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput191 <- NULL
    }
    
    ## "Aseguramiento/Derechohabiencia"
    if (isValueSelected("listaCaracterizacion1", "Aseguramiento/Derechohabiencia") && !is.null(dados_filtrados_caracterizacion_1())) {
      output$plotOutput201 <- renderUI({
        loadingStatus11$graph20 <- TRUE
        plot <- createCustomCard("Aseguramiento/Derechohabiencia", createLinePlot(dados = dados_filtrados_caracterizacion_1(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "derechohab", isMM = T))
        loadingStatus11$graph20 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput201 <- NULL
    }
    
    
    ## "Ocupación"
    if (isValueSelected("listaCaracterizacion1", "Ocupación") && !is.null(dados_filtrados_caracterizacion_1())) {
      output$plotOutput211 <- renderUI({
        loadingStatus11$graph21 <- TRUE
        plot <- createCustomCard("Ocupación", createLinePlot(dados = dados_filtrados_caracterizacion_1(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "ocupacion", isMM = T))
        loadingStatus11$graph21 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput211 <- NULL
    }
    
    ## "Estado Civil"
    if (isValueSelected("listaCaracterizacion1", "Estado Civil") && !is.null(dados_filtrados_caracterizacion_1())) {
      output$plotOutput221 <- renderUI({
        loadingStatus11$graph22 <- TRUE
        plot <- createCustomCard("Estado Civil", createLinePlot(dados = dados_filtrados_caracterizacion_1(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "estado_civil", isMM = T))
        loadingStatus11$graph22 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput221 <- NULL
    }
    
    ## "Personal Que Certifico La Defunción"
    if (isValueSelected("listaCaracterizacion1", "Personal Que Certifico La Defunción") && !is.null(dados_filtrados_caracterizacion_1())) {
      output$plotOutput231 <- renderUI({
        loadingStatus11$graph23 <- TRUE
        plot <- createCustomCard("Personal Que Certifico La Defunción", createLinePlot(dados = dados_filtrados_caracterizacion_1(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "persona_certifico", isMM = T))
        loadingStatus11$graph23 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput231 <- NULL
    }
    
    #Tables
    ## "Por Causa Por año"
    if (isValueSelected("listaCaracterizacion1", "Por Causa Y Año") && !is.null(dados_filtrados_caracterizacion_1())) {
      output$plotOutput241 <- renderUI({
        loadingStatus11$graph24 <- TRUE
        plot <- createCustomCard("Por Causa Y Año", createTable(dados = dados_filtrados_caracterizacion_1(), timeVar = "date_ocur", groupVar = "causa_def", groupVar2 = NULL, nomeColuna1 = "Causa"))
        loadingStatus11$graph24 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput241 <- NULL
    }
    
    
    
    ## "Por Causa Y Por Grupo De Edad 1"
    if (isValueSelected("listaCaracterizacion1", "Por Causa Y Por Grupo De Edad 1") && !is.null(dados_filtrados_caracterizacion_1())) {
      output$plotOutput251 <- renderUI({
        loadingStatus11$graph25 <- TRUE
        plot <- createCustomCard("Por Causa Y Por Grupo De Edad 1", createTable(dados = dados_filtrados_caracterizacion_1(), timeVar = "date_ocur", groupVar = "causa_def", groupVar2 = "grupo_edad_1", nomeColuna1 = "Causa", nomeColuna2 = "Grupo Edad 1"))
        loadingStatus11$graph25 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput251 <- NULL
    }
    
    ## "Por Causa Y Por Grupo De Edad 2"
    if (isValueSelected("listaCaracterizacion1", "Por Causa Y Por Grupo De Edad 2") && !is.null(dados_filtrados_caracterizacion_1())) {
      output$plotOutput261 <- renderUI({
        loadingStatus11$graph26 <- TRUE
        plot <- createCustomCard("Por Causa Y Por Grupo De Edad 2", createTable(dados = dados_filtrados_caracterizacion_1(), timeVar = "date_ocur", groupVar = "causa_def", groupVar2 = "grupo_edad_2", nomeColuna1 = "Causa", nomeColuna2 = "Grupo Edad 2"))
        loadingStatus11$graph26 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput261 <- NULL
    }
    
    ## "Por Causa Y Lugar De Defunción"
    if (isValueSelected("listaCaracterizacion1", "Por Causa Y Lugar De Defunción") && !is.null(dados_filtrados_caracterizacion_1())) {
      output$plotOutput271 <- renderUI({
        loadingStatus11$graph27 <- TRUE
        plot <- createCustomCard("Por Causa Y Lugar De Defunción", createTable(dados = dados_filtrados_caracterizacion_1(), timeVar = "date_ocur", groupVar = "causa_def", groupVar2 = "lugar_ocur", nomeColuna1 = "Causa", nomeColuna2 = "Lugar De Defunción"))
        loadingStatus11$graph27 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput271 <- NULL
    }
    
    ## "Por Causa Y Atención Recibida"
    if (isValueSelected("listaCaracterizacion1", "Por Causa Y Atención Recibida") && !is.null(dados_filtrados_caracterizacion_1())) {
      output$plotOutput281 <- renderUI({
        loadingStatus11$graph28 <- TRUE
        plot <- createCustomCard("Por Causa Y Atención Recibida", createTable(dados = dados_filtrados_caracterizacion_1(), timeVar = "date_ocur", groupVar = "causa_def", groupVar2 = "recebio_atencion", nomeColuna1 = "Causa", nomeColuna2 = "Atención Recibida"))
        loadingStatus11$graph28 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput281 <- NULL
    }
 
    ## "Grupo Étnico/Raza"
    if (isValueSelected("listaCaracterizacion1", "Grupo Étnico/Raza") && !is.null(dados_filtrados_caracterizacion_1())) {
      output$plotOutput291 <- renderUI({
        loadingStatus22$graph29 <- TRUE
        plot <- createCustomCard("Grupo Étnico/Raza", createLinePlot(dados = dados_filtrados_caracterizacion_1(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "raza", isMM = T))
        loadingStatus22$graph29 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput291 <- NULL
    }
    
    
  }, ignoreNULL = FALSE)
  
  
  dados_filtrados_caracterizacion_2 <- reactiveVal()
  
  observeEvent(input$btnGerar22, {
    
    updateGlobalSelections("listaCaracterizacion2", character(0))
    dados_filtrados_caracterizacion_2(NULL) 
    
    show_modal_spinner()

    dados_filtrados22 <- filterData(lista_paises, input$pais22, input$departamento22, input$municipio22, input$fecha_inicio22, input$fecha_final22)
    dados_filtrados_caracterizacion_2(dados_filtrados22)
    selectedValues2 <- getSelectedNames(input$indicadores_tree_caracterizacion_2, parent_items)
    updateGlobalSelections("listaCaracterizacion2", selectedValues2)
    on.exit(updateGlobalSelections("listaCaracterizacion", character(0)))
    
    
    
    # "Número de Mortalidade Materna"
    ## A34, O00-O99
    if ( isValueSelected("listaCaracterizacion2", "A34, O00-O99") && !is.null(dados_filtrados_caracterizacion_2())) {
      output$plotOutput12 <- renderUI({
        loadingStatus22$graph1 <- TRUE 
        plot <- createCustomCard("A34, O00-O99", createLinePlot(dados = dados_filtrados_caracterizacion_2(), timeVar = "date_ocur", xLabel =  "Período", yLabel=  "Número de Muertes", groupVar = "num_mortalidad_grupo_1", isMM = T))
        loadingStatus22$graph1 <- FALSE
        return(plot)
        
      })
      
    }else{
      output$plotOutput12 <- NULL
    }
    
    ## "ODS 3.1.1 A34, O00-O95, O98-O99"
    if (isValueSelected("listaCaracterizacion2", "ODS 3.1.1 A34, O00-O95, O98-O99") && !is.null(dados_filtrados_caracterizacion_2())) {
      output$plotOutput22 <- renderUI({
        loadingStatus22$graph2 <- TRUE
        plot <- createCustomCard("ODS 3.1.1 A34, O00-O95, O98-O99", createLinePlot(dados = dados_filtrados_caracterizacion_2(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes",groupVar = "num_mortalidad_grupo_2", isMM = T))
        loadingStatus22$graph2 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput22 <- NULL
    }
    
    ## "Por Causas Obstétricas Directas (A34, O00-O94) Y Obstétricas Indirectas (O98-O99)"
    if (isValueSelected("listaCaracterizacion2", "Por Causas Obstétricas Directas (A34, O00-O94) Y Obstétricas Indirectas (O98-O99)") && !is.null(dados_filtrados_caracterizacion_2())) {
      output$plotOutput32 <- renderUI({
        loadingStatus22$graph3 <- TRUE
        plot <- createCustomCard("Por Causas Obstétricas Directas (A34, O00-O94) Y Obstétricas Indirectas (O98-O99)", createLinePlot(dados = dados_filtrados_caracterizacion_2(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "num_mortalidad_grupo_3", isMM = T))
        loadingStatus22$graph3 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput32 <- NULL
    }
    
    ## "Aborto O00-O07"
    if (isValueSelected("listaCaracterizacion2", "Aborto O00-O07") && !is.null(dados_filtrados_caracterizacion_2())) {
      output$plotOutput42 <- renderUI({
        loadingStatus22$graph4 <- TRUE
        plot <- createCustomCard("Aborto O00-O07", createLinePlot(dados = dados_filtrados_caracterizacion_2(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "causa_aborto", isMM = T))
        loadingStatus22$graph4 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput41 <- NULL
    }
    
    
    
    
    ## "Enfermedad Hipertensiva Del Embarazo, Edema Y Proteinuria O10-O16"
    if (isValueSelected("listaCaracterizacion2", "Enfermedad Hipertensiva Del Embarazo, Edema Y Proteinuria O10-O16") && !is.null(dados_filtrados_caracterizacion_2())) {
      output$plotOutput52 <- renderUI({
        loadingStatus22$graph5 <- TRUE
        plot <- createCustomCard("Enfermedad Hipertensiva Del Embarazo, Edema Y Proteinuria O10-O16", createLinePlot(dados = dados_filtrados_caracterizacion_2(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "causa_enfermedad_hipertensiva", isMM = T))
        loadingStatus22$graph5 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput51 <- NULL
    }
    
    
    ## "Hemorragia Del Embarazo, Parto Y Puerperio O20, O44-O46, O67, O72"
    if (isValueSelected("listaCaracterizacion2", "Hemorragia Del Embarazo, Parto Y Puerperio O20, O44-O46, O67, O72") && !is.null(dados_filtrados_caracterizacion_2())) {
      output$plotOutput62 <- renderUI({
        loadingStatus22$graph6 <- TRUE
        plot <- createCustomCard("Hemorragia Del Embarazo, Parto Y Puerperio O20, O44-O46, O67, O72", createLinePlot(dados = dados_filtrados_caracterizacion_2(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "causa_hemorragia", isMM = T))
        loadingStatus22$graph6 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput62 <- NULL
    }
    
    ## "Sepsis Y Otras Infecciones Puerperales A34, O85-O86"
    if (isValueSelected("listaCaracterizacion2", "Sepsis Y Otras Infecciones Puerperales A34, O85-O86") && !is.null(dados_filtrados_caracterizacion_2())) {
      output$plotOutput72 <- renderUI({
        loadingStatus22$graph7 <- TRUE
        plot <- createCustomCard("Sepsis Y Otras Infecciones Puerperales A34, O85-O86", createLinePlot(dados = dados_filtrados_caracterizacion_2(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "causa_sepsis_infecciones_puerperales", isMM = T))
        loadingStatus22$graph7 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput72 <- NULL
    }
    
    ## "Otras Complicaciones Principalmente Del Embarazo Y Parto O21, O23-O43, O47-O66, O68-O71, O73-O75"
    if (isValueSelected("listaCaracterizacion2", "Otras Complicaciones Principalmente Del Embarazo Y Parto O21, O23-O43, O47-O66, O68-O71, O73-O75") && !is.null(dados_filtrados_caracterizacion_2())) {
      output$plotOutput82 <- renderUI({
        loadingStatus22$graph8 <- TRUE
        plot <- createCustomCard("Otras Complicaciones Principalmente Del Embarazo Y Parto O21, O23-O43, O47-O66, O68-O71, O73-O75", createLinePlot(dados = dados_filtrados_caracterizacion_2(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "causa_otras_complicaciones_embarazo_parto", isMM = T))
        loadingStatus22$graph8 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput82 <- NULL
    }
    
    ## "Otras Complicaciones Principalmente Puerperales O88-O92"
    if (isValueSelected("listaCaracterizacion2", "Otras Complicaciones Principalmente Puerperales O88-O92") && !is.null(dados_filtrados_caracterizacion_2())) {
      output$plotOutput92 <- renderUI({
        loadingStatus22$graph9 <- TRUE
        plot <- createCustomCard("Otras Complicaciones Principalmente Puerperales O88-O92", createLinePlot(dados = dados_filtrados_caracterizacion_2(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "causa_otras_complicaciones_embarazo_puerperales", isMM = T))
        loadingStatus22$graph9 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput92 <- NULL
    }
    
    ## "Complicaciones Venosas En El Embarazo, Parto Y Puerperio O22, O87"
    if (isValueSelected("listaCaracterizacion2", "Complicaciones Venosas En El Embarazo, Parto Y Puerperio O22, O87") && !is.null(dados_filtrados_caracterizacion_2())) {
      output$plotOutput102 <- renderUI({
        loadingStatus22$graph10 <- TRUE
        plot <- createCustomCard("Complicaciones Venosas En El Embarazo, Parto Y Puerperio O22, O87", createLinePlot(dados = dados_filtrados_caracterizacion_2(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "causa_complicaciones_venosas", isMM = T))
        loadingStatus22$graph10 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput102 <- NULL
    }
    
    ## "Causas Obstétricas Indirectas Infecciosas O98"
    if (isValueSelected("listaCaracterizacion2", "Causas Obstétricas Indirectas Infecciosas O98") && !is.null(dados_filtrados_caracterizacion_2())) {
      output$plotOutput112 <- renderUI({
        loadingStatus22$graph11 <- TRUE
        plot <- createCustomCard("Causas Obstétricas Indirectas Infecciosas O98", createLinePlot(dados = dados_filtrados_caracterizacion_2(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "causa_causas_obstetricas_indirectas_infecciosas", isMM = T))
        loadingStatus22$graph11 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput112 <- NULL
    }
    
    ## "Causas Obstétricas Indirectas No Infeciosas O99"
    if (isValueSelected("listaCaracterizacion2", "Causas Obstétricas Indirectas No Infeciosas O99") && !is.null(dados_filtrados_caracterizacion_2())) {
      output$plotOutput122 <- renderUI({
        loadingStatus22$graph12 <- TRUE
        plot <- createCustomCard("Causas Obstétricas Indirectas No Infeciosas O99", createLinePlot(dados = dados_filtrados_caracterizacion_2(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "causa_causas_obstetricas_indirectas_no_infecciosas", isMM = T))
        loadingStatus22$graph12 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput122 <- NULL
    }
    
    ## "Muertes Maternas Tardías O96"
    if (isValueSelected("listaCaracterizacion2", "Muertes Maternas Tardías O96") && !is.null(dados_filtrados_caracterizacion_2())) {
      output$plotOutput132 <- renderUI({
        loadingStatus22$graph13 <- TRUE
        plot <- createCustomCard("Muertes Maternas Tardías O96", createLinePlot(dados = dados_filtrados_caracterizacion_2(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "causa_muertes_maternas_tardias", isMM = T))
        loadingStatus22$graph13 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput132 <- NULL
    }
    
    ## "Muertes Maternas Por Secuelas O97"
    if (isValueSelected("listaCaracterizacion2", "Muertes Maternas Por Secuelas O97") && !is.null(dados_filtrados_caracterizacion_2())) {
      output$plotOutput142 <- renderUI({
        loadingStatus22$graph14 <- TRUE
        plot <- createCustomCard("Muertes Maternas Por Secuelas O97", createLinePlot(dados = dados_filtrados_caracterizacion_2(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "causa_muertes_maternas_por_secuelas", isMM = T))
        loadingStatus22$graph14 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput142 <- NULL
    }
    
    ## "Muerte Obstétrica De Causa No Especificada O95"
    if (isValueSelected("listaCaracterizacion2", "Muerte Obstétrica De Causa No Especificada O95") && !is.null(dados_filtrados_caracterizacion_2())) {
      output$plotOutput152 <- renderUI({
        loadingStatus22$graph15 <- TRUE
        plot <- createCustomCard("Muerte Obstétrica De Causa No Especificada O95", createLinePlot(dados = dados_filtrados_caracterizacion_2(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "causa_muerte_obstetrica_no_especificada", isMM = T))
        loadingStatus22$graph15 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput152 <- NULL
    }
    
    ## "Grupo De Edad 1 (10-19, 20-24, 25-29,30-39,40-49,50-54)"
    if (isValueSelected("listaCaracterizacion2", "Grupo De Edad 1 (10-19, 20-24, 25-29,30-39,40-49,50-54)") && !is.null(dados_filtrados_caracterizacion_2())) {
      output$plotOutput162 <- renderUI({
        loadingStatus22$graph16 <- TRUE
        plot <- createCustomCard("Grupo De Edad 1 (10-19, 20-24, 25-29,30-39,40-49,50-54)", createLinePlot(dados = dados_filtrados_caracterizacion_2(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "grupo_edad_1", isMM = T))
        loadingStatus22$graph16 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput162 <- NULL
    }
    
    ## "Grupo De Edad 2 (10-19,20-29,30-39, 40-54)"
    if (isValueSelected("listaCaracterizacion2", "Grupo De Edad 2 (10-19,20-29,30-39, 40-54)") && !is.null(dados_filtrados_caracterizacion_2())) {
      output$plotOutput172 <- renderUI({
        loadingStatus22$graph17 <- TRUE
        plot <- createCustomCard("Grupo De Edad 2 (10-19,20-29,30-39, 40-54)", createLinePlot(dados = dados_filtrados_caracterizacion_2(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "grupo_edad_2", isMM = T))
        loadingStatus22$graph17 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput172 <- NULL
    }
    
    
    ## "Lugar De Ocurrencia De La Defunción"
    if (isValueSelected("listaCaracterizacion2", "Lugar De Ocurrencia De La Defunción") && !is.null(dados_filtrados_caracterizacion_2())) {
      output$plotOutput182 <- renderUI({
        loadingStatus22$graph18 <- TRUE
        plot <- createCustomCard("Lugar De Ocurrencia De La Defunción", createLinePlot(dados = dados_filtrados_caracterizacion_2(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "lugar_ocur", isMM = T))
        loadingStatus22$graph18 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput182 <- NULL
    }
    
    ## "Recibió Atención Medica Antes De Morir"
    if (isValueSelected("listaCaracterizacion2", "Recibió Atención Medica Antes De Morir") && !is.null(dados_filtrados_caracterizacion_2())) {
      output$plotOutput192 <- renderUI({
        loadingStatus22$graph19 <- TRUE
        plot <- createCustomCard("Recibió Atención Medica Antes De Morir", createLinePlot(dados = dados_filtrados_caracterizacion_2(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "recebio_atencion", isMM = T))
        loadingStatus22$graph19 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput192 <- NULL
    }
    
    ## "Aseguramiento/Derechohabiencia"
    if (isValueSelected("listaCaracterizacion2", "Aseguramiento/Derechohabiencia") && !is.null(dados_filtrados_caracterizacion_2())) {
      output$plotOutput202 <- renderUI({
        loadingStatus22$graph20 <- TRUE
        plot <- createCustomCard("Aseguramiento/Derechohabiencia", createLinePlot(dados = dados_filtrados_caracterizacion_2(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "derechohab", isMM = T))
        loadingStatus22$graph20 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput202 <- NULL
    }
    
    
    ## "Ocupación"
    if (isValueSelected("listaCaracterizacion2", "Ocupación") && !is.null(dados_filtrados_caracterizacion_2())) {
      output$plotOutput212 <- renderUI({
        loadingStatus22$graph21 <- TRUE
        plot <- createCustomCard("Ocupación", createLinePlot(dados = dados_filtrados_caracterizacion_2(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "ocupacion", isMM = T))
        loadingStatus22$graph21 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput212 <- NULL
    }
    
    ## "Estado Civil"
    if (isValueSelected("listaCaracterizacion2", "Estado Civil") && !is.null(dados_filtrados_caracterizacion_2())) {
      output$plotOutput222 <- renderUI({
        loadingStatus22$graph22 <- TRUE
        plot <- createCustomCard("Estado Civil", createLinePlot(dados = dados_filtrados_caracterizacion_2(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "estado_civil", isMM = T))
        loadingStatus22$graph22 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput222 <- NULL
    }
    
  
    ## "Personal Que Certifico La Defunción"
    if (isValueSelected("listaCaracterizacion2", "Personal Que Certifico La Defunción") && !is.null(dados_filtrados_caracterizacion_2())) {
      output$plotOutput232 <- renderUI({
        loadingStatus22$graph23 <- TRUE
        plot <- createCustomCard("Personal Que Certifico La Defunción", createLinePlot(dados = dados_filtrados_caracterizacion_2(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "persona_certifico", isMM = T))
        loadingStatus22$graph23 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput232 <- NULL
    }
    
    #tabelas
    ## "Por Causa Por año"
    if (isValueSelected("listaCaracterizacion2", "Por Causa Y Año") && !is.null(dados_filtrados_caracterizacion_2())) {
      output$plotOutput242 <- renderUI({
        loadingStatus22$graph24 <- TRUE
        plot <- createCustomCard("Por Causa Y Año", createTable(dados = dados_filtrados_caracterizacion_2(), timeVar = "date_ocur", groupVar = "causa_def", groupVar2 = NULL, nomeColuna1 = "Causa"))
        loadingStatus22$graph24 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput242 <- NULL
    }
    
    ## "Por Causa Y Por Grupo De Edad 1"
    if (isValueSelected("listaCaracterizacion2", "Por Causa Y Por Grupo De Edad 1") && !is.null(dados_filtrados_caracterizacion_2())) {
      output$plotOutput252 <- renderUI({
        loadingStatus22$graph25 <- TRUE
        plot <- createCustomCard("Por Causa Y Por Grupo De Edad 1", createTable(dados = dados_filtrados_caracterizacion_2(), timeVar = "date_ocur", groupVar = "causa_def", groupVar2 = "grupo_edad_1", nomeColuna1 = "Causa", nomeColuna2 = "Grupo Edad 1"))
        loadingStatus22$graph25 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput252 <- NULL
    }
    
    ## "Por Causa Y Por Grupo De Edad 2"
    if (isValueSelected("listaCaracterizacion2", "Por Causa Y Por Grupo De Edad 2") && !is.null(dados_filtrados_caracterizacion_2())) {
      output$plotOutput262 <- renderUI({
        loadingStatus22$graph26 <- TRUE
        plot <- createCustomCard("Por Causa Y Por Grupo De Edad 2", createTable(dados = dados_filtrados_caracterizacion_2(), timeVar = "date_ocur", groupVar = "causa_def", groupVar2 = "grupo_edad_2", nomeColuna1 = "Causa", nomeColuna2 = "Grupo Edad 2"))
        loadingStatus22$graph26 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput262 <- NULL
    }
    
    ## "Por Causa Y Lugar De Defunción"
    if (isValueSelected("listaCaracterizacion2", "Por Causa Y Lugar De Defunción") && !is.null(dados_filtrados_caracterizacion_2())) {
      output$plotOutput272 <- renderUI({
        loadingStatus22$graph27 <- TRUE
        plot <- createCustomCard("Por Causa Y Lugar De Defunción", createTable(dados = dados_filtrados_caracterizacion_2(), timeVar = "date_ocur", groupVar = "causa_def", groupVar2 = "lugar_ocur", nomeColuna1 = "Causa", nomeColuna2 = "Lugar De Defunción"))
        loadingStatus22$graph27 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput272 <- NULL
    }
    
    ## "Por Causa Y Atención Recibida"
    if (isValueSelected("listaCaracterizacion2", "Por Causa Y Atención Recibida") && !is.null(dados_filtrados_caracterizacion_2())) {
      output$plotOutput282 <- renderUI({
        loadingStatus22$graph28 <- TRUE
        plot <- createCustomCard("Por Causa Y Atención Recibida", createTable(dados = dados_filtrados_caracterizacion_2(), timeVar = "date_ocur", groupVar = "causa_def", groupVar2 = "recebio_atencion", nomeColuna1 = "Causa", nomeColuna2 = "Atención Recibida"))
        loadingStatus22$graph28 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput282 <- NULL
    }
    
    
    
    ## "Grupo Étnico/Raza"
    if (isValueSelected("listaCaracterizacion2", "Grupo Étnico/Raza") && !is.null(dados_filtrados_caracterizacion_2())) {
      output$plotOutput292 <- renderUI({
        loadingStatus22$graph29 <- TRUE
        plot <- createCustomCard("Grupo Étnico/Raza", createLinePlot(dados = dados_filtrados_caracterizacion_2(), timeVar = "date_ocur", xLabel = "Período", yLabel = "Número de Muertes", groupVar = "raza", isMM = T))
        loadingStatus22$graph29 <- FALSE
        return(plot)
      })
    }else{
      output$plotOutput292 <- NULL
    }
    
    
    
  }, ignoreNULL = FALSE)
  
 

  
  observe({
    if (all(sapply(reactiveValuesToList(loadingStatus11), isFALSE))) {
      remove_modal_spinner()
    }
    
    if (all(sapply(reactiveValuesToList(loadingStatus22), isFALSE))) {
      remove_modal_spinner()
    }
    
  })
  
  
  
  
  
  
  
  
  observeEvent(input$reset11, {
    
    runjs("Shiny.setInputValue('indicadores_tree_caracterizacion_1', null);")
    
    output$indicadores_tree_caracterizacion_1 <- renderTree({ 
      indicators_caracterizacion
    })
    
    
    
    dados_filtrados_caracterizacion_1(NULL) 
    
    # Limpar os inputs
    updateSelectInput(session, "pais11", selected = character(0))
    updateSelectInput(session, "departamento11", selected = character(0))
    updateSelectInput(session, "municipio11", selected = character(0))
    updateDateInput(session,"fecha_inicio11", value = Sys.Date())
    updateDateInput(session,"fecha_final11", value = Sys.Date())
    
    
    # Resetar as seleções globais
    updateGlobalSelections("listaCaracterizacion1", character(0))
    
    # Redefinir todos os estados de carregamento para FALSE
    reactiveValuesToList(loadingStatus11) %>%
      names() %>%
      sapply(function(name) {
        loadingStatus11[[name]] <- FALSE
      })
    
    # Remover o spinner, se estiver ativo
    remove_modal_spinner()
    
    output$plotOutput11 <- renderUI({ NULL })
    output$plotOutput21 <- renderUI({ NULL })
    output$plotOutput31 <- renderUI({ NULL })
    output$plotOutput41 <- renderUI({ NULL })
    output$plotOutput51 <- renderUI({ NULL })
    output$plotOutput61 <- renderUI({ NULL })
    output$plotOutput71 <- renderUI({ NULL })
    output$plotOutput81 <- renderUI({ NULL })
    output$plotOutput91 <- renderUI({ NULL })
    output$plotOutput101 <- renderUI({ NULL })
    output$plotOutput111 <- renderUI({ NULL })
    output$plotOutput121 <- renderUI({ NULL })
    output$plotOutput131 <- renderUI({ NULL })
    output$plotOutput141 <- renderUI({ NULL })
    output$plotOutput151 <- renderUI({ NULL })
    output$plotOutput161 <- renderUI({ NULL })
    output$plotOutput171 <- renderUI({ NULL })
    output$plotOutput181 <- renderUI({ NULL })
    output$plotOutput191 <- renderUI({ NULL })
    output$plotOutput201 <- renderUI({ NULL })
    output$plotOutput211 <- renderUI({ NULL })
    output$plotOutput221 <- renderUI({ NULL })
    output$plotOutput231 <- renderUI({ NULL })
    output$plotOutput241 <- renderUI({ NULL })
    output$plotOutput251 <- renderUI({ NULL })
    output$plotOutput261 <- renderUI({ NULL })
    output$plotOutput271 <- renderUI({ NULL })
    output$plotOutput281 <- renderUI({ NULL })
    output$plotOutput291 <- renderUI({ NULL })

  })
  
  
  observeEvent(input$reset22, {
    runjs("Shiny.setInputValue('indicadores_tree_caracterizacion_2', null);")
    output$indicadores_tree_caracterizacion_2 <- renderTree({ 
      indicators_caracterizacion
    })
    
    
    
    dados_filtrados_caracterizacion_2(NULL) 
    
    # Limpar os inputs
    updateSelectInput(session, "pais22", selected = character(0))
    updateSelectInput(session, "departamento22", selected = character(0))
    updateSelectInput(session, "municipio22", selected = character(0))
    updateDateInput(session,"fecha_inicio22", value = Sys.Date())
    updateDateInput(session,"fecha_final22", value = Sys.Date())
    
    
    # Resetar as seleções globais
    updateGlobalSelections("listaCaracterizacion2", character(0))
    
    # Redefinir todos os estados de carregamento para FALSE
    reactiveValuesToList(loadingStatus22) %>%
      names() %>%
      sapply(function(name) {
        loadingStatus11[[name]] <- FALSE
      })
    
    # Remover o spinner, se estiver ativo
    remove_modal_spinner()
    
    
    output$plotOutput12 <- renderUI({ NULL })
    output$plotOutput22 <- renderUI({ NULL })
    output$plotOutput32 <- renderUI({ NULL })
    output$plotOutput42 <- renderUI({ NULL })
    output$plotOutput52 <- renderUI({ NULL })
    output$plotOutput62 <- renderUI({ NULL })
    output$plotOutput72 <- renderUI({ NULL })
    output$plotOutput82 <- renderUI({ NULL })
    output$plotOutput92 <- renderUI({ NULL })
    output$plotOutput102 <- renderUI({ NULL })
    output$plotOutput112 <- renderUI({ NULL })
    output$plotOutput122 <- renderUI({ NULL })
    output$plotOutput132 <- renderUI({ NULL })
    output$plotOutput142 <- renderUI({ NULL })
    output$plotOutput152 <- renderUI({ NULL })
    output$plotOutput162 <- renderUI({ NULL })
    output$plotOutput172 <- renderUI({ NULL })
    output$plotOutput182 <- renderUI({ NULL })
    output$plotOutput192 <- renderUI({ NULL })
    output$plotOutput202 <- renderUI({ NULL })
    output$plotOutput212 <- renderUI({ NULL })
    output$plotOutput222 <- renderUI({ NULL })
    output$plotOutput232 <- renderUI({ NULL })
    output$plotOutput242 <- renderUI({ NULL })
    output$plotOutput252 <- renderUI({ NULL })
    output$plotOutput262 <- renderUI({ NULL })
    output$plotOutput272 <- renderUI({ NULL })
    output$plotOutput282 <- renderUI({ NULL })
    output$plotOutput292 <- renderUI({ NULL })
    
    
  })
  
  
}
