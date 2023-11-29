initial_page <-
  argonTabItem(
    tabName = "inicio",
    argonDashHeader(
      color = 'info',
      separator = TRUE,
      argonRow(argonColumn(
        width = 12,
        h1("Mortalidad Materna", style = 'color:white;'),
        h3("Análisis epidemiológico y estadístico", style = 'color:white;'),
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
          "Esta herramienta ha sido desarrollada en respuesta a los desafíos enfrentados en el campo de la salud materna, y tiene como objetivo abordar una cuestión crítica identificada a nivel global y en la Región de las Américas. Ante la alarmante tasa de mortalidad materna, que se mantuvo en 68 por cada 100.000 nacimientos entre 2000 y 2020, y el agravamiento de esta situación debido a la pandemia de COVID-19, se ha vuelto imperativa la necesidad de un enfoque analítico robusto. Esta herramienta fue creada para integrar y sistematizar datos sobre defunciones maternas, facilitando el análisis y el soporte en la toma de decisiones, contribuyendo significativamente al cumplimiento del Objetivo de Desarrollo Sostenible 3 y a la mejora continua de la salud materna."
        )
        
        
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
        title = h2("Notas Técnicas", style = 'color:#009cda;'),
        h4(
          "Bajo la dirección técnica de los Dres. Patricia Soliz, Antonio Sanhueza, Thiago Rocha y Bremen de Mucio, esta herramienta es el resultado del esfuerzo colaborativo entre expertos de la OPS, Ministerios de Salud, Institutos de Estadística y académicos. Desarrollada por Dalton Breno Costa, la herramienta ofrece una interfaz dinámica para la integración de bases de datos sobre mortalidad materna, permitiendo análisis estandarizados y exhaustivos. Este enfoque innovador facilita la identificación de tendencias, patrones y áreas críticas, empoderando a los tomadores de decisiones con información precisa y actualizada para estrategias efectivas en salud materna."        )
      
      )
    ))
  )
