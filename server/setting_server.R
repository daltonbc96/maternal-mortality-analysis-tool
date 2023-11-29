library(shiny)
library(plotly)
library(dplyr)

source("server/renderScatterPlotlyGraph.R")
source("server/updateSelectInputs.R")
source("server/filterData.R")
source("server/simulatedData.R")




server <- function(input, output, session) {
  
  #listar paises 
  lista_paises <<- simulated_data()
  
  #atualizar campos de filtragem de acordo com lista de paises
  updateSelectInputs(input, session, lista_paises, "pais1", "departamento1", "municipio1", "fecha_inicio1", "fecha_final1")
  
  updateSelectInputs(input, session, lista_paises, "pais2", "departamento2", "municipio2", "fecha_inicio2", "fecha_final2")
  
  updateSelectInputs(input, session, lista_paises, "pais11", "departamento11", "municipio11", "fecha_inicio11", "fecha_final11")
  
  updateSelectInputs(input, session, lista_paises, "pais22", "departamento22", "municipio22", "fecha_inicio22", "fecha_final22")
  
  
  updateSelectInputs(input, session, lista_paises, "pais13", "departamento13", "municipio13", "fecha_inicio13", "fecha_final13")
  
  updateSelectInputs(input, session, lista_paises, "pais24", "departamento24", "municipio24", "fecha_inicio24", "fecha_final24")
  
  
  updateSelectInputs(input, session, lista_paises, "pais14", "departamento14", "municipio14", "fecha_inicio14", "fecha_final14")
  
   updateSelectInputs(input, session, lista_paises, "pais25", "departamento25", "municipio25", "fecha_inicio25", "fecha_final25")
  
  
  #dados filtrados conforme filtro
  
  dataFiltered_caracterizacion_1 <- eventReactive(input$btnGerar11, {
    filterData(lista_paises, input$pais11, input$departamento11, input$municipio11, input$fecha_inicio11, input$fecha_final11)
  })
  
  dataFiltered_caracterizacion_2 <- eventReactive(input$btnGerar22, {
    filterData(lista_paises, input$pais22, input$departamento22, input$municipio22, input$fecha_inicio22, input$fecha_final22)
  })
  

  
 #Default graficos
  
  output$plotlyGraphUI1 <- renderUI({
    if (input$pais11 == "" || is.null(input$pais11)) {
      tagList(h4("Seleccione el país para generar el gráfico.", style = 'color: gray;'))
    }
  })
  
  output$plotlyGraphUI3 <- renderUI({
    if (input$pais11 == "" || is.null(input$pais11)) {
      tagList(h4("Seleccione el país para generar el gráfico.", style = 'color: gray;'))
    }
  })
  
  
  output$plotlyGraphUI2 <- renderUI({
    if (input$pais22 == "" || is.null(input$pais22)) {
      tagList(h4("Seleccione el país para generar el gráfico.", style = 'color: gray;'))
    }
  })
  
  output$plotlyGraphUI4 <- renderUI({
    if (input$pais22 == "" || is.null(input$pais22)) {
      tagList(h4("Seleccione el país para generar el gráfico.", style = 'color: gray;'))
    }
  })
  
  
  

  
  #Gerando Grafico de Muertes Maternas
  
  observeEvent(input$btnGerar11, {
    if (input$pais11 != "" && !is.null(dataFiltered_caracterizacion_1()) && nrow(dataFiltered_caracterizacion_1()) > 0) {
      renderScatterPlotlyGraph(
        output = output,
        btn = input$btnGerar11,
        plotId = "plotlyGraphUI1",
        data = dataFiltered_caracterizacion_1(),
        varName = "deaths",
        title = "",
        xaxis = "Periodo",
        yaxis = "",
        colorway = c("#4C78A8", "#54A2CC"),
        #groupByVar = "edad",
        errorMessage = "Esta localización no dispone de esta informacións"
      )
      
      
      renderScatterPlotlyGraph(
        output = output,
        btn = input$btnGerar11,
        plotId = "plotlyGraphUI3",
        data = dataFiltered_caracterizacion_1(),
        varName = "deaths",
        title = "Muertes Maternas",
        xaxis = "Periodo",
        yaxis = "",
        colorway = c("#4C78A8", "#54A2CC"),
        groupByVar = "edad",
        errorMessage = "Esta localización no dispone de esta informacións"
      )
    }
    else {
      output$plotlyGraphUI1 <- renderUI({
        tagList(h4("Seleccione una localización para generar los gráficos.", style = 'color: grey;'))
      })
      output$plotlyGraphUI3 <- renderUI({
        tagList(h4("Seleccione una localización para generar los gráficos.", style = 'color: grey;'))
      })
    }
  })
  
  
  
     observeEvent(input$btnGerar22, {
     if (input$pais22 != "" && !is.null(dataFiltered_caracterizacion_2()) && nrow(dataFiltered_caracterizacion_2()) > 0) {
       renderScatterPlotlyGraph(
         output = output,
         btn = input$btnGerar22,
         plotId = "plotlyGraphUI2",
         data = dataFiltered_caracterizacion_2(),
         varName = "deaths",
         title = "",
         xaxis = "Periodo",
         yaxis = "Número de Muertes",
         colorway = c("#4C78A8", "#54A2CC"),
         #groupByVar = "edad",
         errorMessage = "Esta localización no dispone de esta informacións"
       )
       
       renderScatterPlotlyGraph(
         output = output,
         btn = input$btnGerar22,
         plotId = "plotlyGraphUI4",
         data = dataFiltered_caracterizacion_2(),
         varName = "deaths",
         title = "",
         xaxis = "Periodo",
         yaxis = "Número de Muertes",
         colorway = c("#4C78A8", "#54A2CC"),
         groupByVar = "edad",
         errorMessage = "Esta localización no dispone de esta informacións"
       )
     }
     else {
       output$plotlyGraphUI2 <- renderUI({
         tagList(h4("Seleccione una localización para generar los gráficos.", style = 'color: grey;'))
       })
       
       output$plotlyGraphUI4 <- renderUI({
         tagList(h4("Seleccione una localización para generar los gráficos.", style = 'color: grey;'))
       })
     }
   })
     
     
  
  

}




