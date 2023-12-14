

source("server/simulatedData.R")

#lista_paises <<- simulated_data()
razon_mm_page <- argonTabItem(
  tabName = "razon_mm",
  
  argonRow(argonColumn(
    width = 12,
    argonCard(
      width = 12,
      border_level = 10,
      shadow = T,
      background_color = 'secondary',
      title = h2("Razón de Mortalidad Materna", style = 'color:#009cda;'),
      h4(
        "Esta página ofrece un análisis detallado de la mortalidad materna, proporcionando datos cruciales para la comprensión y lucha contra este desafío de salud pública. Presenta estadísticas nacionales y por primer nivel administrativo, incluyendo departamentos y municipios de las razones de muertes maternas. Adicionalmente, ofrece una segmentación de la Razón de Mortalidad Materna (RMM) por grupos etarios específicos, incluyendo rangos de 10 a 54 años. Una sección vital de la página está dedicada al análisis de la RMM por causas, dividida en tres grupos principales: causas relacionadas con los objetivos del Desarrollo Sostenible 3.1.1 A34, O00-O95, O98-O99, incluyendo mortalidad tardía y secuelas (O96-O97); causas obstétricas directas e indirectas (A34, O00-O99); y detalle de causas específicas como aborto, complicaciones del embarazo, sepsis y otras infecciones puerperales, entre otras. Este enfoque comprensivo permite un análisis profundo y específico, esencial para estrategias efectivas en salud materna."
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
            inputId = 'pais1',
            label = "País:",
            choices = c("", names(lista_paises)),
            selected = NULL
            
          )
        )),
        argonRow(
          argonColumn(
            width = 6,
            selectInput(
              inputId = "departamento1",
              label = "Nivel Administrativo 1:",
              choices = NULL,
              selected = NULL
            )
          ),
          argonColumn(
            width = 6,
            selectInput(
              inputId = "municipio1",
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
            dateInput(inputId = "fecha_inicio1",
                      label = "Fecha de Inicio:")
          ),
          argonColumn(
            width = 6,
            dateInput(inputId = "fecha_final1",
                      label = "Fecha Final:")
          )
        ),
        actionButton("btn", "Analizar ", class = "btn btn-info",  type = 2)
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
            inputId = 'pais2',
            label = "País:",
            choices = c("", names(lista_paises)),
            selected = NULL
            
          )
        )),
        
        argonRow(
          argonColumn(
            width = 6,
            selectInput(
              inputId = "departamento2",
              label = "Nivel Administrativo 1:",
              choices = NULL,
              selected = NULL
            )
          ),
          argonColumn(
            width = 6,
            selectInput(
              inputId = "municipio2",
              label = "Nivel Administrativo 2:",
              choices = NULL,
              selected = NULL
            )
          )
        ),
        
        argonRow(
          argonColumn(
            width = 6,
            dateInput(inputId = "fecha_inicio2",
                      label = "Fecha de Inicio:")
          ),
          argonColumn(
            width = 6,
            dateInput(inputId = "fecha_final2",
                      label = "Fecha Final:")
          )
        ),
        
        
        actionButton("btn", "Analizar", class = "btn btn-info")
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
