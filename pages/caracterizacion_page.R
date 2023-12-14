


createGraphRow <- function( graphId1, graphId2, id = NULL) {
  argonRow(  class = "custom-row-height", id = id,
    argonColumn(
      width = 6,
      uiOutput(graphId1)
    ),
    argonColumn(
      width = 6,
      uiOutput(graphId2)
    )
  )
}







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

  createGraphRow(id = "A34, O00-O99", "plotOutput11", "plotOutput12"),
  createGraphRow(id = "ODS 3.1.1 A34, O00-O95, O98-O99", "plotOutput21", "plotOutput22"),
  createGraphRow(id = "Por Causas Obstétricas Directas (A34, O00-O94) Y Obstétricas Indirectas (O98-O99)", "plotOutput31", "plotOutput32"),
  createGraphRow(id = "Aborto O00-O07", "plotOutput41", "plotOutput42"),
  createGraphRow(id = "Enfermedad Hipertensiva Del Embarazo, Edema Y Proteinuria O10-O16", "plotOutput51", "plotOutput52"),
  createGraphRow(id = "Hemorragia Del Embarazo, Parto Y Puerperio O20, O44-O46, O67, O72", "plotOutput61", "plotOutput62"),
  createGraphRow(id = "Sepsis Y Otras Infecciones Puerperales A34, O85-O86", "plotOutput71", "plotOutput72"),
  createGraphRow(id = "Otras Complicaciones Principalmente Del Embarazo Y Parto O21, O23-O43, O47-O66, O68-O71, O73-O75", "plotOutput81", "plotOutput82"),
  createGraphRow(id = "Otras Complicaciones Principalmente Puerperales O88-O92", "plotOutput91", "plotOutput92"),
  createGraphRow(id = "Complicaciones Venosas En El Embarazo, Parto Y Puerperio O22, O87", "plotOutput101", "plotOutput102"),
  createGraphRow(id = "Causas Obstétricas Indirectas Infecciosas O98", "plotOutput111", "plotOutput112"),
  createGraphRow(id = "Causas Obstétricas Indirectas No Infeciosas O99", "plotOutput121", "plotOutput122"),
  createGraphRow(id = "Muertes Maternas Tardías O96", "plotOutput131", "plotOutput132"),
  createGraphRow(id = "Muertes Maternas Por Secuelas O97", "plotOutput141", "plotOutput142"),
  createGraphRow(id = "Muerte Obstétrica De Causa No Especificada O95", "plotOutput151", "plotOutput152"),
  createGraphRow(id = "Grupo De Edad 1 (10-19, 20-24, 25-29,30-39,40-49,50-54)", "plotOutput161", "plotOutput162"),
  createGraphRow(id = "Grupo De Edad 2 (10-19,20-29,30-39, 40-54)", "plotOutput171", "plotOutput172"),
  createGraphRow(id = "Lugar De Ocurrencia De La Defunción", "plotOutput181", "plotOutput182"),
  createGraphRow(id = "Recibió Atención Medica Antes De Morir", "plotOutput191", "plotOutput192"),
  createGraphRow(id = "Grupo Étnico/Raza", "plotOutput291", "plotOutput292"),
  createGraphRow(id = "Aseguramiento/Derechohabiencia", "plotOutput201", "plotOutput202"),
  createGraphRow(id = "Ocupación", "plotOutput211", "plotOutput212"),
  createGraphRow(id = "Estado Civil", "plotOutput221", "plotOutput222"),
  createGraphRow(id = "Personal Que Certifico La Defunción", "plotOutput231", "plotOutput232"),
  createGraphRow(id = "Por Causa Y Año", "plotOutput241", "plotOutput242"),
  createGraphRow(id = "Por Causa Y Por Grupo De Edad 1", "plotOutput251", "plotOutput252"),
  createGraphRow(id = "Por Causa Y Por Grupo De Edad 2", "plotOutput261", "plotOutput262"),
  createGraphRow(id = "Por Causa Y Lugar De Defunción", "plotOutput271", "plotOutput272"),
  createGraphRow(id = "Por Causa Y Atención Recibida", "plotOutput281", "plotOutput282")
  
  
  
  

  
  
  
)



