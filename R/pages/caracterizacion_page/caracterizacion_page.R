


caracterizacion_page <- argonTabItem(
  tabName = "caracterizacion",
  
  argonRow(argonColumn(
    width = 12,
    argonCard(
      width = 12,
      border_level = 10,
      shadow = T,
      background_color = 'secondary',
      title = h2("Caracterización de las Muertes Maternas", style = 'color:#009cda;'),
      h4(
        "En esta sección se presentan las principales características de las muertes maternas (MM) partiendo del número total, distribución por edad, por grandes causas y causas expecíficas de muerte, así como por niveles geográficos administrativos, primer nivel: entidad federativa, departamento o provincia y segundo nivel: municipio. Dependiendo de la información disponible en cada país tambien se presentan muertes maternas por lugar de ocurrencia de la muerte, si recibio atención antes de morir, condición de aseguramiento, nivel de escolaridad o grupo étnico, entre otras."
      )
      
      
    )
  )),
  
  argonRow(
    argonColumn(
      width = 12,
      argonCard(
        width = 12,
        border_level = 10,
        shadow = T,
        background_color = 'secondary',
        h2("Seleccione un País:", style = 'color:#009cda; text-align: left;'),
        
        selectInput(
          inputId = "pais_caracterizacion",
          label = "",
          choices = NULL,
          selected = NULL
        )
      )
    )
  )
  
  
  
  
)



