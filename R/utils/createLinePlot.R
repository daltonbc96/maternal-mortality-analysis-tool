createLinePlot <- function(processedDataNacional, processedDataLevel1, processedDataLevel2,
                           title = "", x_axis_label = "Periodo", y_axis_label = "Número de Casos",
                           legend_labels = c('Nacional', 'Level1', 'Level2')) {
  
  
  convertToPlotlyWithCSVButton <- function(ggplot_object, plot_height = NULL) {
    extrair_e_combinar_dados <- function(ggplot_obj) {
      # Lista para armazenar os data frames de cada layer
      dados_lista <- list()
      
      # Iterar através de cada layer no objeto ggplot
      for (i in seq_along(ggplot_obj$layers)) {
        # Extrair o data frame da layer atual
        dados_layer <- ggplot_obj$layers[[i]]$data
        
        # Adicionar o data frame à lista, se não for nulo
        if (!is.null(dados_layer)) {
          dados_lista[[i]] <- dados_layer
        }
      }
      
      # Combinar todos os data frames em um único data frame
      dados_combinados <- bind_rows(dados_lista)
      
      return(dados_combinados)
    }
    
    CSV_SVGpath <- "M284.1,150.5V31H108.3c-11.7,0-21.1,9.4-21.1,21.1v407.8c0,11.7,9.4,21.1,21.1,21.1h295.3c11.7,0,21.1-9.4,21.1-21.1V171.6 H305.2C293.6,171.6,284.1,162.1,284.1,150.5z M199.8,277.1c0,3.9-3.1,7-7,7h-7c-7.8,0-14.1,6.3-14.1,14.1v28.1 c0,7.8,6.3,14.1,14.1,14.1h7c3.9,0,7,3.1,7,7v14.1c0,3.9-3.1,7-7,7h-7c-23.3,0-42.2-18.9-42.2-42.2v-28.1 c0-23.3,18.9-42.2,42.2-42.2h7c3.9,0,7,3.1,7,7V277.1z M238.7,368.5h-10.8c-3.9,0-7-3.1-7-7v-14.1c0-3.9,3.1-7,7-7h10.8 c5.2,0,9.1-3.1,9.1-5.8c0-1.1-0.7-2.3-1.9-3.4l-19.2-16.5c-7.4-6.3-11.7-15.4-11.7-24.7c0-18.7,16.7-33.9,37.3-33.9H263 c3.9,0,7,3.1,7,7v14.1c0,3.9-3.1,7-7,7h-10.8c-5.2,0-9.1,3.1-9.1,5.8c0,1.1,0.7,2.3,1.9,3.4l19.2,16.5c7.4,6.3,11.7,15.4,11.7,24.7 C275.9,353.3,259.2,368.5,238.7,368.5L238.7,368.5z M312.2,263v18.3c0,17.8,5,35.3,14.1,50c9.1-14.7,14.1-32.2,14.1-50V263 c0-3.9,3.1-7,7-7h14.1c3.9,0,7,3.1,7,7v18.3c0,31.2-11.3,60.5-31.9,82.7c-2.7,2.9-6.4,4.5-10.3,4.5s-7.6-1.6-10.3-4.5 c-20.6-22.1-31.9-51.5-31.9-82.7V263c0-3.9,3.1-7,7-7h14.1C309.1,256,312.2,259.1,312.2,263z M418.6,123.3l-86-86.1 c-4-4-9.3-6.2-14.9-6.2h-5.4v112.5h112.5v-5.4C424.8,132.6,422.6,127.2,418.6,123.3z" 
    
    # Obter dados do gráfico ggplot
    # plot_data <- ggplot_build(ggplot_object)
    
    plot_data <- extrair_e_combinar_dados(ggplot_object)
    
    
    
    
    # Converter plot_data para formato JSON para uso no JavaScript
    plot_data_json <- jsonlite::toJSON(plot_data, dataframe = "rows")
    
    # Código JavaScript para o botão de download
    js <- sprintf(
      "function(gd) {
      var data = %s;
      var csvContent = 'data:text/csv;charset=utf-8,';
      // Adicionando cabeçalho de coluna
      csvContent += Object.keys(data[0]).join(',') + '\\n';
      data.forEach(function(row, index) {
        var rowContent = Object.values(row).join(',');
        csvContent += rowContent + '\\n';
      });
      var encodedUri = encodeURI(csvContent);
      var link = document.createElement('a');
      link.setAttribute('href', encodedUri);
      link.setAttribute('download', 'data.csv');
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
    }", plot_data_json
    )
    
    # Criar botão de exportação CSV
    CSVexport <- list(
      name = "Download Data",
      icon = list(
        path = CSV_SVGpath,
        width = 512,
        height = 512
      ),
      click = htmlwidgets::JS(js)
    )
    
    plotly_object <- ggplotly(ggplot_object, height = plot_height, tooltip = c("date_ocur", "count", "category")) %>%
      config(
        modeBarButtonsToAdd = list(CSVexport),
        modeBarButtonsToRemove = c( "pan2d", "select2d", "lasso2d", "zoomIn2d", "zoomOut2d", "autoScale2d", "resetScale2d", "hoverClosestCartesian", "hoverCompareCartesian")
      )
    
    plotly_object <- plotly_object %>% layout(
      xaxis = list(
        type = 'date',
        tickformat = '%d/%m/%Y'
      ))
    return(plotly_object)
  }
  
  
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




