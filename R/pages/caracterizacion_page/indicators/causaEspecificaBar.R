source("R/utils/processData.R")
source("R/utils/createHorizontalBarPlot.R")


horizontalBarPlotUI <- function(id) {
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
                               options = list(maxItems = 3)),
                selectInput(ns("firstLevel"), "Primer Nivel", choices = c(""), selected = NULL),
                selectInput(ns("secondLevel"), "Segundo Nivel", choices = c(""), selected = NULL)
    )
  ))
}

horizontalBarPlotServer <- function(id, db_selected_country, column_firstLevel, column_secondLevel, targetVar, timeVar, groupVar) {
  moduleServer(id, function(input, output, session) {
    plot_data <- list()
    ns <- session$ns
    

    observe({
      # Atualizar as opções do selectInput com base nos anos disponíveis
      anosDisponiveis <- sort(unique(format(as.Date(db_selected_country()[[timeVar]]), "%Y")))
      updateSelectInput(session, "yearRange", choices = anosDisponiveis, selected = "2015")
    })
    
    
    
    
    # Dados filtrados com base em targetVar e anos
    filteredData <- reactive({
      data <- db_selected_country()
      
      # Verifique se os anos foram selecionados
      if (!is.null(input$yearRange) && length(input$yearRange) > 0) {
        # Certifique-se de que os anos selecionados estão em ordem crescente
        sorted_years <- sort(input$yearRange)
        
        # Crie datas de início e fim usando os anos selecionados
        start_date <- as.Date(paste0(sorted_years[1], "-01-01"))
        end_date <- as.Date(paste0(sorted_years[length(sorted_years)], "-12-31"))
        
        # Filtre os dados pelas datas de início e fim
        data <- data[data[[timeVar]] >= start_date & data[[timeVar]] <= end_date, ]
      }
      
      return(data)
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
        
      } else {
        shinyjs::hide("firstLevel") # Ocultar firstLevel
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
        h3("Dados nacionais indisponíveis", style = 'color:#009cda; text-align: center;')
      }
    })
    
   

    
    output$barPlot <- renderPlotly({
      plot <-  createHorizontalBarPlot(processedDataNational = processedDataNacional(),
                                  processedDataLevel1 = processedDataLevel1(),
                                  processedDataLevel2 = processedDataLevel2(),
                                  timeVar = timeVar,
                                  groupVar = groupVar)
     return(plot)
    })
    
    
    
    
  })
}


