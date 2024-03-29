

createLineChart <- function(processedDataNacional, processedDataLevel1, processedDataLevel2,
                            title = "",
                            xAxisLabel = "Periodo",
                            yAxisLabel = "Número de Casos",
                            legendTitle = "",
                            legendLabels = c("Nacional", "Primer Nivel", "Segundo Nivel")) {
  
  
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
    
    # Converter o gráfico ggplot para plotly e adicionar botão de download CSV
    plotly_object <- ggplotly(ggplot_object, height = plot_height, tooltip = "text")  %>%
      config( modeBarButtonsToAdd = list(CSVexport),
              modeBarButtonsToRemove = c(
                "zoom2d",
                "pan2d",
                "select2d",
                "lasso2d",
                "zoomIn2d",
                "zoomOut2d",
                "autoScale2d",
                "resetScale2d",
                "hoverClosestCartesian",
                "hoverCompareCartesian"
              ))
    
    return(plotly_object)
  }
 
    # Inicializar o gráfico ggplot
    plot <- ggplot() +
      labs(title = title, x = xAxisLabel, y = yAxisLabel, color = legendTitle) +
      scale_y_continuous(limits = c(0, NA)) +
      theme_minimal() 
    
    # Função auxiliar para preparar os dados
    prepareData <- function(data, colorName, levelLabel) {
      if (!is.null(data) && nrow(data) > 0) {
        location_column <- ifelse(levelLabel == "Nacional", "Nacional", 
                                  ifelse(levelLabel == "Primer Nivel", "nivel_adm_1", "nivel_adm_2"))
        
        data <- data %>%
          mutate(
            date_ocur = as.Date(date_ocur),
            location = ifelse(levelLabel == "Nacional", "Nacional", data[[location_column]]),
            hover_text = paste("Fecha: ", format(date_ocur, "%d/%m/%Y"), 
                               "<br>Número de Casos: ", count, 
                               "<br>Nível: ", levelLabel,
                               "<br>Ubicación: ", location)
          )
        
        suppressWarnings(plot <<- plot + geom_line(data = data, aes(x = date_ocur, y = count, color = colorName, group = colorName, text = hover_text)))
        return(data)
      }
    }
    
    
    # Aplicar a função auxiliar a cada conjunto de dados
    nacional <- prepareData(processedDataNacional, "Nacional", "Nacional")
    nivel1 <- prepareData(processedDataLevel1, "Primer Nivel", "Primer Nivel")
    nivel2 <- prepareData(processedDataLevel2, "Segundo Nivel", "Segundo Nivel")
    
    
  
    plotly_object <- convertToPlotlyWithCSVButton(plot)
    
    
    
    # Converter para Plotly
    plotly_object <- plotly_object %>% layout(xaxis = list(type = 'date', tickformat = '%d/%m/%Y'))
    for(i in seq_along(plotly_object$data)) {
      plotly_object$data[[i]]$hovertemplate <- plotly_object$data[[i]]$text
    }
    
    
    return(plotly_object)
  }

