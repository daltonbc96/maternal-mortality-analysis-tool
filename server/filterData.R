filterData <- function(lista_paises, paisInput, deptoInput, muniInput, fechaInicioInput, fechaFinalInput) {
  if (paisInput != "") {
    dados <- lista_paises[[paisInput]]
    if (deptoInput != "") {
      dados <- subset(dados, departamento == deptoInput)
    }
    if (muniInput != "") {
      dados <- subset(dados, municipio == muniInput)
    }
    dados <- subset(dados, fecha_def >= fechaInicioInput & fecha_def <= fechaFinalInput)
    return(dados)
  } else {
    return(NULL)
  }
}
