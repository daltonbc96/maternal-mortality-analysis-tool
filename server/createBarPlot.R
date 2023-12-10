library(ggplot2)
library(plotly)
library(dplyr)


createBarPlot <- function(dados, targetVar, timeVar, groupVar, is_loading, xLabel, yLabel) {
  if (!is_loading && (is.null(dados) || nrow(dados) < 1)) {
    return(NULL)#tags$h3("Seleccione una localización para generar la información", style = "color: grey; text-align: center;"))
  }
  
  if (!all(c(targetVar, timeVar, groupVar) %in% names(dados))) {
    return(tags$h3("Esta localización no dispone de esta información", style = "color: grey; text-align: center;"))
  }
  
  dados_grouped <- processData(dados, targetVar, timeVar, groupVar)
  plot <- createPlots(dados_grouped, timeVar, groupVar, xLabel, yLabel)
  return(plot)
}




processData <- function(dados, targetVar, timeVar, groupVar) {
  if (!is.null(groupVar) && groupVar != "") {
    dados_grouped <- dados %>%
      group_by(!!sym(timeVar), !!sym(groupVar)) %>%
      summarise(count = n(), .groups = 'drop')  
  } else {
    dados_grouped <- dados %>%
      group_by(!!sym(timeVar)) %>%
      summarise(count = n(), .groups = 'drop')  
  }
  
  return(dados_grouped)
}






createPlots <- function(dados_grouped, timeVar, groupVar, xLabel, yLabel) {
  if (!is.null(groupVar) && groupVar != "") {
    num_categories <- length(unique(dados_grouped[[groupVar]]))
    plot_height <- 200 * num_categories  
    
    ggplot_object <- ggplot(dados_grouped, aes_string(x = timeVar, y = "count", fill = groupVar)) +
      geom_bar(stat = "identity", fill = "#0453d9", width = 0.9) +
      facet_wrap(~ get(groupVar), scales = "free_y", ncol = 1) +
      labs(x = xLabel, y = yLabel) +
      theme_minimal() +
      theme(strip.text = element_text(size = 10), 
            axis.text.x = element_text(angle = 45, hjust = 1))
    
    # Converter o objeto ggplot para plotly e ajustar a altura diretamente aqui
    plotly_object <- ggplotly(ggplot_object, height = plot_height) %>% config(displayModeBar = F)
    
    return(plotly_object)
  } else {
    ggplot_object <- ggplot(dados_grouped, aes_string(x = timeVar, y = "count")) +
      geom_bar(stat = "identity", fill = "#0453d9", width = 0.9) +
      labs(x = xLabel, y = yLabel) +
      theme_minimal()
    
    # Converter o objeto ggplot para plotly com uma altura padrão para um único plot
    plotly_object <- ggplotly(ggplot_object, height = 200)  %>% config(displayModeBar = F)
    
    return(plotly_object)
  }
}





