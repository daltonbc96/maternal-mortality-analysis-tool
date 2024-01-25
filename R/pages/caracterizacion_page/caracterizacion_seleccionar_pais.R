caracterizacionSeleccionarPaisUI <- function(id, lista_paises) {
  ns <- NS(id)
  argonRow(argonColumn(
    width = 12,
    argonCard(
      width = 12,
      border_level = 10,
      shadow = TRUE,
      h2("Seleccione un País:", style = 'color:#009cda; text-align: left;'),
      selectInput(
        inputId = ns("pais_caracterizacion"),
        label = "",
        choices = c("", names(lista_paises)),
        selected = NULL
      )
    )
  ))
}


caracterizacionSeleccionarPaisServer <- function(id, lista_paises) {
  moduleServer(id,
               function(input, output, session) {
                 reactive({
                   selected_country <- input$pais_caracterizacion
                   if (selected_country != "") {
                     return(lista_paises[[selected_country]])
                     
                   } else {
                     return(NULL)
                   }
                 })
                 
               })
}
