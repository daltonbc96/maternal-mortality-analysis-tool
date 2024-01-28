library(shiny)


server <- function(input, output, session) {
  
  #caracterizacion page
  
  

  db_selected_country <- caracterizacionSeleccionarPaisServer("seleccionPais", db_list_countries)
  

  linePlot3LevelsServer(id = "plot_A34_O00_O99_line",db_selected_country =  db_selected_country,column_firstLevel =  "nivel_adm_1",column_secondLevel =  "nivel_adm_2",targetVar =  "num_mortalidad_grupo_1",timeVar =  "date_ocur", title_personal = "Número de MM (A34, O00-O99)" )
  linePlot3LevelsServer(id = "plot_ODS_line",db_selected_country =  db_selected_country, column_firstLevel = "nivel_adm_1", column_secondLevel = "nivel_adm_2", targetVar = "num_mortalidad_grupo_2", timeVar = "date_ocur", title_personal = "Número de Muertes MM (ODS 3.1.1 A34, O00-O95, O98-O99)" )
  barAnualPrimeiroServer(id =  "plot_A34_O00_O99_bar",db_selected_country =  db_selected_country, column_firstLevel =  "nivel_adm_1",targetVar =  "num_mortalidad_grupo_1", timeVar = "date_ocur", title_personal = "Número de MM (A34, O00-O99)")
  barAnualPrimeiroServer(id = "plot_ODS_bar", db_selected_country = db_selected_country, column_firstLevel = "nivel_adm_1", targetVar = "num_mortalidad_grupo_2", timeVar = "date_ocur", title_personal = "Número de MM (ODS 3.1.1 A34, O00-O95, O98-O99)")
  
  edadBarPlotServer(id = "edadBarPlot1", db_selected_country = db_selected_country, column_firstLevel = "nivel_adm_1", column_secondLevel = "nivel_adm_2",targetVar =  "maternal_mortality", timeVar = "date_ocur", groupVar = "grupo_edad_1", title_personal = "Número de MM por Grupo de Edade 1")
  edadBarPlotServer(id = "edadBarPlot2", db_selected_country = db_selected_country, column_firstLevel = "nivel_adm_1", column_secondLevel = "nivel_adm_2",targetVar =  "maternal_mortality", timeVar = "date_ocur", groupVar = "grupo_edad_2", title_personal = "Número de MM por Grupo de Edade 2")
 
  groupSocioBarPlotServer(id = "lugarOcurBarPlot", db_selected_country = db_selected_country, column_firstLevel = "nivel_adm_1", column_secondLevel = "nivel_adm_2",targetVar =  "maternal_mortality", timeVar = "date_ocur", groupVar = "lugar_ocur", xAxisLabel = "Periodo", title_personal = "Número de MM por Lugar de Ocurrencia de la Defunción")
  
  groupSocioBarPlotServer(id = "recebioAtencionBarPlot", db_selected_country = db_selected_country, column_firstLevel = "nivel_adm_1", column_secondLevel = "nivel_adm_2",targetVar =  "maternal_mortality", timeVar = "date_ocur", groupVar = "recebio_atencion", xAxisLabel = "Periodo", title_personal = "Número de MM por Recibió Atención Medica Antes de Morir")
  groupSocioBarPlotServer(id = "razaBarPlot", db_selected_country = db_selected_country, column_firstLevel = "nivel_adm_1", column_secondLevel = "nivel_adm_2",targetVar =  "maternal_mortality", timeVar = "date_ocur", groupVar = "raza", xAxisLabel = "Periodo", title_personal = "Número de MM por Grupo Étnico/Raza")
  groupSocioBarPlotServer(id = "derechohabienciaBarPlot", db_selected_country = db_selected_country, column_firstLevel = "nivel_adm_1", column_secondLevel = "nivel_adm_2",targetVar =  "maternal_mortality", timeVar = "date_ocur", groupVar = "derechohab", xAxisLabel = "Periodo", title_personal = "Número de MM por Aseguramiento/Derechohabiencia")
  groupSocioBarPlotServer(id = "ocupacionBarPlot", db_selected_country = db_selected_country, column_firstLevel = "nivel_adm_1", column_secondLevel = "nivel_adm_2",targetVar =  "maternal_mortality", timeVar = "date_ocur", groupVar = "ocupacion", xAxisLabel = "Periodo", title_personal = "Número de MM por Ocupación")
  
  groupSocioBarPlotServer(id = "estadoCivilBarPlot", db_selected_country = db_selected_country, column_firstLevel = "nivel_adm_1", column_secondLevel = "nivel_adm_2",targetVar =  "maternal_mortality", timeVar = "date_ocur", groupVar = "estado_civil", xAxisLabel = "Periodo", title_personal = "Número de MM por Estado Civil")
  

  groupSocioBarPlotServer(id = "personaBarPlot", db_selected_country = db_selected_country, column_firstLevel = "nivel_adm_1", column_secondLevel = "nivel_adm_2",targetVar =  "maternal_mortality", timeVar = "date_ocur", groupVar = "persona_certifico", xAxisLabel = "Periodo",  title_personal = "Número de MM por Personal que Certifico la Defunción")
  
  
  groupLinePlotServer(id = "causaDiretaIndiretaLinePlot", db_selected_country = db_selected_country, column_firstLevel = "nivel_adm_1", column_secondLevel = "nivel_adm_2",targetVar =  "maternal_mortality", timeVar = "date_ocur", groupVar = "num_mortalidad_grupo_3", title_personal = "Número de MM por Causas Directas y Indirectas", xAxisLabel = "Periodo", yAxisLabel = "Número de Casos")
  horizontalBarPlotServer(id = "causaEspecifica", db_selected_country = db_selected_country, column_firstLevel = "nivel_adm_1", column_secondLevel = "nivel_adm_2",targetVar =  "maternal_mortality", timeVar = "date_ocur", groupVar = "causa_especifica", title_personal = "Número de MM por Causa Específica", yAxisLabel = "Número de Casos")
  groupLinePlotServer(id = "causaEspecificaLinePlot", db_selected_country = db_selected_country, column_firstLevel = "nivel_adm_1", column_secondLevel = "nivel_adm_2",targetVar =  "maternal_mortality", timeVar = "date_ocur", groupVar = "causa_especifica", title_personal = "Número de MM por Causa Especificada a lo Largo del Tiempo", xAxisLabel = "Periodo", yAxisLabel = "Número de Casos")
  
}



