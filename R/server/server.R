library(shiny)


server <- function(input, output, session) {
  
  #caracterizacion page
  db_selected_country <- caracterizacionSeleccionarPaisServer("seleccionPais", db_list_countries)
  plot_line3LevelsServer("plot_A34_O00_O99", db_selected_country, "nivel_adm_1", "nivel_adm_2", "num_mortalidad_grupo_1", "date_ocur" )
  
  

  
}



