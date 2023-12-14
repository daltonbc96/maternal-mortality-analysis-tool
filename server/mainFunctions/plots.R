library(plotly)
library(ggplot2)
library(duckdb)
library(dplyr)
library(rlang) 


convertToPlotlyWithCSVButton <- function(ggplot_object, plot_height = NULL) {
  
  CSV_SVGpath <- "M284.1,150.5V31H108.3c-11.7,0-21.1,9.4-21.1,21.1v407.8c0,11.7,9.4,21.1,21.1,21.1h295.3c11.7,0,21.1-9.4,21.1-21.1V171.6 H305.2C293.6,171.6,284.1,162.1,284.1,150.5z M199.8,277.1c0,3.9-3.1,7-7,7h-7c-7.8,0-14.1,6.3-14.1,14.1v28.1 c0,7.8,6.3,14.1,14.1,14.1h7c3.9,0,7,3.1,7,7v14.1c0,3.9-3.1,7-7,7h-7c-23.3,0-42.2-18.9-42.2-42.2v-28.1 c0-23.3,18.9-42.2,42.2-42.2h7c3.9,0,7,3.1,7,7V277.1z M238.7,368.5h-10.8c-3.9,0-7-3.1-7-7v-14.1c0-3.9,3.1-7,7-7h10.8 c5.2,0,9.1-3.1,9.1-5.8c0-1.1-0.7-2.3-1.9-3.4l-19.2-16.5c-7.4-6.3-11.7-15.4-11.7-24.7c0-18.7,16.7-33.9,37.3-33.9H263 c3.9,0,7,3.1,7,7v14.1c0,3.9-3.1,7-7,7h-10.8c-5.2,0-9.1,3.1-9.1,5.8c0,1.1,0.7,2.3,1.9,3.4l19.2,16.5c7.4,6.3,11.7,15.4,11.7,24.7 C275.9,353.3,259.2,368.5,238.7,368.5L238.7,368.5z M312.2,263v18.3c0,17.8,5,35.3,14.1,50c9.1-14.7,14.1-32.2,14.1-50V263 c0-3.9,3.1-7,7-7h14.1c3.9,0,7,3.1,7,7v18.3c0,31.2-11.3,60.5-31.9,82.7c-2.7,2.9-6.4,4.5-10.3,4.5s-7.6-1.6-10.3-4.5 c-20.6-22.1-31.9-51.5-31.9-82.7V263c0-3.9,3.1-7,7-7h14.1C309.1,256,312.2,259.1,312.2,263z M418.6,123.3l-86-86.1 c-4-4-9.3-6.2-14.9-6.2h-5.4v112.5h112.5v-5.4C424.8,132.6,422.6,127.2,418.6,123.3z" 
 
   # Obter dados do gráfico ggplot
  plot_data <- ggplot_build(ggplot_object)$plot$data
  
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
  plotly_object <- ggplotly(ggplot_object, height = plot_height) %>%
    config(
      modeBarButtonsToAdd = list(CSVexport),
      modeBarButtonsToRemove = c("zoom2d", "pan2d", "select2d", "lasso2d", "zoomIn2d", "zoomOut2d", "autoScale2d", "resetScale2d", "hoverClosestCartesian", "hoverCompareCartesian")
    )
  
  return(plotly_object)
}



createLinePlot <- function(dados, timeVar, xLabel, yLabel, groupVar = NULL, lineColor = "#0453d9", isMM = TRUE) {
  processData <- function(dados, timeVar, groupVar = NULL, isMM) {

    
    # Conectar o dataframe ao DuckDB
    con <- duckdb::dbConnect(duckdb::duckdb(), ":memory:")
    on.exit(duckdb::dbDisconnect(con, shutdown = TRUE)) # Garantir desconexão ao sair da função
    duckdb::duckdb_register(con, "dados", dados)
    
    # Criar objeto tbl_lazy referenciando a tabela no DuckDB
    dados_duckdb <- dplyr::tbl(con, "dados") %>%
      dplyr::filter(!is.na(!!rlang::sym(timeVar)))
    
    # Filtrar para maternal_mortality == TRUE se isMM for TRUE
    if (isMM) {
      dados_duckdb <- dados_duckdb %>% dplyr::filter(maternal_mortality == TRUE)
    }
    
    # Verificar e processar groupVar
    if (!is.null(groupVar) && groupVar != "") {
      groupVar_sym <- rlang::sym(groupVar)
      
      # Remover linhas onde groupVar é NA, se groupVar for fornecida
      dados_duckdb <- dados_duckdb %>% dplyr::filter(!is.na(!!groupVar_sym))
      
      # Processamento para groupVar booleana
      if (is.logical(dados[[groupVar]]) && all(dados[[groupVar]] %in% c(TRUE, FALSE))) {
        dados_grouped <- dados_duckdb %>%
          dplyr::group_by(!!rlang::sym(timeVar), !!groupVar_sym) %>%
          dplyr::summarise(count = dplyr::n(), .groups = 'drop') %>%
          dplyr::mutate(count = dplyr::if_else(!!groupVar_sym == FALSE, 0, count)) %>%
          tidyr::complete(!!rlang::sym(timeVar), !!groupVar_sym, fill = list(count = 0)) %>%
          dplyr::select(-!!groupVar_sym)
        
        groupVar <- NULL  # Remover groupVar se for booleana
      } else {
        # Processamento para groupVar não booleana
        dados_grouped <- dados_duckdb %>%
          dplyr::group_by(!!rlang::sym(timeVar), !!groupVar_sym) %>%
          dplyr::summarise(count = dplyr::n(), .groups = 'drop') %>%
          tidyr::complete(!!rlang::sym(timeVar), !!groupVar_sym, fill = list(count = 0))
      }
    } else {
      # Processamento para quando groupVar é NULL ou vazia
      dados_grouped <- dados_duckdb %>%
        dplyr::group_by(!!rlang::sym(timeVar)) %>%
        dplyr::summarise(count = dplyr::n(), .groups = 'drop') %>%
        tidyr::complete(!!rlang::sym(timeVar), fill = list(count = 0))
    }
    
    # Coletar os resultados processados
    dados_grouped <- dplyr::collect(dados_grouped)
    
    return(list(data = dados_grouped, groupVar = groupVar))
  }
  
  createLinePlot <- function(dados_grouped, timeVar, xLabel, yLabel, groupVar = NULL, lineColor = "#0453d9") {
    # Criar o gráfico de linhas com ggplot
    ggplot_object <- ggplot(dados_grouped, aes_string(x = timeVar, y = "count", group = groupVar, color = groupVar)) +
      geom_line(color = lineColor) +
      labs(x = xLabel, y = yLabel) +
      theme_minimal() +
      scale_y_continuous(limits = c(0, NA))
    
    # Calcular a altura do gráfico
    plot_height <- 200  # Altura padrão para um único gráfico
    
    # Adicionar subplots se groupVar for fornecido e existir no dataframe
    if (!is.null(groupVar) && groupVar %in% names(dados_grouped)) {
      num_categories <- length(unique(dados_grouped[[groupVar]]))
      plot_height <- 200 * num_categories  # Altura ajustada com base no número de subplots
      ggplot_object <- ggplot_object +
        facet_wrap(~ get(groupVar), scales = "free_y", ncol = 1)
    }
    
    # Converter o gráfico ggplot para plotly com botão de download CSV
    plotly_object <- convertToPlotlyWithCSVButton(ggplot_object, plot_height)
    
    return(plotly_object)
  }
  

  
  # Se groupVar não for NULL, verifique se está em dados
  if (!is.null(groupVar) && !groupVar %in% names(dados)) {
    return(tags$h3("Esta localización no dispone de esta información", style = "color: grey; text-align: center;"))
  }
  
 
  
  processed <- processData(dados, timeVar, groupVar, isMM)
  dados_grouped <- processed$data
  groupVar <- processed$groupVar  
  
  
  # Criar o gráfico de linha
  plot <- createLinePlot(dados_grouped, timeVar, xLabel, yLabel, groupVar, lineColor)
  
  return(plot)
}

createAreaPlot <- function(dados, timeVar, groupVar, xLabel, yLabel, isMM = TRUE) {
  processData <- function(dados, timeVar, groupVar, isMM) {
    
    # Conectar o dataframe ao DuckDB
    con <- duckdb::dbConnect(duckdb::duckdb(), ":memory:")
    on.exit(duckdb::dbDisconnect(con, shutdown = TRUE))
    duckdb::duckdb_register(con, "dados", dados)
    
    # Criar objeto tbl_lazy referenciando a tabela no DuckDB
    dados_duckdb <- dplyr::tbl(con, "dados") %>%
      dplyr::filter(!is.na(!!rlang::sym(timeVar)))
    
    # Filtrar para maternal_mortality == TRUE se isMM for TRUE
    if (isMM) {
      dados_duckdb <- dados_duckdb %>% dplyr::filter(maternal_mortality == TRUE)
    }
    
    # Convertendo os nomes das variáveis para símbolos
    timeVar_sym <- rlang::sym(timeVar)
    groupVar_sym <- rlang::sym(groupVar)
    
    # Agrupamento e contagem dos dados
    dados_grouped <- dados_duckdb %>%
      dplyr::group_by(!!timeVar_sym, !!groupVar_sym) %>%
      dplyr::summarise(count = dplyr::n(), .groups = 'drop')
    
    # Calcular o total por timeVar
    total_counts <- dados_duckdb %>%
      dplyr::group_by(!!timeVar_sym) %>%
      dplyr::summarise(total = dplyr::n(), .groups = 'drop')
    
    # Completar os dados faltantes e calcular a porcentagem
    resultado <- dados_grouped %>%
      tidyr::complete(!!timeVar_sym, !!groupVar_sym, fill = list(count = 0)) %>%
      dplyr::left_join(total_counts, by = setNames(nm = as.character(timeVar_sym), timeVar)) %>%
      dplyr::mutate(porcentaje = dplyr::if_else(total > 0, (count * 100.0) / total, 0)) %>%
      dplyr::select(!!timeVar_sym, !!groupVar_sym, count, porcentaje) %>%
      dplyr::arrange(!!timeVar_sym) %>%
      dplyr::collect()
    
    return(resultado)
  }
  
  
  createAreaPlots <- function(dados_grouped, timeVar, groupVar, xLabel, yLabel) {
    ggplot_object <- ggplot(dados_grouped, aes_string(x = timeVar, y = "porcentaje", fill = groupVar)) +
      geom_area(position = "stack", alpha = 0.7) + 
      scale_fill_manual(values = c("red", "blue", "green")) +
      labs(x = xLabel, y = yLabel) +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      guides(fill = guide_legend(title = NULL))
    
    # Converter para plotly com altura definida
    plotly_object <- ggplotly(ggplot_object) %>% config(displayModeBar = F)
    
    return(plotly_object)
  }
  
  dados_grouped <- processData(dados, timeVar, groupVar, isMM)
  plot <- createAreaPlots(dados_grouped, timeVar, groupVar, xLabel, yLabel)
  return(plot)
}

createTable <- function(dados, timeVar, groupVar, groupVar2 = NULL, nomeColuna1 = "Grupo1", nomeColuna2 = "Grupo2", isMM= TRUE) {
  
  processarDados <- function(dados, timeVar, groupVar, groupVar2 = NULL, nomeColuna1, nomeColuna2, isMM) {
    
    # Conectar o dataframe ao DuckDB
    con <- dbConnect(duckdb::duckdb(), ":memory:")
    duckdb::duckdb_register(con, "dados", dados)
    
    # Criar uma lista dinâmica de símbolos para as variáveis de agrupamento
    group_vars <- syms(c(groupVar, if (!is.null(groupVar2)) groupVar2))
    
    # Preparar e executar a consulta usando dplyr e DuckDB
    dados_duckdb <- tbl(con, "dados") %>%
      mutate(Ano = as.character(year(as.Date(!!sym(timeVar))))) %>%
      filter(!is.na(Ano))
    
    # Filtrar para maternal_mortality == TRUE se isMM for TRUE
    if (isMM) {
      dados_duckdb <- dados_duckdb %>% filter(maternal_mortality == TRUE)
    }
    
    # Continuar com o processamento
    dados_duckdb <- dados_duckdb %>%
      group_by(!!!group_vars, Ano) %>%
      summarise(Casos = n(), .groups = 'drop') %>%
      collect()
    
    # Espalhar os anos para colunas separadas
    dados_finais <- dados_duckdb %>%
      pivot_wider(names_from = Ano, values_from = Casos, values_fill = list(Casos = 0))
    
    # Ordenar as colunas de anos cronologicamente
    colunas_ano <- sort(setdiff(names(dados_finais), c(groupVar, if (!is.null(groupVar2)) groupVar2, "Casos")))
    colunas_finais <- c(groupVar, if (!is.null(groupVar2)) groupVar2, colunas_ano)
    
    dados_finais <- dados_finais[, colunas_finais]
    
    # Renomear as duas primeiras colunas
    names(dados_finais)[1] <- nomeColuna1
    if (!is.null(groupVar2)) {
      names(dados_finais)[2] <- nomeColuna2
    }
    
    # Calcular o total de casos
    total_casos <- dados_duckdb %>%
      group_by(!!!group_vars) %>%
      summarise(Total = sum(Casos), .groups = 'drop') %>%
      collect()
    
    # Renomear colunas em total_casos para combinar com dados_finais
    names(total_casos)[1] <- nomeColuna1
    if (!is.null(groupVar2)) {
      names(total_casos)[2] <- nomeColuna2
    }
    
    # Fundir dados_finais e total_casos
    if (is.null(groupVar2)) {
      dados_finais <- merge(dados_finais, total_casos, by = nomeColuna1)
    } else {
      dados_finais <- merge(dados_finais, total_casos, by = c(nomeColuna1, nomeColuna2))
    }
    
    # Reorganizar para colocar a coluna Total na terceira posição
    colunas <- colnames(dados_finais)
    colunas <- c(nomeColuna1, if (!is.null(groupVar2)) nomeColuna2, "Total", colunas[!(colunas %in% c(nomeColuna1, nomeColuna2, "Total"))])
    dados_finais <- dados_finais[, colunas]
    
    # Desconectar do DuckDB
    dbDisconnect(con, shutdown = TRUE)
    
    return(dados_finais)
  }
  
  # Se groupVar não for NULL, verifique se está em dados
  if (!is.null(groupVar) && !groupVar %in% names(dados)) {
    return(tags$h3("Esta localización no dispone de esta información", style = "color: grey; text-align: center;"))
  }
  
  
  if (!is.null(groupVar2) && !groupVar2 %in% names(dados)) {
    return(tags$h3("Esta localización no dispone de esta información", style = "color: grey; text-align: center;"))
  }
  
  
  dados_processados <- processarDados(dados, timeVar, groupVar, groupVar2, nomeColuna1, nomeColuna2, isMM)
  
  DT::datatable(
    dados_processados,
    extensions = 'Buttons',
    class = 'cell-border stripe',
    options = list(
      paging = TRUE,
      scrollX = TRUE,
      dom = 'l<"sep">Bfrtip',
      buttons = c('copy', 'csv', 'excel', 'pdf'),
      pageLength = 10,
      lengthMenu = c(5, 10, 20, 50, 100),
      autoWidth = TRUE
    )
  )
}
