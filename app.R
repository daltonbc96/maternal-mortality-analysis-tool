options(shiny.autoload.r = TRUE)

library(shiny)
library(argonR)
library(argonDash)
library(plotly)
library(shinyWidgets)
library(shinyjs)
library(shinycssloaders)
library(shinybusy)
library(dbplyr)
library(tidyr)
library(duckdb)
library(rlang) 
library(dplyr)
library(ggplot2)





source("R/sideBar/horizontalArgonSidebar.R")
source("R/pages/initial_page/initial_page.R")
source("R/pages/razon_mm_page/razon_mm_page.R")
source("R/pages/caracterizacion_page/caracterizacion_page.R")
source("R/pages/excesso_mm_page/exceso_mm_page.R")
source("R/pages/mujeres_edad_fertil_page/mujeres_edad_fertil_page.R")
source("R/footer/argonFooter.R")
source("R/server/server.R")

ui <- fluidPage(
 
  useShinyjs(),
  #use_busy_modal(size = 80, color = "#0000FF"),
  
  tags$style(
    "
    .js-plotly-plot .plotly .modebar-group {
    transform: scale(0.7) !important;
    top: 0px; 
    left: auto;
    right: 80px; }
    
    #my_sidebar .navbar-brand img {
    width: 200px;
    height: auto;
  }
    "
  ),

 # tags$link(rel = "stylesheet", type = "text/css", href = "www/css/style.css"),
  argonDashPage(
    title = "Mortalidad Materna",
    description = 'Testing',
    sidebar = horizontalArgonSidebar,
    body = argonDashBody(
      argonTabItems(
        initial_page,
        razon_mm_page,
        caracterizacion_page,
        exceso_mm_page,
        mujeres_edad_fertil_page
      )
    ),
    footer = argonFooter
    
  )
)



shiny::shinyApp(ui = ui, server = server)
