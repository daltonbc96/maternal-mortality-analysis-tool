processData <- function(data,
                        timeVar,
                        target,
                        groupVar = NULL,
                        level1 = NULL,
                        level2 = NULL,
                        filterYear = NULL,
                        filterLevel1 = NULL,
                        filterLevel2 = NULL) {

  
  # Adicionando a coluna ano
  data$Year <- format(data[[timeVar]], "%Y")

  
  # Conectando ao DuckDB
  con <- duckdb::dbConnect(duckdb::duckdb(), ":memory:")
  on.exit(duckdb::dbDisconnect(con, shutdown = TRUE))
  duckdb::duckdb_register(con, "data", data)
  
  # Preparando a tabela com DuckDB
  data_duckdb <- dplyr::tbl(con, "data") %>%
    dplyr::filter(!is.na(!!rlang::sym(timeVar)))
  
  # Aplicando filtros
  if (!is.null(filterYear)) {
    data_duckdb <- data_duckdb %>%
      dplyr::filter(!!rlang::sym("Year") %in% filterYear)
  }
  
  if (!is.null(filterLevel1) && !is.null(level1)) {
    data_duckdb <- data_duckdb %>%
      dplyr::filter(!!rlang::sym(level1) == filterLevel1)
  }
  
  if (!is.null(filterLevel2) && !is.null(level2)) {
    data_duckdb <- data_duckdb %>%
      dplyr::filter(!!rlang::sym(level2) == filterLevel2)
  }
  
  # Preparando colunas para agrupamento
  group_cols <- list(rlang::sym(timeVar))
  if (!is.null(groupVar) && groupVar != "") {
    group_cols <- c(group_cols, rlang::sym(groupVar))
  }
  if (!is.null(level1)) {
    group_cols <- c(group_cols, rlang::sym(level1))
  }
  if (!is.null(level2)) {
    group_cols <- c(group_cols, rlang::sym(level2))
  }
  
  # Agrupando e contando os casos TRUE
  data_grouped <- data_duckdb %>%
    dplyr::group_by(!!!group_cols) %>%
    dplyr::summarise(count = sum(ifelse(!!rlang::sym(target), 1, 0), na.rm = TRUE),
                     .groups = 'drop')
  
  # Coletando os resultados processados
  data_grouped <- dplyr::collect(data_grouped)
  
  return(data_grouped)
}



processDataNacional <- function(data, timeVar, target, filterYear = NULL, groupVar= NULL) {
  
  if (!is.null(data) & !is.null(timeVar) & !is.null(target)){
    return(
    processData(
    data =  data, 
    timeVar = timeVar, 
    target = target,
    groupVar = groupVar,
    filterYear = filterYear
 
  ))
 } else {
    return(NULL)
  }

}


processDataLevel1 <- function(data, timeVar, target,  level1, filterLevel1 = NULL, groupVar= NULL, filterYear = NULL) {
  if (!is.null(data) & !is.null(timeVar) & !is.null(target)){
    return(
    processData(
    data = data, 
    timeVar = timeVar, 
    target = target,
    groupVar = groupVar,
    level1 = level1,
    filterLevel1 = filterLevel1,
    filterYear = filterYear
  ))
 } else {
    return(NULL)
  }
}


processDataLevel2 <- function(data, timeVar, target, level2,filterLevel2 = NULL, groupVar= NULL, filterYear = NULL) {
  if (!is.null(data) & !is.null(timeVar) & !is.null(target)){
    return(
    processData(
    data = data, 
    timeVar = timeVar, 
    target = target,
    groupVar = groupVar,
    level2 = level2,
    filterLevel2 = filterLevel2,
    filterYear = filterYear
  ))
 } else {
    return(NULL)
  }
}






