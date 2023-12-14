library(dplyr)
library(tidyr)
library(DT)
library(lubridate)



renderizar_tabela <- function(dados_filtrados, timeVar, groupVar, is_loading) {
  # Subfunções definidas anteriormente
  
  verificarColunas <- function(dados, timeVar, groupVar) {
    all(c(timeVar, groupVar) %in% names(dados))
  }
  
  converterData <- function(dados, timeVar) {
    dados %>% mutate(!!sym(timeVar) := year(as.Date(!!sym(timeVar), format = "%Y-%m-%d")))
  }
  
  calcularAgrupamentos <- function(dados, timeVar, groupVar) {
    dados_agrupados <- dados %>%
      group_by(!!sym(timeVar), !!sym(groupVar)) %>%
      summarise(count = n(), .groups = 'drop')
    
    total_counts <- dados_agrupados %>%
      group_by(!!sym(timeVar)) %>%
      summarise(total = sum(count), .groups = 'drop')
    
    dados_agrupados %>%
      left_join(total_counts, by = timeVar) %>%
      mutate(percentage = round((count / total) * 100, 2))
  }
  
  estruturarTabela <- function(dados, groupVar, timeVar) {
    dados %>%
      select(!!sym(groupVar), !!sym(timeVar), percentage) %>%
      pivot_wider(names_from = !!sym(timeVar), values_from = percentage)
  }
  
  # Lógica principal da função renderizar_tabela
  
  if (!verificarColunas(dados_filtrados, timeVar, groupVar)) {
    return(tags$h3("Esta localización no dispone de esta información", style = "color: grey; text-align: center;"))
  }
  
  if (is.null(dados_filtrados) && !is_loading) {
    return(tags$h3("Seleccione una localización para generar la información", style = "color: grey; text-align: center;"))
  } else if (!is.null(dados_filtrados) && nrow(dados_filtrados) > 0) {
    dados_filtrados <- converterData(dados_filtrados, timeVar)
    dados_agrupados <- calcularAgrupamentos(dados_filtrados, timeVar, groupVar)
    dados_tabela <- estruturarTabela(dados_agrupados, groupVar, timeVar)
    
    DT::datatable(
      dados_tabela,
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
