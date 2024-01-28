source("R/utils/processData.R")
source("R/utils/createAnualPrimeiroBarPlot.R")

barAnualPrimeiroPlotUI  <- function(id, title_block = "") {
  ns <- NS(id)
  argonCard(
    width = 12,
    border_level = 10,
    shadow = TRUE,
    title =  h2(title_block, style = 'color:#009cda; text-align: left;'),
    argonRow(
      argonColumn(width = 10,
                  style = "border-right: 1px solid #cccccc;",
                  shinycssloaders::withSpinner(uiOutput(ns("mainPlot")))
                  
      ),
      argonColumn(width = 2,
                  h2("Filtros", style = 'color:#009cda; text-align: left;'),
                  selectizeInput(ns("yearRange"), "Seleccionar los Años", 
                              choices = NULL, 
                              multiple = TRUE,
                              options = list(maxItems = 3))
      )
    ))
}

barAnualPrimeiroServer <- function(id, db_selected_country, column_firstLevel, targetVar, timeVar, title_personal = "") {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    # Funções para verificar se os dados estão disponíveis e não são NULL
    isDataAvailable <- function(data) {
      !is.null(data) && nrow(data) > 0
    }
    
    observe({
      if (isDataAvailable(db_selected_country())) {
      # Atualizar as opções do selectInput com base nos anos disponíveis
      anosDisponiveis <- sort(unique(format(as.Date(db_selected_country()[[timeVar]]), "%Y")))
      updateSelectInput(session, "yearRange", choices = anosDisponiveis, selected = "2015")
      shinyjs::show("yearRange") # Mostrar yearRange
      }else{
        shinyjs::hide("yearRange")
      }
      
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
        h3("Seleccione un país para consultar el indicador", style = 'color:#009cda; text-align: center;')
      }
    })
    
    
    # Renderizar o gráfico de barras
    output$barChart <- renderPlotly({
      # Extrair informações dos filtros
      selectedCountry <- unique(db_selected_country()$pais)
      selectedYears <- as.numeric(input$yearRange)  # Converte para números inteiros
      numYears <- length(selectedYears)
      
      # Construir o título com base no número de anos selecionados
      yearText <- if (numYears > 0) {
        paste(selectedYears, collapse = ", ")
      } else {
        ""  # Caso não haja anos selecionados
      }
      
      titleText <- if (yearText != "") {
        sprintf("%s de %s en Relación a Cada Ubicación de Primer Nivel de %s",title_personal, selectedCountry, yearText)
      } else {
        sprintf("")
      }
      
      # Verificar se os dados estão disponíveis e renderizar o gráfico de barras
      if (isDataAvailable(processedDataNacional())) {
        createAnualPrimeiroBarPlot(
          processedDataNacional = processedDataNacional(),
          processedDataLevel1 = processedDataLevel1(),
          intervaloAnos = input$yearRange,
          level1ColumnName = column_firstLevel,
          title = titleText
        )
      }
    })
    
    
  })
}