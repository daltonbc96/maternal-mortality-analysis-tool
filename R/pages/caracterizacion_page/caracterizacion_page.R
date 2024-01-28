source("R/pages/caracterizacion_page/caracterizacion_header.R")
source("R/pages/caracterizacion_page/caracterizacion_seleccionar_pais.R")
source("R/pages/caracterizacion_page/indicators/linePlot3Levels.R")
source("R/pages/caracterizacion_page/indicators/barAnualPrimeiroPlot.R")
source("R/pages/caracterizacion_page/indicators/edadBarPlot.R")
source("R/pages/caracterizacion_page/indicators/groupSocioBarPlot.R")
source("R/pages/caracterizacion_page/indicators/groupLinePlot.R")
source("R/pages/caracterizacion_page/indicators/horizontalBarPlot.R")


caracterizacion_page <- argonTabItem(
  tabName = "caracterizacion",
  
  caracterizacion_header,
  
  caracterizacionSeleccionarPaisUI("seleccionPais", db_list_countries),
   linePlot3LevelsUI("plot_A34_O00_O99_line", title_block = "Número de Muertes Maternas (A34, O00-O99)"),
   linePlot3LevelsUI("plot_ODS_line", title_block = "Número de Muertes Maternas (ODS 3.1.1 A34, O00-O95, O98-O99)"),
   barAnualPrimeiroPlotUI("plot_A34_O00_O99_bar", title_block = "Número de Muertes Maternas (A34, O00-O99) en Relación a Cada Ubicación de Primer Nivel"),
   barAnualPrimeiroPlotUI("plot_ODS_bar", title_block = "Número de Muertes Maternas (ODS 3.1.1 A34, O00-O95, O98-O99) en Relación a Cada Ubicación de Primer Nivel"),
  
   edadBarPlotUI("edadBarPlot1", title_block = "Número de Muertes Maternas (ODS 3.1.1 A34, O00-O95, O98-O99) por Grupo de Edade 1"),
   edadBarPlotUI("edadBarPlot2", title_block = "Número de Muertes Maternas (ODS 3.1.1 A34, O00-O95, O98-O99) por Grupo de Edade 2"),
  
   groupSocioBarPlotUI("lugarOcurBarPlot", title_block = "Número de Muertes Maternas (ODS 3.1.1 A34, O00-O95, O98-O99) por Lugar De Ocurrencia De La Defunción" ),
   groupSocioBarPlotUI("recebioAtencionBarPlot", title_block = "Número de Muertes Maternas (ODS 3.1.1 A34, O00-O95, O98-O99) por Recibió Atención Medica Antes De Morir" ),
  
   groupSocioBarPlotUI("razaBarPlot", title_block = "Número de Muertes Maternas (ODS 3.1.1 A34, O00-O95, O98-O99) por Grupo Étnico/Raza" ),
   groupSocioBarPlotUI("derechohabienciaBarPlot", title_block = "Número de Muertes Maternas (ODS 3.1.1 A34, O00-O95, O98-O99) por Aseguramiento/Derechohabiencia" ),
  
   groupSocioBarPlotUI("ocupacionBarPlot", title_block = "Número de Muertes Maternas (ODS 3.1.1 A34, O00-O95, O98-O99) por Ocupación" ),
   groupSocioBarPlotUI("estadoCivilBarPlot", title_block = "Número de Muertes Maternas (ODS 3.1.1 A34, O00-O95, O98-O99) por Estado Civil" ),
  
   groupSocioBarPlotUI("personaBarPlot", title_block = "Número de Muertes Maternas (ODS 3.1.1 A34, O00-O95, O98-O99) por Personal Que Certifico La Defunción" ),
  
   groupLinePlotUI("causaDiretaIndiretaLinePlot", title_block = "Número de Muertes Maternas (ODS 3.1.1 A34, O00-O95, O98-O99) por Causas Directas y Indirectas"),
   horizontalBarPlotUI("causaEspecifica", title_block = "Mortalidade Materna por Causa Específica"),

   groupLinePlotUI("causaEspecificaLinePlot", title_block = "Mortalidade Materna por Causa Específica")

)



