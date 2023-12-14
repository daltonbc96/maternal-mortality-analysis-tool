source("global.R")

library(shiny)
library(argonR)
library(argonDash)
library(plotly)
library(shinyTree)
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




source("sideBar/horizontalArgonSidebar.R")
source("pages/initial_page.R")
source("pages/razon_mm_page.R")
source("pages/caracterizacion_page.R")
source("pages/exceso_mm_page.R")
source("pages/mujeres_edad_fertil_page.R")
source("footer/argonFooter.R")
source("server/setting_server.R")



ui <- fluidPage(
 
  useShinyjs(),
  #use_busy_modal(size = 80, color = "#0000FF"),

  tags$link(rel = "stylesheet", type = "text/css", href = "css/style.css"),
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
