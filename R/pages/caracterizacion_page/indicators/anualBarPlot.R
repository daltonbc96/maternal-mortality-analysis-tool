source("R/utils/processData.R")
source("R/utils/createAnualBarPlot.R")

barChartUI  <- function(id) {
  ns <- NS(id)
  argonCard(
    width = 12,
    border_level = 10,
    shadow = TRUE,
    title =  h2("Teste", style = 'color:#009cda; text-align: left;'),
    argonRow(
      argonColumn(width = 10,
                  style = "border-right: 1px solid #cccccc;",
                  uiOutput(ns("mainPlot"))
                  
      ),
      argonColumn(width = 2,
                  h2("Filtros", style = 'color:#009cda; text-align: left;'),
                  selectizeInput(ns("yearRange"), "Selecione os Anos", 
                              choices = NULL, 
                              multiple = TRUE,
                              options = list(maxItems = 3))
      )
    ))
}

barChartServer <- function(id, db_selected_country, column_firstLevel, targetVar, timeVar) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    # Funções para verificar se os dados estão disponíveis e não são NULL
    isDataAvailable <- function(data) {
      !is.null(data) && nrow(data) > 0
    }
    
    observe({
      # Atualizar as opções do selectInput com base nos anos disponíveis
      anosDisponiveis <- sort(unique(lubridate::year(db_selected_country()[[timeVar]])))
      updateSelectInput(session, "yearRange", choices = anosDisponiveis, selected = "2015")
    })
    
    
    
    # Dados processados para o nível nacional
    processedDataNacional <- reactive({
      if (isDataAvailable(db_selected_country())) {
        filterYear <- db_selected_country() %>%
          filter(lubridate::year(date_ocur) %in% input$yearRange)
        processDataNacional(filterYear, target = targetVar, timeVar = timeVar)
      } else {
        return(NULL)
      }
    })
    
    # Dados processados para o primeiro nível
    processedDataLevel1 <- reactive({
      if (isDataAvailable(db_selected_country())) {
        filterYear <- db_selected_country() %>%
          filter(lubridate::year(date_ocur) %in% input$yearRange)
        processDataLevel1(filterYear, level1 = column_firstLevel, target = targetVar, timeVar = timeVar)
      } else {
        return(NULL)
      }
    })
    
    
    output$mainPlot <- renderUI({
      if (!is.null(processedDataNacional()) && nrow(processedDataNacional()) > 0) {
        plotly::plotlyOutput(ns("barChart"))
      } else {
        h3("Dados nacionais indisponíveis", style = 'color:#009cda; text-align: center;')
      }
    })
    
    
    # Renderizar o gráfico de barras
    output$barChart <- renderPlotly({
      if (isDataAvailable(processedDataNacional())) {
        createBarChart( processedDataNacional = processedDataNacional(), processedDataLevel1 = processedDataLevel1(), intervaloAnos = input$yearRange, level1ColumnName = column_firstLevel )
      }
    })
  })
}