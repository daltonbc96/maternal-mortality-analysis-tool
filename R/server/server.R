library(shiny)


server <- function(input, output, session) {
  
  #caracterizacion page

  db_selected_country <- caracterizacionSeleccionarPaisServer("seleccionPais", db_list_countries)
  plot_line3LevelsServer("plot_A34_O00_O99", db_selected_country, "nivel_adm_1", "nivel_adm_2", "num_mortalidad_grupo_1", "date_ocur" )
  barChartServer("barChartModule", db_selected_country, "nivel_adm_1", "num_mortalidad_grupo_1", "date_ocur")
  edadBarPlotServer(id = "edadBarPlot", db_selected_country = db_selected_country, column_firstLevel = "nivel_adm_1", column_secondLevel = "nivel_adm_2",targetVar =  "num_mortalidad_grupo_1", timeVar = "date_ocur", groupVar = "grupo_edad_1")
  BarPlotServer(id = "lugarOcurBarPlot", db_selected_country = db_selected_country, column_firstLevel = "nivel_adm_1", column_secondLevel = "nivel_adm_2",targetVar =  "num_mortalidad_grupo_1", timeVar = "date_ocur", groupVar = "lugar_ocur")
  plotLineCauseServer(id = "causaDiretaIndiretaLinePlot", db_selected_country = db_selected_country, column_firstLevel = "nivel_adm_1", column_secondLevel = "nivel_adm_2",targetVar =  "num_mortalidad_grupo_1", timeVar = "date_ocur", groupVar = "persona_certifico")
  horizontalBarPlotServer(id = "causaEspecifica", db_selected_country = db_selected_country, column_firstLevel = "nivel_adm_1", column_secondLevel = "nivel_adm_2",targetVar =  "num_mortalidad_grupo_1", timeVar = "date_ocur", groupVar = "persona_certifico")
  
}



