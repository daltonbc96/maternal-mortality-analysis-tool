horizontalArgonSidebar <- argonDashSidebar(
  vertical = F,
  skin = "light",
  background = "secondary",
  size = "md",
  side = "right",
  id = "my_sidebar",
  brand_url = "https://www.paho.org/es",
  brand_logo = "images/ops_logo.png",
  argonSidebarMenu(
    style = "display:-webkit-inline-box;",
    argonSidebarItem(tabName = "inicio",
                     "Inicio",),
    argonSidebarItem(tabName = "razon_mm",
                     "Rázon de MM"),
    argonSidebarItem(tabName = "caracterizacion",
                     "Caracterización de MM"),
    argonSidebarItem(tabName = "exceso_mm",
                     "Exceso de MM"),
    argonSidebarItem(tabName = "mujeres_edad_fertil",
                     "Mujeres en Edad Fértil")
  )
)