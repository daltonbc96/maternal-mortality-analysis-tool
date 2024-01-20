initial_page <-
  argonTabItem(
    tabName = "inicio",
    argonDashHeader(
      color = 'info',
      separator = TRUE,
      argonRow(argonColumn(
        width = 12,
        h1(HTML("Análisis epidemiológico y estadístico <br> de la Mortalidad Materna"), style = 'color:white;'),
        
       # h3("Análisis epidemiológico y estadístico", style = 'color:white;'),
        br(),
        br(),
        br()
        
      ))
    ),
    argonRow(argonColumn(
      width = 12,
      argonCard(
        width = 12,
        border_level = 10,
        shadow = T,
        background_color = 'secondary',
        title = h2("Presentación", style = 'color:#009cda;'),
        h4(
          HTML( "La herramienta en línea  <strong> Análisis Epidemiológico y Estadístico de Mortalidad Materna </strong>  de OPS/OMS realiza un análisis 
          completo y sistemático de la información de muertes maternas. La herramienta tabula automáticamente los datos y 
          presenta indicadores básicos en tablas y figuras. La información empleada proviene de las bases de datos de estadística  
          vital nacional del Ministerio de Salud o Instituto Nacional de Estadistica dependiendo del país y representa el dato 
          observado sin ninguna correción. El nivel de calidad de la informacion es de diferente entre paises debido a la 
          diferencia en la completitud y mala clasificacion de las muertes maternas.
          <br>
          <br>
          El principal propósito de generar esta herramienta es contribuir a la toma de decisiones efectiva para el 
          cumplimiento del <strong> Objetivo de Desarrollo Sostenible 3 (ODS-3)</strong>, disminución de la razón de mortalidad materna 
          con un enfoque de equidad y mejoramiento de la salud maternal.
"
        ))
        
        
      )
    )),
    argonRow(argonColumn(
      width = 12,
      argonCard(
        width = 12,
        border_level = 10,
        shadow = T,
        background_color = 'secondary',
        status = "primary",
        title = h2("Citación", style = 'color:#009cda;'),
        h4(
          "Análisis de mortalidad materna, OPS/OMS, 2023"        )
      
      )
    ))
  )
