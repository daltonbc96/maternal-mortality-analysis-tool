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




server <- function(input, output, session) {
  
  #listar paises 
  lista_paises <<- simulated_data()
  loading11 <- reactiveVal(FALSE)
  loading22 <- reactiveVal(FALSE)
 
  
  #atualizar campos de filtragem de acordo com lista de paises
  updateSelectInputs(input, session, lista_paises, "pais1", "departamento1", "municipio1", "fecha_inicio1", "fecha_final1")
  
  updateSelectInputs(input, session, lista_paises, "pais2", "departamento2", "municipio2", "fecha_inicio2", "fecha_final2")
  
  updateSelectInputs(input, session, lista_paises, "pais11", "departamento11", "municipio11", "fecha_inicio11", "fecha_final11")
  
  updateSelectInputs(input, session, lista_paises, "pais22", "departamento22", "municipio22", "fecha_inicio22", "fecha_final22")
  
  
  updateSelectInputs(input, session, lista_paises, "pais13", "departamento13", "municipio13", "fecha_inicio13", "fecha_final13")
  
  updateSelectInputs(input, session, lista_paises, "pais24", "departamento24", "municipio24", "fecha_inicio24", "fecha_final24")
  
  
  updateSelectInputs(input, session, lista_paises, "pais14", "departamento14", "municipio14", "fecha_inicio14", "fecha_final14")
  
   updateSelectInputs(input, session, lista_paises, "pais25", "departamento25", "municipio25", "fecha_inicio25", "fecha_final25")
  

 
   
 #Data
   dados_filtrados_caracterizacion_1 <- eventReactive(input$btnGerar11, {
     loading11(TRUE) 
     on.exit(loading11(FALSE))
     filterData(lista_paises, input$pais11, input$departamento11, input$municipio11, input$fecha_inicio11, input$fecha_final11)
   }, ignoreNULL = FALSE)
   
   
   dados_filtrados_caracterizacion_2 <- eventReactive(input$btnGerar22, {
     loading22(TRUE) 
     on.exit(loading22(FALSE))
     filterData(lista_paises, input$pais22, input$departamento22, input$municipio22, input$fecha_inicio22, input$fecha_final22)
   }, ignoreNULL = FALSE)
   

   
  
  #plot
  

  #plot 1
  output$plotOutput1 <- renderUI({
   createBarPlot(dados_filtrados_caracterizacion_1(), "pais", "fecha_def", NULL, loading11(),  "Período", "Número de Muertes")
 
  })
  
  #plot 3
  output$plotOutput3 <- renderUI({
    createBarPlot(dados_filtrados_caracterizacion_1(), "pais", "fecha_def", "grupo_edad", loading11(),  "Período", "Número de Muertes")
    
  })
  
  #plot 5
  output$plotOutput5 <- renderUI({
    createAreaPlot(dados = dados_filtrados_caracterizacion_1(), targetVar = "pais", timeVar = "fecha_def", groupVar =  "asistencia",is_loading =  loading11(),  xLabel = "Período", yLabel = "Percentagem")
    
  })
  
  
  #plot 2
  output$plotOutput2 <- renderUI({
    createBarPlot(dados_filtrados_caracterizacion_2(), "pais", "fecha_def", NULL, loading22(),  "Período", "Número de Muertes")
    
  })
  
  #plot 4
  output$plotOutput4 <- renderUI({
    createBarPlot(dados_filtrados_caracterizacion_2(), "pais", "fecha_def", "grupo_edad", loading22(),  "Período", "Número de Muertes")
    
  })
  
  #plot 6
  output$plotOutput6 <- renderUI({
    createAreaPlot(dados = dados_filtrados_caracterizacion_2(), targetVar = "pais", timeVar = "fecha_def", groupVar =  "asistencia",is_loading =  loading22(),  xLabel = "Período", yLabel = "Percentagem")
    
    
  })
  
  
  #Table 
  output$table1 <- renderUI({
    renderizar_tabela(dados_filtrados = dados_filtrados_caracterizacion_1(),  timeVar = "fecha_def", groupVar = "causa", is_loading = loading11())
    
  })
  
  output$table2 <- renderUI({
    renderizar_tabela(dados_filtrados = dados_filtrados_caracterizacion_2(),  timeVar = "fecha_def", groupVar = "causa", is_loading = loading22())
    
  })
  
  
  

}




