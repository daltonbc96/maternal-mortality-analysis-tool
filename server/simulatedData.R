simulated_data <- function(){
  data1 <- data.frame(
    fecha_def = seq(as.Date("2015-01-01"), as.Date("2022-12-31"), by="1 month"),
    deaths = sample(100:200, 96, replace = TRUE), 
    municipio = sample(c("AAAA", "BBBB", "CCCCC"), 96, replace = TRUE),
    departamento = sample(c("A", "B", "C"), 96, replace = TRUE),
    pais = "Brasil"
  )
  data2 <- data.frame(
    fecha_def = seq(as.Date("2015-01-01"), as.Date("2022-12-31"), by="1 month"),
    edad = sample(c("10-19", "20-29", "30-39", "40-49", "50-54"), 96, replace = TRUE),
    municipio = sample(c("DDDD", "EEEE", "FFFF"), 96, replace = TRUE),
    deaths = sample(100:200, 96, replace = TRUE), 
    departamento = sample(c("D", "E", "F"), 96, replace = TRUE),
    pais = "Paraguay"
  )
  
  data3 <- data.frame(
    fecha_def = seq(as.Date("2015-01-01"), as.Date("2022-12-31"), by="1 month"),
    deaths = sample(100:200, 96, replace = TRUE),  
    edad = sample(c("10-19", "20-29", "30-39", "40-49", "50-54"), 96, replace = TRUE),
    municipio = sample(c("GGGG", "HHHH", "IIII"), 96, replace = TRUE),
    departamento = sample(c("G", "H", "I"), 96, replace = TRUE),
    pais = "Colombia"
  )
  
  lista_paises  <- list(
    Brasil = data1,
    Paraguay = data2,    
    Colombia = data3           
    
  )
  return(lista_paises)

}

