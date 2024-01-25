source("R/utils/processData.R")
source("R/utils/createLinePlot.R")

plot_line3LevelsUI <- function(id) {
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
                sliderInput(ns("yearRange"), "Rango de Años",step = 1, min = 2015, max = 2015, value = c(2015, 2015)),
                selectInput(ns("firstLevel"), "Primer Nivel", choices = c(""), selected = NULL),
                selectInput(ns("secondLevel"), "Segundo Nivel", choices = c(""), selected = NULL)
    )
  ))
}

plot_line3LevelsServer <- function(id, db_selected_country, column_firstLevel, column_secondLevel, targetVar, timeVar) {
  moduleServer(id, function(input, output, session) {
    plot_data <- list()
    ns <- session$ns
    
    # Definir valores mínimos e máximos para o sliderInput
    observe({
      if (!is.null(db_selected_country())) {
        years <- format(as.Date(db_selected_country()$date_ocur), "%Y")
        min_year <- min(as.numeric(years), na.rm = TRUE)
        max_year <- max(as.numeric(years), na.rm = TRUE)
        updateSliderInput(session, "yearRange", min = min_year, max = max_year, value = c(min_year, max_year))
      }
    })
    
    
    # Dados filtrados com base em targetVar e anos
    filteredData <- reactive({
      data <- db_selected_country()
      
      # Aplicar filtragem por anos
      if (!is.null(input$yearRange)) {
        start_year <- as.Date(paste0(input$yearRange[1], "-01-01"))
        end_year <- as.Date(paste0(input$yearRange[2], "-12-31"))
        data <- data[data$date_ocur >= start_year & data$date_ocur <= end_year, ]
      }
    })
    
    # Atualizar as opções de firstLevel com dados filtrados
    observe({
      data <- filteredData()
      
      # Armazenar a seleção atual de firstLevel
      currentSelection <- input$firstLevel
      
      if (!is.null(data)) {
        choices <- c("", unique(na.omit(data[[column_firstLevel]])))
        
        # Se a seleção atual não estiver nas novas opções, redefina para NULL
        if (!(currentSelection %in% choices)) {
          currentSelection <- NULL
        }
        
        updateSelectInput(session, "firstLevel", choices = choices, selected = currentSelection)
        shinyjs::show("firstLevel") # Mostrar firstLevel
        shinyjs::show("yearRange") # Mostrar yearRange
        
      } else {
        shinyjs::hide("firstLevel") # Ocultar firstLevel
        shinyjs::hide("yearRange") # Ocultar yearRange
      }
    })
    
    
    # Atualizar as opções de secondLevel quando o firstLevel mudar
    observeEvent(input$firstLevel, {
      data <- filteredData()
      if (!is.null(data) && input$firstLevel != "") {
        filtered <- data[data[[column_firstLevel]] == input$firstLevel, ]
        secondLevels <- c("", sort(unique(na.omit(filtered[[column_secondLevel]]))))
        updateSelectInput(session, "secondLevel", choices = secondLevels, selected = "")
        shinyjs::show("secondLevel") # Mostrar secondLevel
      } else {
        updateSelectInput(session, "secondLevel", choices = "", selected = "")
        shinyjs::hide("secondLevel") # Ocultar secondLevel
      }
    })
    
    # Dados processados para cada nível
    processedDataNacional <- reactive({
      processDataNacional(filteredData(), timeVar = timeVar, target = targetVar)
    })
    
    processedDataLevel1 <- reactive({
     processDataLevel1(filteredData(), timeVar = timeVar, target = targetVar, level1 = column_firstLevel, filterLevel1 = input$firstLevel)
    })
    
    processedDataLevel2 <- reactive({
      processDataLevel2(filteredData(), timeVar = timeVar, target = targetVar, level2 = column_secondLevel, filterLevel2 = input$secondLevel)
   
    })
    
    
    
    output$mainPlot <- renderUI({
      if (!is.null(processedDataNacional()) && nrow(processedDataNacional()) > 0) {
        plotly::plotlyOutput(ns("linePlot"))
      } else {
        h3("Dados nacionais indisponíveis", style = 'color:#009cda; text-align: center;')
      }
    })
    
    output$linePlot <- plotly::renderPlotly({

     plot <-  createLinePlot(
        processedDataNacional(),
        processedDataLevel1(),
        processedDataLevel2(),
        title = "",
        x_axis_label = "Periodo",
        y_axis_label = "Número de Casos",
        legend_labels = c("Datos Nacionales", "Primer Nivel", "Segundo Nivel")
      )

     return(plot)
    })
    
    
    
    
  })
}


