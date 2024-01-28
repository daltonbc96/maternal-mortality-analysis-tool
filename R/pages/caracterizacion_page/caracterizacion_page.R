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
   linePlot3LevelsUI("plot_A34_O00_O99_line", title_block = "Número de MM (A34, O00-O99)"),
   linePlot3LevelsUI("plot_ODS_line", title_block = "Número de MM (ODS 3.1.1 A34, O00-O95, O98-O99)"),
    barAnualPrimeiroPlotUI("plot_A34_O00_O99_bar", title_block = "Número de MM (A34, O00-O99) por Cada Ubicación de Primer Nivel"),
    barAnualPrimeiroPlotUI("plot_ODS_bar", title_block = "Número de MM (ODS 3.1.1 A34, O00-O95, O98-O99) por Cada Ubicación de Primer Nivel"),
    
    edadBarPlotUI("edadBarPlot1", title_block = "Número de MM por Grupo de Edad 1"),
    edadBarPlotUI("edadBarPlot2", title_block = "Número de MM por Grupo de Edad 2"),
    
    groupSocioBarPlotUI("lugarOcurBarPlot", title_block = "Número de MM por Lugar De Ocurrencia De La Defunción" ),
    groupSocioBarPlotUI("recebioAtencionBarPlot", title_block = "Número de MM por Recibió Atención Medica Antes De Morir" ),
   
    groupSocioBarPlotUI("razaBarPlot", title_block = "Número de MM por Grupo Étnico/Raza" ),
    groupSocioBarPlotUI("derechohabienciaBarPlot", title_block = "Número de MM por Aseguramiento/Derechohabiencia" ),
    
    groupSocioBarPlotUI("ocupacionBarPlot", title_block = "Número de MM por Ocupación" ),
    groupSocioBarPlotUI("estadoCivilBarPlot", title_block = "Número de MM por Estado Civil" ),
    
    groupSocioBarPlotUI("personaBarPlot", title_block = "Número de MM por Personal Que Certifico La Defunción" ),
    
   groupLinePlotUI("causaDiretaIndiretaLinePlot", title_block = "Número de MM por Causas Directas y Indirectas"),
   horizontalBarPlotUI("causaEspecifica", title_block = "Número de MM por Causa Específica"),

   groupLinePlotUI("causaEspecificaLinePlot", title_block = "Número de MM por Causa Especificada a lo Largo del Tiempo")

)



