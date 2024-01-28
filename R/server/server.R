library(shiny)


server <- function(input, output, session) {
  
  #caracterizacion page
  
  

  db_selected_country <- caracterizacionSeleccionarPaisServer("seleccionPais", db_list_countries)
  

  linePlot3LevelsServer("plot_A34_O00_O99_line", db_selected_country, "nivel_adm_1", "nivel_adm_2", "num_mortalidad_grupo_1", "date_ocur", title_personal = "Número de Muertes Maternas (A34, O00-O99)" )
  linePlot3LevelsServer("plot_ODS_line", db_selected_country, "nivel_adm_1", "nivel_adm_2", "num_mortalidad_grupo_2", "date_ocur", title_personal = "Número de Muertes Maternas (ODS 3.1.1 A34, O00-O95, O98-O99)" )
  barAnualPrimeiroServer("plot_A34_O00_O99_bar", db_selected_country, "nivel_adm_1", "num_mortalidad_grupo_1", "date_ocur", title_personal = "Número de Muertes Maternas (A34, O00-O99)")
  barAnualPrimeiroServer("plot_ODS_bar", db_selected_country, "nivel_adm_1", "num_mortalidad_grupo_2", "date_ocur", title_personal = "Número de Muertes Maternas (ODS 3.1.1 A34, O00-O95, O98-O99)")
  edadBarPlotServer(id = "edadBarPlot1", db_selected_country = db_selected_country, column_firstLevel = "nivel_adm_1", column_secondLevel = "nivel_adm_2",targetVar =  "num_mortalidad_grupo_1", timeVar = "date_ocur", groupVar = "grupo_edad_1", title_personal = "Número de Muertes Maternas (ODS 3.1.1 A34, O00-O95, O98-O99) por Grupo de Edade 1")
  edadBarPlotServer(id = "edadBarPlot2", db_selected_country = db_selected_country, column_firstLevel = "nivel_adm_1", column_secondLevel = "nivel_adm_2",targetVar =  "num_mortalidad_grupo_1", timeVar = "date_ocur", groupVar = "grupo_edad_2", title_personal = "Número de Muertes Maternas (ODS 3.1.1 A34, O00-O95, O98-O99) por Grupo de Edade 2")
  groupSocioBarPlotServer(id = "lugarOcurBarPlot", db_selected_country = db_selected_country, column_firstLevel = "nivel_adm_1", column_secondLevel = "nivel_adm_2",targetVar =  "num_mortalidad_grupo_1", timeVar = "date_ocur", groupVar = "lugar_ocur", xAxisLabel = "Lugares", title_personal = "Número de Muertes Maternas (ODS 3.1.1 A34, O00-O95, O98-O99) por Lugar De Ocurrencia De La Defunción")
  
  groupSocioBarPlotServer(id = "recebioAtencionBarPlot", db_selected_country = db_selected_country, column_firstLevel = "nivel_adm_1", column_secondLevel = "nivel_adm_2",targetVar =  "num_mortalidad_grupo_1", timeVar = "date_ocur", groupVar = "recebio_atencion", xAxisLabel = "", title_personal = "Número de Muertes Maternas (ODS 3.1.1 A34, O00-O95, O98-O99) por Recibió Atención Medica Antes De Morir")
  groupSocioBarPlotServer(id = "razaBarPlot", db_selected_country = db_selected_country, column_firstLevel = "nivel_adm_1", column_secondLevel = "nivel_adm_2",targetVar =  "num_mortalidad_grupo_1", timeVar = "date_ocur", groupVar = "raza", xAxisLabel = "", title_personal = "Número de Muertes Maternas (ODS 3.1.1 A34, O00-O95, O98-O99) por Número de Muertes Maternas (ODS 3.1.1 A34, O00-O95, O98-O99) por Grupo Étnico/Raza")
  groupSocioBarPlotServer(id = "derechohabienciaBarPlot", db_selected_country = db_selected_country, column_firstLevel = "nivel_adm_1", column_secondLevel = "nivel_adm_2",targetVar =  "num_mortalidad_grupo_1", timeVar = "date_ocur", groupVar = "derechohab", xAxisLabel = "", title_personal = "Número de Muertes Maternas (ODS 3.1.1 A34, O00-O95, O98-O99) por Aseguramiento/Derechohabiencia")
  groupSocioBarPlotServer(id = "ocupacionBarPlot", db_selected_country = db_selected_country, column_firstLevel = "nivel_adm_1", column_secondLevel = "nivel_adm_2",targetVar =  "num_mortalidad_grupo_1", timeVar = "date_ocur", groupVar = "ocupacion", xAxisLabel = "", title_personal = "Número de Muertes Maternas (ODS 3.1.1 A34, O00-O95, O98-O99) por Ocupación")
  
  groupSocioBarPlotServer(id = "estadoCivilBarPlot", db_selected_country = db_selected_country, column_firstLevel = "nivel_adm_1", column_secondLevel = "nivel_adm_2",targetVar =  "num_mortalidad_grupo_1", timeVar = "date_ocur", groupVar = "estado_civil", xAxisLabel = "", title_personal = "Número de Muertes Maternas (ODS 3.1.1 A34, O00-O95, O98-O99) por Estado Civil")
  

  groupSocioBarPlotServer(id = "personaBarPlot", db_selected_country = db_selected_country, column_firstLevel = "nivel_adm_1", column_secondLevel = "nivel_adm_2",targetVar =  "num_mortalidad_grupo_1", timeVar = "date_ocur", groupVar = "persona_certifico", xAxisLabel = "", title_personal = "Número de Muertes Maternas (ODS 3.1.1 A34, O00-O95, O98-O99) por Personal Que Certifico La Defunción")
  
  
  
  
  
  groupLinePlotServer(id = "causaDiretaIndiretaLinePlot", db_selected_country = db_selected_country, column_firstLevel = "nivel_adm_1", column_secondLevel = "nivel_adm_2",targetVar =  "num_mortalidad_grupo_1", timeVar = "date_ocur", groupVar = "persona_certifico", title_personal = "Número de Muertes Maternas (ODS 3.1.1 A34, O00-O95, O98-O99) por Causas Directas y Indirectas")
  horizontalBarPlotServer(id = "causaEspecifica", db_selected_country = db_selected_country, column_firstLevel = "nivel_adm_1", column_secondLevel = "nivel_adm_2",targetVar =  "num_mortalidad_grupo_1", timeVar = "date_ocur", groupVar = "persona_certifico", title_personal = "Mortalidade Materna (ODS 3.1.1 A34, O00-O95, O98-O99) por Causa Específica", yAxisLabel = "Número de Casos")
  groupLinePlotServer(id = "causaEspecificaLinePlot", db_selected_country = db_selected_country, column_firstLevel = "nivel_adm_1", column_secondLevel = "nivel_adm_2",targetVar =  "num_mortalidad_grupo_1", timeVar = "date_ocur", groupVar = "persona_certifico", title_personal = "Mortalidade Materna (ODS 3.1.1 A34, O00-O95, O98-O99) por Causa Específica")
  
}



