# Inicializa a lista global
globalSelections <- reactiveValues(lists = list())

# Função para atualizar a lista global específica
updateGlobalSelections <- function(listID, newSelections) {
  globalSelections$lists[[listID]] <- unique(newSelections)
}

# Função para obter a lista global específica
getGlobalSelections <- function(listID) {
  if (!listID %in% names(globalSelections$lists)) {
    return(character(0))
  }
  return(globalSelections$lists[[listID]])
}

# Função para verificar se um valor está selecionado
isValueSelected <- function(listID, value) {
  return(value %in% getGlobalSelections(listID))
}



getSelectedNames <- function(tree_input, parent_items = NULL) {
  selections <- get_selected(tree_input, format = "slices")
  selected_names <- character(0) 
  
  if (!is.null(selections)) {
    for (i in seq_along(selections)) {
      if (!is.null(selections[[i]])) {
        # Verifica se há subitens no nível seguinte
        subitems <- selections[[i]]
        if (!is.null(subitems[[1]]) && is.list(subitems[[1]])) {
          # Se houver subitens, extrai o último nível
          last_subitem <- subitems[[length(subitems)]]
          selected_names <- c(selected_names, names(last_subitem))
        } else {
          # Se não houver subitens, apenas adicione o nome do item de primeiro nível
          selected_names <- c(selected_names, names(subitems))
        }
      }
    }
  }
  
  # Remove os nomes dos itens pais, se fornecido
  if (!is.null(parent_items)) {
    selected_names <- setdiff(selected_names, parent_items)
  }
  
  
  
  # Remove nomes duplicados
  selected_names <- unique(selected_names)
  #cat("Selected names after setdiff:", selected_names, "\n")
  
  return(selected_names)
}

