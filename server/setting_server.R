library(shiny)
library(plotly)
library(dplyr)

source("server/renderScatterPlotlyGraph.R")
source("server/updateSelectInputs.R")
source("server/filterData.R")
source("server/simulatedData.R")
source("server/renderizar_tabela.R")
source("server/createBarPlot.R")
source("server/createAreaPlot.R")
source("server/indicators_caracterizacion.R")

source("server/createCustomCard.R")

source("server/selectedIndicator.R")


validarInputs <- function(pais, indicadores) {
  mensagemErro <- c()
  if (pais == "") {
    mensagemErro <- c(mensagemErro, "• Un país")
  }
  if (is.null(indicadores) || length(indicadores) == 0) {
    mensagemErro <- c(mensagemErro, "• Al menos un indicador")
  }
  return(mensagemErro)
}



server <- function(input, output, session) {
  
  #listar paises 
  lista_paises <<- simulated_data()
  loading11 <- reactiveVal(FALSE)
  loading22 <- reactiveVal(FALSE)
  
  graphsRendered <- reactiveVal(0)
  graphsRendered22 <- reactiveVal(0)
  
  parent_items <- c("Número de Mortalidade Materna", "Número de Muertes por Aspectos Socio-Demográficos y de Atención", "Número de Muertes por Causas Específicas", "Indicadores Combinados")
  
  

  
  
  indicators_caracterizacion <- indicators_caracterizacion()
  
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
  
  
   
   selecoesAtivas <- reactiveValues(listaCaracterizacion1 = character(0), listaCaracterizacion2 = character(0))
   
   isValueSelected <- function(listID, value) {
     if (!listID %in% names(selecoesAtivas)) {
       return(FALSE)
     }
     return(value %in% selecoesAtivas[[listID]])
   }
   
   
   observe({
     
     selectedValues1 <- getSelectedNames(input$indicadores_tree_caracterizacion_1, parent_items)
     updateGlobalSelections("listaCaracterizacion1", selectedValues1)
     graphsRendered(0)
   })
  
   observe({
     selectedValues2 <- getSelectedNames(input$indicadores_tree_caracterizacion_2, parent_items)
     updateGlobalSelections("listaCaracterizacion2", selectedValues2)
     graphsRendered22(0)
   })
   
   
   
    dados_filtrados_caracterizacion_1 <- reactiveVal()
  
    
    observeEvent(input$btnGerar11, {
      show_modal_spinner()
      loading11(TRUE) 
      on.exit(loading11(FALSE))
      dados_filtrados11 <- filterData(lista_paises, input$pais11, input$departamento11, input$municipio11, input$fecha_inicio11, input$fecha_final11)
      dados_filtrados_caracterizacion_1(dados_filtrados11)
      selecoesAtivas$listaCaracterizacion1 <- getGlobalSelections("listaCaracterizacion1")
      

    }, ignoreNULL = FALSE)
    
   
    dados_filtrados_caracterizacion_2 <- reactiveVal()
    
    observeEvent(input$btnGerar22, {
      show_modal_spinner()
      loading22(TRUE) 
      on.exit(loading22(FALSE))
      dados_filtrados22 <- filterData(lista_paises, input$pais22, input$departamento22, input$municipio22, input$fecha_inicio22, input$fecha_final22)
      dados_filtrados_caracterizacion_2(dados_filtrados22)
      selecoesAtivas$listaCaracterizacion2 <- getGlobalSelections("listaCaracterizacion2")
    }, ignoreNULL = FALSE)
    
    
    
    

    
    
     error_message <- reactiveVal()
   
    observe({
  mensagemErro11 <- validarInputs(input$pais11, getSelectedNames(input$indicadores_tree_caracterizacion_1))
  
  if (length(mensagemErro11) > 0) {
    error_message(paste("Es necesario seleccionar:<br>", paste(mensagemErro11, collapse = "<br>")))
    shinyjs::disable("btnGerar11")
  } else {
    error_message(NULL)  
    shinyjs::enable("btnGerar11")
  }
})

    
    
    output$error_message_display <- renderUI({
      if (!is.null(error_message()) && length(error_message()) > 0) {
        div(style = "color: grey; font-size: 10px;", HTML(error_message()))
      }
    })
    
    error_message22 <- reactiveVal()
    
    observe({
      mensagemErro2 <- validarInputs(input$pais22, getSelectedNames(input$indicadores_tree_caracterizacion_2))
      
      if (length(mensagemErro2) > 0) {
        error_message22(paste("Es necesario seleccionar:<br>", paste(mensagemErro2, collapse = "<br>")))
        shinyjs::disable("btnGerar22")
      } else {
        error_message22(NULL)
        shinyjs::enable("btnGerar22")
      }
    })
    
    
    output$error_message_display2 <- renderUI({
      if (!is.null(error_message22()) && length(error_message22()) > 0) {
        div(style = "color: grey; font-size: 10px;", HTML(error_message22()))
      }
    })
    

 
  
   
    observe({
      if (length(selecoesAtivas$listaCaracterizacion1) == graphsRendered()) {
        remove_modal_spinner()
      }
    })
    
    observe({
      if (length(selecoesAtivas$listaCaracterizacion2) == graphsRendered22()) {
        remove_modal_spinner()
      }
    })
    
    
    
 
   
   

   # criar plots
   
     
    output$plotOutput1 <- renderUI({

      if ( isValueSelected("listaCaracterizacion1", "Número de Muertes Maternas Total") && !is.null(dados_filtrados_caracterizacion_1())) {
        isolate( graphsRendered(graphsRendered() + 1))
        
         createCustomCard("Muertes Maternas", createBarPlot(dados_filtrados_caracterizacion_1(), "pais", "fecha_def", NULL, loading11(), "Período", "Número de Muertes"))
      }
    })
    
    

    

   
   output$plotOutput2 <- renderUI({
     
     if ( isValueSelected("listaCaracterizacion2", "Número de Muertes Maternas Total") && !is.null(dados_filtrados_caracterizacion_2())) {
       isolate(  graphsRendered22(graphsRendered22() + 1))
       createCustomCard("Muertes Maternas", createBarPlot(dados_filtrados_caracterizacion_2(), "pais", "fecha_def", NULL, loading22(), "Período", "Número de Muertes"))
     }
   })
   

   
  
  #plot 3
  output$plotOutput3 <- renderUI({
    
    if ( isValueSelected("listaCaracterizacion1", "Grupo De Edad 2 (10-19,20-29,30-39, 40-54)") && !is.null(dados_filtrados_caracterizacion_1())) {
      isolate( graphsRendered(graphsRendered() + 1))
      createCustomCard("Grupos de Edad", createBarPlot(dados_filtrados_caracterizacion_1(), "pais", "fecha_def", "grupo_edad", loading11(),  "Período", "Número de Muertes"))
    }
  })
  
  
  #plot 4
  output$plotOutput4 <- renderUI({
    
    if ( isValueSelected("listaCaracterizacion2", "Grupo De Edad 2 (10-19,20-29,30-39, 40-54)") && !is.null(dados_filtrados_caracterizacion_2())) {
      isolate(  graphsRendered22(graphsRendered22() + 1))
      createCustomCard("Grupos de Edad", createBarPlot(dados_filtrados_caracterizacion_2(), "pais", "fecha_def", "grupo_edad", loading22(),  "Período", "Número de Muertes"))
    }
  })
  
  
  
  
  
  #plot 5
  output$plotOutput5 <- renderUI({
    if (isValueSelected("listaCaracterizacion1", "Recibió Atención Medica Antes De Morir") && !is.null(dados_filtrados_caracterizacion_1())) {
      isolate( graphsRendered(graphsRendered() + 1))
      createCustomCard("Recibió Asistencia Media Antes de Morir", createAreaPlot(dados = dados_filtrados_caracterizacion_1(), targetVar = "pais", timeVar = "fecha_def", groupVar =  "asistencia",is_loading =  loading11(),  xLabel = "Período", yLabel = "Percentagem"))
      }
  })
  
  
  
  #plot 6
  output$plotOutput6 <- renderUI({
    if (isValueSelected("listaCaracterizacion2", "Recibió Atención Medica Antes De Morir") && !is.null(dados_filtrados_caracterizacion_2())) {
      isolate(  graphsRendered22(graphsRendered22() + 1))
      createCustomCard("Recibió Asistencia Media Antes de Morir", createAreaPlot(dados = dados_filtrados_caracterizacion_2(), targetVar = "pais", timeVar = "fecha_def", groupVar =  "asistencia",is_loading =  loading22(),  xLabel = "Período", yLabel = "Percentagem"))
    }
  })
  
  

  
  
  #Table 
  output$table7 <- renderUI({
    if (isValueSelected("listaCaracterizacion1", "Por Causas Obstétricas Directas (A34, O00-O94) Y Obstétricas Indirectas (O98-O99)") && !is.null(dados_filtrados_caracterizacion_1())) {
      createCustomCard("Porcentaje de Causas de Muertes por Código CIE-10", renderizar_tabela(dados_filtrados = dados_filtrados_caracterizacion_1(),  timeVar = "fecha_def", groupVar = "causa", is_loading = loading11()))
    }
  })
  
  output$table8 <- renderUI({
    if (isValueSelected("listaCaracterizacion2", "Por Causas Obstétricas Directas (A34, O00-O94) Y Obstétricas Indirectas (O98-O99)") && !is.null(dados_filtrados_caracterizacion_2())) {
      createCustomCard("Porcentaje de Causas de Muertes por Código CIE-10", renderizar_tabela(dados_filtrados = dados_filtrados_caracterizacion_2(),  timeVar = "fecha_def", groupVar = "causa", is_loading = loading22()))
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
    

    updateSelectInput(session, "indicadores_tree_caracterizacion_1", selected = character(0))
    
    graphsRendered(0)
    
    # Remover o spinner, se estiver ativo
    remove_modal_spinner()
    
    

    selecoesAtivas$listaCaracterizacion1 <- character(0)
    
   
    
  
    
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
    
    
    updateSelectInput(session, "indicadores_tree_caracterizacion_2", selected = character(0))
    
    graphsRendered22(0)
    
    # Remover o spinner, se estiver ativo
    remove_modal_spinner()
    
    
    
    selecoesAtivas$listaCaracterizacion2 <- character(0)
    
    
    
    
    
  })
  

}




