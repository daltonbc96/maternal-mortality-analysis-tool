

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
        actionButton("reset11", "Reset", class = "btn btn-info float-right", type = 2),
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
              label = "Nivel Administrativo 1:",
              choices = NULL,
              selected = NULL
            )
          ),
          argonColumn(
            width = 6,
            selectInput(
              inputId = "municipio11",
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
            dateInput(inputId = "fecha_inicio11",
                      label = "Fecha de Inicio:")
          ),
          argonColumn(
            width = 6,
            dateInput(inputId = "fecha_final11",
                      label = "Fecha Final:")
          )
        ),
        
        
        
        
        
        argonRow(
          argonColumn(
            width = 6,
            dropdownButton(
            inputId = "dropdown_tree",
            label = "Indicadores",
            icon = icon("sliders"),
            status = "white",
            circle = FALSE,
            shinyTree("indicadores_tree_caracterizacion_1", checkbox = TRUE)
          )),
          argonColumn(
            width = 6,
            actionButton("btnGerar11", "Analizar ", class = "btn btn-info", type = 2),
            uiOutput("error_message_display")
            
          )
        )
        
        
        
      )
    
    
    ),
    
    argonColumn(
      width = 6,
      argonCard(
        width = 12,
        border_level = 10,
        shadow = T,
        background_color = 'secondary',
        actionButton("reset22", "Reset", class = "btn btn-info float-right", type = 2),
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
              label = "Nivel Administrativo 1:",
              choices = NULL,
              selected = NULL
            )
          ),
          argonColumn(
            width = 6,
            selectInput(
              inputId = "municipio22",
              label = "Nivel Administrativo 2:",
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
        
        argonRow(
          argonColumn(
            width = 6,
            dropdownButton(
              inputId = "dropdown_tree",
              label = "Indicadores",
              icon = icon("sliders"),
              status = "white",
              circle = FALSE,
              shinyTree("indicadores_tree_caracterizacion_2", checkbox = TRUE)
            )),
          argonColumn(
            width = 6,
            actionButton("btnGerar22", "Analizar ", class = "btn btn-info", type = 2),
            uiOutput("error_message_display2")
          )
        )
      )
    )
  ),
  argonRow(
  argonColumn(
    width = 6,
    uiOutput("plotOutput1")
    ),
  
  argonColumn(
    width = 6,
    uiOutput("plotOutput2")
    )
  ),
  
  
  
  argonRow(
    argonColumn(
      width = 6,
      uiOutput("plotOutput5")
    ),
    
    argonColumn(
      width = 6,
      uiOutput("plotOutput6")
    )
  ),

  
  argonRow(
    argonColumn(
      width = 6,
      uiOutput("plotOutput3")
    ),
    
    argonColumn(
      width = 6,
      uiOutput("plotOutput4")
    )
  ),
  
  argonRow(
    argonColumn(
      width = 6,
      uiOutput("plotOutput7")
    ),
    
    argonColumn(
      width = 6,
      uiOutput("plotOutput8")
    )
  )
  # ,
  # 
  # argonRow(argonColumn(
  #   width = 12,
  #   argonCard(
  #     width = 12,
  #     border_level = 10,
  #     shadow = T,
  #     background_color = 'secondary',
  #     title = h2("Otros gráficos", style = 'color:#009cda;'),
  #     h4("En desarrollo")
  #     
  #     
  #   )
  # )
  #)
  
  
)
