

source("server/simulatedData.R")

#lista_paises <<- simulated_data()


mujeres_edad_fertil_page <- argonTabItem(
  tabName = "mujeres_edad_fertil",
  
  argonRow(argonColumn(
    width = 12,
    argonCard(
      width = 12,
      border_level = 10,
      shadow = T,
      background_color = 'secondary',
      title = h2("Muertes de Mujeres en Edad Fértil", style = 'color:#009cda;'),
      h4(
        "La página proporciona información sobre las principales causas de mortalidad entre mujeres en edad fértil. Esta sección detalla estadísticas vitales a nivel nacional y administrativo, ofreciendo un panorama integral de las principales causas de muerte. Se pone un enfoque especial en el número de muertes sospechosas, tanto en términos generales como divididas por grupo etario, ofreciendo valiosos conocimientos sobre patrones y tendencias específicas de mortalidad en esta demografía. Además, la página proporciona un análisis detallado de las muertes sospechosas por causas, permitiendo una comprensión más profunda de las condiciones de salud y riesgos enfrentados por mujeres en edad fértil. Estos datos son esenciales para la planificación de políticas de salud e intervenciones dirigidas a mejorar la salud y el bienestar de las mujeres en esta franja etaria."
      )
    )
  )),
  
  
  argonRow(
    argonColumn(
      width = 6,
      argonCard(
        width = 12,
        border_level = 10,
        shadow = T,
        background_color = 'secondary',
        h2("ESCENARIO 1", style = 'color:#009cda; text-align: center;'),
        h3("Opciones de Configuración", style = 'color:#009cda; text-align: center;'),
        
        
        argonRow(argonColumn(
          width = 12,
          selectInput(
            inputId = 'pais14',
            label = "País:",
            choices = c("", names(lista_paises)),
            selected = NULL
            
          )
        )),
        argonRow(
          argonColumn(
            width = 6,
            selectInput(
              inputId = "departamento14",
              label = "Nivel Administrativo 1:",
              choices = NULL,
              selected = NULL
            )
          ),
          argonColumn(
            width = 6,
            selectInput(
              inputId = "municipio14",
              label = "Nivel Administrativo 2:",
              choices = NULL,
              selected = NULL
            )
          )
        ),
        
        # Linha para fecha inicio e fecha final
        argonRow(
          argonColumn(
            width = 6,
            dateInput(inputId = "fecha_inicio14",
                      label = "Fecha de Inicio:")
          ),
          argonColumn(
            width = 6,
            dateInput(inputId = "fecha_final14",
                      label = "Fecha Final:")
          )
        ),
        actionButton("btn4", "Analizar ", class = "btn btn-info",  type = 2)
      )
    ),
    
    argonColumn(
      width = 6,
      argonCard(
        width = 12,
        border_level = 10,
        shadow = T,
        background_color = 'secondary',
        h2("ESCENARIO 2", style = 'color:#009cda; text-align: center;'),
        h3("Opciones de Configuración", style = 'color:#009cda; text-align: center;'),
        
        
        
        argonRow(argonColumn(
          width = 12,
          selectInput(
            inputId = 'pais25',
            label = "País:",
            choices = c("", names(lista_paises)),
            selected = NULL
            
          )
        )),
        
        argonRow(
          argonColumn(
            width = 6,
            selectInput(
              inputId = "departamento25",
              label = "Nivel Administrativo 1:",
              choices = NULL,
              selected = NULL
            )
          ),
          argonColumn(
            width = 6,
            selectInput(
              inputId = "municipio25",
              label = "Nivel Administrativo 2:",
              choices = NULL,
              selected = NULL
            )
          )
        ),
        
        argonRow(
          argonColumn(
            width = 6,
            dateInput(inputId = "fecha_inicio25",
                      label = "Fecha de Inicio:")
          ),
          argonColumn(
            width = 6,
            dateInput(inputId = "fecha_final25",
                      label = "Fecha Final:")
          )
        ),
        
        
        actionButton("btn5", "Analizar", class = "btn btn-info")
      )
    )
  ),
  
  
  argonRow(argonColumn(
    width = 12,
    argonCard(
      width = 12,
      border_level = 10,
      shadow = T,
      background_color = 'secondary',
      title = h2("Gráficos", style = 'color:#009cda;'),
      h4("En desarrollo")
      
      
    )
  )),
  
  
)
