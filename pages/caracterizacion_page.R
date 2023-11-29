

source("server/simulatedData.R")

lista_paises <<- simulated_data()

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
        "En esta página es posible observar las caracterizaciones de las muertes de manera integral. Incluye información sobre el total y causas específicas de muertes maternas tanto a nivel nacional, departamental y municipal, basadas en la serie disponible de datos anuales y mensuales. La página detalla el número de muertes maternas en diferentes categorías, como causas obstétricas directas e indirectas, además de especificar causas particulares como aborto, enfermedades hipertensivas del embarazo, hemorragias, sepsis y otras complicaciones. También aborda el total de muertes maternas por grupo etario, lugar de ocurrencia de la muerte, si la mujer recibió atención médica antes de morir, grupo étnico/raza, seguro/derecho a la asistencia médica, ocupación y estado civil. Además, incluye datos sobre el profesional que certificó la muerte y análisis específicos de las causas de muerte materna por grupo de edad, lugar de ocurrencia y atención médica recibida. Este rico conjunto de datos es crucial para entender mejor las circunstancias y factores que contribuyen a la mortalidad materna, permitiendo el desarrollo de estrategias más efectivas para combatirla."
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
            inputId = 'pais11',
            label = "País:",
            choices = c("", names(lista_paises)),
            selected = NULL
            
          )
        )),
        argonRow(
          argonColumn(
            width = 6,
            selectInput(
              inputId = "departamento11",
              label = "Departamento:",
              choices = NULL,
              selected = NULL
            )
          ),
          argonColumn(
            width = 6,
            selectInput(
              inputId = "municipio11",
              label = "Municipio:",
              choices = NULL,
              selected = NULL
            )
          )
        ),
        
        # Linha para fecha inicio e fecha final
        argonRow(
          argonColumn(
            width = 6,
            dateInput(inputId = "fecha_inicio11",
                      label = "Fecha de Inicio:")
          ),
          argonColumn(
            width = 6,
            dateInput(inputId = "fecha_final11",
                      label = "Fecha Final:")
          )
        ),
        actionButton("btnGerar11", "Analizar ", class = "btn btn-info",  type = 2)
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
            inputId = 'pais22',
            label = "País:",
            choices = c("", names(lista_paises)),
            selected = NULL
            
          )
        )),
        
        argonRow(
          argonColumn(
            width = 6,
            selectInput(
              inputId = "departamento22",
              label = "Departamento:",
              choices = NULL,
              selected = NULL
            )
          ),
          argonColumn(
            width = 6,
            selectInput(
              inputId = "municipio22",
              label = "Municipio:",
              choices = NULL,
              selected = NULL
            )
          )
        ),
        
        argonRow(
          argonColumn(
            width = 6,
            dateInput(inputId = "fecha_inicio22",
                      label = "Fecha de Inicio:")
          ),
          argonColumn(
            width = 6,
            dateInput(inputId = "fecha_final22",
                      label = "Fecha Final:")
          )
        ),
        
        
        actionButton("btnGerar22", "Analizar", class = "btn btn-info")
      )
    )
  ),
  
  
  argonRow(
    argonColumn(
      width = 6,
      argonCard(
        width = 12,
        border_level = 10,
        shadow = T,
        background_color = '#f6f9fc',
        title = h2("Muertes Maternas", style = 'color:#009cda;'),
        
        
        shinycssloaders::withSpinner(uiOutput("plotlyGraphUI1"))
      )
    ),
    
    argonColumn(
      width = 6,
      argonCard(
        width = 12,
        border_level = 10,
        shadow = T,
        background_color = '#f6f9fc',
        title = h2("Muertes Maternas", style = 'color:#009cda;'),
        shinycssloaders::withSpinner(uiOutput("plotlyGraphUI2"))
      )
    )
    
  ),
  
  argonRow(
    argonColumn(
      width = 6,
      argonCard(
        width = 12,
        border_level = 10,
        shadow = T,
        background_color = '#f6f9fc',
        title = h2("Grupos de Edad", style = 'color:#009cda;'),
        
        
        shinycssloaders::withSpinner(uiOutput("plotlyGraphUI3"))
      )
    ),
    
    argonColumn(
      width = 6,
      argonCard(
        width = 12,
        border_level = 10,
        shadow = T,
        background_color = '#f6f9fc',
        title = h2("Grupos de Edad", style = 'color:#009cda;'),
        shinycssloaders::withSpinner(uiOutput("plotlyGraphUI4"))
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
      title = h2("Otros gráficos", style = 'color:#009cda;'),
      h4("En desarrollo")
      
      
    )
  ))
  
  
)
