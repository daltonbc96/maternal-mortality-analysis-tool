

source("server/simulatedData.R")

#lista_paises <<- simulated_data()

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
  
  

