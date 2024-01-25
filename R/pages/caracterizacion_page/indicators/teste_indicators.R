source("R/utils/processData.R")
histogramaUI <- function(id) {
  ns <- NS(id)
  argonCard(
    width = 12,
    border_level = 10,
    shadow = TRUE,
    title =  h2("Teste", style = 'color:#009cda; text-align: left;'),
  argonRow(
    argonColumn(width = 10,
                style = "border-right: 1px solid #cccccc;",
                tableOutput(ns("mainPlot")),
                tableOutput(ns("mainPlot2")),
                tableOutput(ns("mainPlot3"))
                
    ),
    argonColumn(width = 2,
                selectInput(ns("firstLevel"), "Primer Nivel", choices = c("Todos"), selected = "Todos"),
                selectInput(ns("secondLevel"), "Segundo Nivel", choices = c("Todos"), selected = "Todos")
    )
  ))
}

histogramaServer <- function(id, db_selected_country, column_firstLevel, column_secondLevel, targetVar, timeVar) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    # Dados processados para cada nível
    processedDataNacional <- reactive({
      processDataNacional(db_selected_country(), timeVar = timeVar, target = targetVar)
    })
    
    processedDataLevel1 <- reactive({
      processDataLevel1(db_selected_country(), timeVar = timeVar, target = targetVar, level1 = column_firstLevel, filterLevel1 = input$firstLevel)
    })
    
    processedDataLevel2 <- reactive({
      processDataLevel2(db_selected_country(), timeVar = timeVar, target = targetVar, level2 = column_secondLevel, filterLevel2 = input$secondLevel)
    })
    
    
    
    
    # Dados filtrados com base em targetVar
    filteredData <- reactive({
      data <- db_selected_country()
      data[!is.na(data[[targetVar]]) & data[[targetVar]] > 0, ]
    })
    
    # Atualizar as opções de firstLevel com dados filtrados
    observe({
      data <- filteredData()
      if (!is.null(data)) {
        updateSelectInput(session, "firstLevel", choices = c("Todos", unique(na.omit(data[[column_firstLevel]]))))
      }
    })
    
    # Atualizar as opções de secondLevel quando o firstLevel mudar
    observeEvent(input$firstLevel, {
      data <- filteredData()
      if (!is.null(data) && input$firstLevel != "Todos") {
        filtered <- data[data[[column_firstLevel]] == input$firstLevel, ]
        secondLevels <- c("Todos", sort(unique(na.omit(filtered[[column_secondLevel]]))))
        updateSelectInput(session, "secondLevel", choices = secondLevels, selected = "Todos")
        shinyjs::show("secondLevel") # Mostrar secondLevel
      } else {
        updateSelectInput(session, "secondLevel", choices = "Todos", selected = "Todos")
        shinyjs::hide("secondLevel") # Ocultar secondLevel
      }
    })
    
    
    # Renderizar tabelas com dados processados
    output$mainPlot <- renderTable({
      if(!is.null(processedDataNacional())){
        data <- processedDataNacional()
        data[[timeVar]] <- format(as.Date(data[[timeVar]]), "%Y-%m-%d")
        return(data)
      }else{
        return(NULL)
      }
    })
    
    output$mainPlot2 <- renderTable({
      if(!is.null(processedDataLevel1())){
        data <- processedDataLevel1()
        data[[timeVar]] <- format(as.Date(data[[timeVar]]), "%Y-%m-%d")
        return(data)
      }else{
        return(NULL)
      }
    })
    
    output$mainPlot3 <- renderTable({
      if(!is.null(processedDataLevel2())){
        data <- processedDataLevel2()
        data[[timeVar]] <- format(as.Date(data[[timeVar]]), "%Y-%m-%d")
        return(data)
      }else{
        return(NULL)
      }
    })
  })
}


