source("R/utils/processData.R")
source("R/utils/createGroupBarPlot.R")


edadBarPlotUI <- function(id, title_block = "") {
  ns <- NS(id)
  
  
  argonCard(
    width = 12,
    border_level = 10,
    shadow = TRUE,
    title =  h2(title_block, style = 'color:#009cda; text-align: left;'),
  argonRow(
    argonColumn(width = 10,
                style = "border-right: 1px solid #cccccc;",
                shinycssloaders::withSpinner( uiOutput(ns("mainPlot")))
                
    ),
    argonColumn(width = 2,
                h2("Filtros", style = 'color:#009cda; text-align: left;'),
                sliderInput(ns("yearRange"), "Rango de Años",step = 1, min = 2015, max = 2015, value = c(2015, 2015)),
                selectInput(ns("firstLevel"), "Primer Nivel", choices = c(""), selected = NULL),
                selectInput(ns("secondLevel"), "Segundo Nivel", choices = c(""), selected = NULL)
    )
  ))
}

edadBarPlotServer <- function(id, db_selected_country, column_firstLevel, column_secondLevel, targetVar, timeVar, groupVar,  title_personal = "") {
  moduleServer(id, function(input, output, session) {
    plot_data <- list()
    ns <- session$ns
    
    # Definir valores mínimos e máximos para o sliderInput
    observe({
      if (!is.null(db_selected_country())) {
        years <- format(as.Date(db_selected_country()$date_ocur), "%Y")
        min_year <- min(as.numeric(years), na.rm = TRUE)
        max_year <- max(as.numeric(years), na.rm = TRUE)
        updateSliderInput(session, "yearRange", min = min_year, max = max_year, value = c(2015, 2015))
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
      processDataNacional(filteredData(), timeVar = timeVar, target = targetVar, groupVar = groupVar)
    })
   
    
    processedDataLevel1 <- reactive({
     processDataLevel1(filteredData(), timeVar = timeVar, target = targetVar, level1 = column_firstLevel, filterLevel1 = input$firstLevel, groupVar = groupVar)
  
      })
    
    
    
    
    processedDataLevel2 <- reactive({
      processDataLevel2(filteredData(), timeVar = timeVar, target = targetVar, level2 = column_secondLevel, filterLevel2 = input$secondLevel, groupVar = groupVar)
   
    })
    

   
 
    
    output$mainPlot <- renderUI({
      if (!is.null(processedDataNacional()) && nrow(processedDataNacional()) > 0) {
        plotlyOutput(ns("barPlot"))

      } else {
        h3("Seleccione un país para consultar el indicador", style = 'color:#009cda; text-align: center;')
      }
    })
    
   

    
    output$barPlot <- renderPlotly({
      
      # Extrair informações dos filtros
      selectedCountry <- unique(db_selected_country()$pais)
      firstLevel <- input$firstLevel
      secondLevel <- input$secondLevel
      yearRange <- input$yearRange
      
      # Construir o título
      yearText <- if (yearRange[1] == yearRange[2]) {
        sprintf("%d", yearRange[1])
      } else {
        sprintf("%d - %d", yearRange[1], yearRange[2])
      }
      
      titleText <- if (!is.null(secondLevel) && secondLevel != "") {
        sprintf("%s de %s de %s", title_personal, secondLevel, yearText)
      } else if (!is.null(firstLevel) && firstLevel != "") {
        sprintf("%s de %s de %s", title_personal, firstLevel, yearText)
      } else {
        sprintf("%s de %s de %s", title_personal,selectedCountry, yearText)
      }
      
      plot <-  createGroupBarPlot(processedDataNational = processedDataNacional(),
                                  processedDataLevel1 = processedDataLevel1(),
                                  processedDataLevel2 = processedDataLevel2(),
                                  timeVar = timeVar,
                                  groupVar = groupVar,
                                  title = titleText,
                                  xAxisLabel = "Grupos de Edad",
                                  yAxisLabel = "Número de Casos"
                                  
                                  )
     return(plot)
    })
    
    
    
    
  })
}


