library(shiny)
library(argonR)
library(argonDash)
library(plotly)


source("sideBar/horizontalArgonSidebar.R")
source("pages/initial_page.R")
source("pages/razon_mm_page.R")
source("pages/caracterizacion_page.R")
source("pages/exceso_mm_page.R")
source("pages/mujeres_edad_fertil_page.R")
source("footer/argonFooter.R")
source("server/setting_server.R")



ui <- fluidPage(
  tags$head(tags$style(
    HTML("
      #my_sidebar .navbar-brand img {
        width: 200px;
        height: auto;
      }")
  )),
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
