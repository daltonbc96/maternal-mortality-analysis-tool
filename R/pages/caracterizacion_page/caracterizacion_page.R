source("R/pages/caracterizacion_page/caracterizacion_header.R")
source("R/pages/caracterizacion_page/caracterizacion_seleccionar_pais.R")
source("R/pages/caracterizacion_page/indicators/teste_indicators.R")
source("R/pages/caracterizacion_page/indicators/firstPlot.R")

caracterizacion_page <- argonTabItem(
  tabName = "caracterizacion",
  
  caracterizacion_header,
  caracterizacionSeleccionarPaisUI("seleccionPais", db_list_countries),
  plot_line3LevelsUI("plot_A34_O00_O99")
)



