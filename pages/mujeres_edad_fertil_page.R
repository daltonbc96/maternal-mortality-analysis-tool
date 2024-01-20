

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
