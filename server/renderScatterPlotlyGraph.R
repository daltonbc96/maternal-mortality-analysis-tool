renderScatterPlotlyGraph <- function(output, btn, plotId, data, varName, title, xaxis, yaxis, colorway, groupByVar = NULL, errorMessage = "Dados não disponíveis") {
  output[[plotId]] <- renderUI({
    if (is.null(data) || !(varName %in% names(data))) {
      tagList(h4(errorMessage, style = 'color: red;')) 
    }else if (btn > 0) {  
      if (is.null(data) || nrow(data) == 0) {
        tagList(h4(errorMessage, style = 'color: red;'))
      } else {
        plotlyOutput(paste0(plotId, "_plotly"))
      }
    }
  })
  
  output[[paste0(plotId, "_plotly")]] <- renderPlotly({
    
    if (!is.null(groupByVar) && groupByVar %in% names(data)) {
      
      
      plot_ly(data, x = ~fecha_def, y = as.formula(paste0("~", varName)), split = ~get(groupByVar),
              type = 'scatter', mode = 'lines+markers') %>%
        layout(title = title, xaxis = list(title = xaxis), yaxis = list(title = yaxis), colorway = colorway) %>%
        config(displayModeBar = FALSE) 
    }   else {
      plot_ly(data, x = ~fecha_def, y = as.formula(paste0("~", varName)), 
              type = 'scatter', mode = 'lines+markers') %>%
        layout(title = title, xaxis = list(title = xaxis), yaxis = list(title = yaxis), colorway = colorway) %>%
        config(displayModeBar = FALSE) 
      
    }
  })
}
