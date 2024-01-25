source("R/utils/convertToPlotlyWithCSVButton.R")

createLinePlot <- function(processedDataNacional, processedDataLevel1, processedDataLevel2,
                           title = "", x_axis_label = "Periodo", y_axis_label = "Número de Casos",
                           legend_labels = c('Nacional', 'Level1', 'Level2')) {
  if (is.null(processedDataNacional) || length(processedDataNacional) == 0 ){
    return(NULL)
  }
  

  # Iniciar com um gráfico vazio
  plot <- ggplot() + theme_minimal() +
    labs(title = title, x = x_axis_label, y = y_axis_label) +
    scale_y_continuous(limits = c(0, NA)) 
  
  
  # Estilos de linha
  line_types <- c('solid', 'solid', 'solid')
  
  # Adicionar categoria aos dados se eles não estiverem vazios
  addCategory <- function(data, category) {
    if (!is.null(data) && nrow(data) > 0) {
      data$category <- category
      data$group <- category
      return(data)
    }
    return(NULL)
  }
  
  processedDataNacional <- addCategory(processedDataNacional, legend_labels[1])
  processedDataLevel1 <- addCategory(processedDataLevel1, legend_labels[2])
  processedDataLevel2 <- addCategory(processedDataLevel2, legend_labels[3])
  
  # Adicionar dados ao gráfico
  plotData <- function(data) {
    if (!is.null(data) && nrow(data) > 0) {
      data$date_ocur <- as.Date(data$date_ocur, format = "%Y-%m-%d")
      plot <<- plot + 
        geom_line(data = data, aes(x = date_ocur, y = count, colour = category, linetype = category, group = group))
    }
  }
  
  # Ajustar a ordem de adição dos dados ao gráfico
 
  plotData(processedDataNacional)  # Desenhada por último, no topo
  plotData(processedDataLevel1)  # Desenhada em seguida
  plotData(processedDataLevel2)  # Desenhada primeiro
  
  # Definir cores, estilos de linha e nome da legenda
  colours <- setNames(c("#0072B2", "#72b200", "#b20072"), legend_labels)
  plot <- plot + 
    scale_colour_manual(values = colours, name = "Nivel Administrativo") +
    scale_linetype_manual(values = setNames(line_types, legend_labels), name = "Nivel Administrativo")
  
  plotly_object <- convertToPlotlyWithCSVButton(plot)

  return(plotly_object)

}




