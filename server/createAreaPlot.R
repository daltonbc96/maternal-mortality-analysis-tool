library(ggplot2)
library(plotly)
library(dplyr)

createAreaPlot <- function(dados, targetVar, timeVar, groupVar, is_loading, xLabel, yLabel) {
  
  processData <- function(dados, targetVar, timeVar, groupVar) {
    # Calcular a contagem por grupo
    dados_grouped <- dados %>%
      group_by(!!sym(timeVar), !!sym(groupVar)) %>%
      summarise(count = n(), .groups = 'drop')
    
    # Calcular a contagem total por timeVar
    total_counts <- dados %>%
      group_by(!!sym(timeVar)) %>%
      summarise(total = n(), .groups = 'drop')
    
    # Calcular a porcentagem
    dados_grouped <- dados_grouped %>%
      left_join(total_counts, by = timeVar) %>%
      mutate(percentage = (count / total) * 100) %>%
      arrange(!!sym(timeVar))
    
    return(dados_grouped)
  }
  
  createAreaPlots <- function(dados_grouped, timeVar, groupVar, xLabel, yLabel) {
    ggplot_object <- ggplot(dados_grouped, aes_string(x = timeVar, y = "percentage", fill = groupVar)) +
      geom_area(stat = "identity", position = "identity", alpha = 0.7) + 
      scale_fill_manual(values =  c("red", "blue", "green")) +
      labs(x = xLabel, y = yLabel) +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      guides(fill = guide_legend(title = NULL)) 
    
    # Converter o objeto ggplot para plotly
    plotly_object <- ggplotly(ggplot_object) %>% config(displayModeBar = F)
    
    return(plotly_object)
  }
  
  
  
  if (!is_loading && (is.null(dados) || nrow(dados) < 1)) {
    return(tags$h3("Seleccione una localización para generar la información", style = "color: grey; text-align: center;"))
  }
  
  if (!all(c(targetVar, timeVar, groupVar) %in% names(dados))) {
    return(tags$h3("Esta localización no dispone de esta información", style = "color: grey; text-align: center;"))
  }
  
  dados_grouped <- processData(dados, targetVar, timeVar, groupVar)
  plot <- createAreaPlots(dados_grouped, timeVar, groupVar, xLabel, yLabel)
  return(plot)
}