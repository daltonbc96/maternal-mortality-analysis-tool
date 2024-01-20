
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
      width = 12,
      argonCard(
        width = 12,
        border_level = 10,
        shadow = T,
        background_color = 'secondary',
        h2("Filtro", style = 'color:#009cda; text-align: left;'),
      )
    )
  )
  
  
)
