

source("server/simulatedData.R")

lista_paises <<- simulated_data()

exceso_mm_page <- argonTabItem(
  tabName = "exceso_mm",
  
  argonRow(argonColumn(
    width = 12,
    argonCard(
      width = 12,
      border_level = 10,
      shadow = T,
      background_color = 'secondary',
      title = h2("Exceso de Mortalidad Materna", style = 'color:#009cda;'),
      h4(
        "Esta página ofrece una visión crítica y detallada sobre la mortalidad materna, enfocándose en el aumento significativo de casos en períodos específicos. Esta sección presenta datos sobre las muertes maternas por semana y mes, cubriendo al menos tres años antes de 2020, lo que permite una valiosa comparación temporal. Además, la página destaca el número de muertes maternas en exceso anualmente, tanto a nivel nacional como por primer nivel administrativo. También se proporciona el porcentaje de exceso de muertes maternas anual, una métrica crucial para entender el impacto de la mortalidad materna a lo largo del tiempo y en diferentes regiones. Por último, se detalla la Razón de Mortalidad Materna en exceso, ofreciendo un panorama más profundo del escenario de salud materna. Este conjunto de información es esencial para identificar patrones, evaluar la eficacia de políticas de salud y dirigir esfuerzos para reducir la mortalidad materna."
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
            inputId = 'pais13',
            label = "País:",
            choices = c("", names(lista_paises)),
            selected = NULL
            
          )
        )),
        argonRow(
          argonColumn(
            width = 6,
            selectInput(
              inputId = "departamento13",
              label = "Nivel Administrativo 1:",
              choices = NULL,
              selected = NULL
            )
          ),
          argonColumn(
            width = 6,
            selectInput(
              inputId = "municipio13",
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
            dateInput(inputId = "fecha_inicio13",
                      label = "Fecha de Inicio:")
          ),
          argonColumn(
            width = 6,
            dateInput(inputId = "fecha_final13",
                      label = "Fecha Final:")
          )
        ),
        actionButton("btn3", "Analizar ", class = "btn btn-info",  type = 2)
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
            inputId = 'pais24',
            label = "País:",
            choices = c("", names(lista_paises)),
            selected = NULL
            
          )
        )),
        
        argonRow(
          argonColumn(
            width = 6,
            selectInput(
              inputId = "departamento24",
              label = "Nivel Administrativo 1:",
              choices = NULL,
              selected = NULL
            )
          ),
          argonColumn(
            width = 6,
            selectInput(
              inputId = "municipio24",
              label = "Nivel Administrativo 2:",
              choices = NULL,
              selected = NULL
            )
          )
        ),
        
        argonRow(
          argonColumn(
            width = 6,
            dateInput(inputId = "fecha_inicio24",
                      label = "Fecha de Inicio:")
          ),
          argonColumn(
            width = 6,
            dateInput(inputId = "fecha_final24",
                      label = "Fecha Final:")
          )
        ),
        
        
        actionButton("btn3", "Analizar", class = "btn btn-info")
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
