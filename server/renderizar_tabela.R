library(dplyr)
library(tidyr)
library(DT)
library(lubridate)



renderizar_tabela <- function(dados_filtrados, timeVar, groupVar, is_loading) {
  processarDados <- function(dados, timeVar, groupVar) {
    # Converter timeVar para formato de data e extrair o ano
    dados <- dados %>%
      mutate(!!sym(timeVar) := year(as.Date(!!sym(timeVar))))
    
    # Calcular a contagem de linhas por ano e por categoria de groupVar
    dados_agrupados <- dados %>%
      group_by(!!sym(timeVar), !!sym(groupVar)) %>%
      summarise(count = n(), .groups = 'drop')
    
    # Calcular a contagem total por ano
    total_counts <- dados_agrupados %>%
      group_by(!!sym(timeVar)) %>%
      summarise(total = sum(count), .groups = 'drop')
    
    # Calcular a porcentagem
    dados_porcentagem <- dados_agrupados %>%
      left_join(total_counts, by = timeVar) %>%
      mutate(percentage = round((count / total) * 100, 2))
    
    # Reestruturar os dados para o formato de tabela
    dados_tabela <- dados_porcentagem %>%
      select(!!sym(groupVar), !!sym(timeVar), percentage) %>%
      pivot_wider(names_from = !!sym(timeVar), values_from = percentage)
    
    return(dados_tabela)
  }
  
  
  mensage <- ""
  
  if (!all(c(timeVar, groupVar) %in% names(dados_filtrados))) {
    return(tags$h3("Esta localización no dispone de esta información", style = "color: grey; text-align: center;"))
  }
  
  if (is.null(dados_filtrados) && !is_loading) {
    mensage <- "Seleccione una localización para generar la información"
    return(tags$h3(mensage, style = "color: grey; text-align: center;"))
    
  } else if (!is.null(dados_filtrados) && nrow(dados_filtrados) > 0) {
    dados_processados <- processarDados(dados_filtrados, timeVar, groupVar)
    
    DT::datatable(
      dados_processados,
      extensions = 'Buttons',
      class = 'cell-border stripe',
      options = list(
        paging = TRUE,
        scrollX = TRUE,
        searching = TRUE,
        ordering = TRUE,
        dom = 'l<"sep">Bfrtip',
        buttons = c('copy', 'csv', 'excel', 'pdf'),
        pageLength = 10,
        lengthMenu = c(5, 10, 20, 50, 100)
      )
    )
  } else {
    return(NULL)
  }
}















# renderizar_tabela <- function(dados_filtrados, is_loading) {
#   mensage <- ""
#   if (is.null(dados_filtrados) && !is_loading) {
#     mensage <- "Seleccione una localización para generar la información"
#     return(tags$h3(mensage, style = "color: grey; text-align: center;"))
#     
#   } else if (!is.null(dados_filtrados) &&
#              nrow(dados_filtrados) > 0) {
#     DT::datatable(
#       dados_filtrados,
#       extensions = 'Buttons',
#       class = 'cell-border stripe',
#       options = list(
#         paging = TRUE,
#         scrollX = TRUE,
#         searching = TRUE,
#         ordering = TRUE,
#         dom = 'l<"sep">Bfrtip',
#         buttons = c('copy', 'csv', 'excel', 'pdf'),
#         pageLength = 5,
#         lengthMenu = c(5, 10, 20, 50, 100)
#       )
#     )
#   } else {
#     return(NULL)
#   }
# }
