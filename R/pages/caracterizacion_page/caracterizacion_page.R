source("R/pages/caracterizacion_page/caracterizacion_header.R")
source("R/pages/caracterizacion_page/caracterizacion_seleccionar_pais.R")
source("R/pages/caracterizacion_page/indicators/firstPlot.R")
source("R/pages/caracterizacion_page/indicators/anualBarPlot.R")
source("R/pages/caracterizacion_page/indicators/edadBarPlot.R")
source("R/pages/caracterizacion_page/indicators/lugarOcurBarPlot.R")
source("R/pages/caracterizacion_page/indicators/causaDirectaIndirecta.R")
source("R/pages/caracterizacion_page/indicators/causaEspecificaBar.R")


caracterizacion_page <- argonTabItem(
  tabName = "caracterizacion",
  
  caracterizacion_header,
  caracterizacionSeleccionarPaisUI("seleccionPais", db_list_countries),
  plot_line3LevelsUI("plot_A34_O00_O99"),
  barChartUI("barChartModule"),
  edadBarPlotUI("edadBarPlot"),
  BarPlotUI("lugarOcurBarPlot"),
  plotLineCauseUI("causaDiretaIndiretaLinePlot"),
  horizontalBarPlotUI("causaEspecifica")
)



