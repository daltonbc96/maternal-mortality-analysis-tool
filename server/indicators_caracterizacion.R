indicators_caracterizacion <- function() {
  indicadores_tree <- list(
    'Número de Muertes Maternas Total' = structure(list(), stopened = FALSE),
    'Número de Mortalidade Materna' = structure(
      list(
        'A34, O00-O99' = structure(list(), stopened = FALSE),
        'ODS 3.1.1 A34, O00-O95, O98-O99' = structure(list(), stopened = FALSE),
        'Por Causas Obstétricas Directas (A34, O00-O94) Y Obstétricas Indirectas (O98-O99)' = structure(list(), stopened =
                                                                                                          FALSE)
      ),
      stopened = FALSE
    ),
    'Número de Muertes por Causas Específicas' = structure(
      list(
        'Aborto O00-O07' = structure(list(), stopened = FALSE),
        'Enfermedad Hipertensiva Del Embarazo, Edema Y Proteinuria O10-O16' = structure(list(), stopened =
                                                                                          FALSE),
        'Hemorragia Del Embarazo, Parto Y Puerperio O20, O44-O46, O67, O72' = structure(list(), stopened =
                                                                                          FALSE),
        'Sepsis Y Otras Infecciones Puerperales A34, O85-O86' = structure(list(), stopened =
                                                                            FALSE),
        'Otras Complicaciones Principalmente Del Embarazo Y Parto O21, O23-O43, O47-O66, O68-O71, O73-O75' = structure(list(), stopened =
                                                                                                                         FALSE),
        'Otras Complicaciones Principalmente Puerperales O88-O92' = structure(list(), stopened =
                                                                                FALSE),
        'Complicaciones Venosas En El Embarazo, Parto Y Puerperio O22, O87' = structure(list(), stopened =
                                                                                          FALSE),
        'Causas Obstétricas Indirectas Infecciosas O98' = structure(list(), stopened =
                                                                      FALSE),
        'Causas Obstétricas Indirectas No Infeciosas O99' = structure(list(), stopened =
                                                                        FALSE),
        'Muertes Maternas Tardías O96' = structure(list(), stopened = FALSE),
        'Muertes Maternas Por Secuelas O97' = structure(list(), stopened =
                                                          FALSE),
        'Muerte Obstétrica De Causa No Especificada O95' = structure(list(), stopened =
                                                                       FALSE)
      ),
      stopened = FALSE
    ),
    'Número de Muertes por Aspectos Socio-Demográficos y de Atención' = structure(
      list(
        'Grupo De Edad 1 (10-19, 20-24, 25-29,30-39,40-49,50-54)'   = structure(
          list(  ),
          stopened = FALSE
        ),
        'Grupo De Edad 2 (10-19,20-29,30-39, 40-54)' = structure(
          list( ),
          stopened = FALSE
        ),
        'Lugar De Ocurrencia De La Defunción' = structure(list(), stopened =
                                                            FALSE),
        'Recibió Atención Medica Antes De Morir' = structure(list(), stopened =
                                                               FALSE),
        'Grupo Étnico/ Raza' = structure(list(), stopened = FALSE),
        'Aseguramiento/Derechohabiencia' = structure(list(), stopened = FALSE),
        'Ocupación' = structure(list(), stopened = FALSE),
        'Estado Civil' = structure(list(), stopened = FALSE),
        'Personal Que Certifico La Defunción'  = structure(list(), stopened =
                                                             FALSE)
      )
    ),
    'Indicadores Combinados' = structure(
      list(
        'Por Causa Y Por Grupo De Edad' = structure(list(), stopened = FALSE),
        'Por Causa Y Lugar De Defunción' = structure(list(), stopened = FALSE),
        'Por Causa Y Atención Recibida' = structure(list(), stopened = FALSE)
      ),
      stopened = FALSE
    )
  )
  return(indicadores_tree)
}