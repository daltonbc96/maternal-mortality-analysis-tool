validarInputs <- function(pais, indicadores) {
  mensagemErro <- c()
  if (pais == "") {
    mensagemErro <- c(mensagemErro, "• Un país")
  }
  if (is.null(indicadores) || length(indicadores) == 0) {
    mensagemErro <- c(mensagemErro, "• Al menos un indicador")
  }
  return(mensagemErro)
}


# Função genérica para validação, atualização e renderização de mensagens de erro
validateAndUpdateMessage <- function(input, output, inputPais, inputIndicadores, erroReactive, botaoID, outputID) {
  observe({
    mensagemErro <- validarInputs(input[[inputPais]], getSelectedNames(input[[inputIndicadores]]))
    
    if (length(mensagemErro) > 0) {
      erroReactive(paste("Es necesario seleccionar:<br>", paste(mensagemErro, collapse = "<br>")))
      shinyjs::disable(botaoID)
    } else {
      erroReactive(NULL)
      shinyjs::enable(botaoID)
    }
  })
  
  output[[outputID]] <- renderUI({
    if (!is.null(erroReactive()) && length(erroReactive()) > 0) {
      div(style = "color: grey; font-size: 10px;", HTML(erroReactive()))
    }
  })
}



#      error_message <- reactiveVal()
#    
#     observe({
#   mensagemErro11 <- validarInputs(input$pais11, getSelectedNames(input$indicadores_tree_caracterizacion_1))
#   
#   if (length(mensagemErro11) > 0) {
#     error_message(paste("Es necesario seleccionar:<br>", paste(mensagemErro11, collapse = "<br>")))
#     shinyjs::disable("btnGerar11")
#   } else {
#     error_message(NULL)  
#     shinyjs::enable("btnGerar11")
#   }
# })
# 
#     
#     
#     output$error_message_display <- renderUI({
#       if (!is.null(error_message()) && length(error_message()) > 0) {
#         div(style = "color: grey; font-size: 10px;", HTML(error_message()))
#       }
#     })
#     
#     error_message22 <- reactiveVal()
#     
#     observe({
#       mensagemErro2 <- validarInputs(input$pais22, getSelectedNames(input$indicadores_tree_caracterizacion_2))
#       
#       if (length(mensagemErro2) > 0) {
#         error_message22(paste("Es necesario seleccionar:<br>", paste(mensagemErro2, collapse = "<br>")))
#         shinyjs::disable("btnGerar22")
#       } else {
#         error_message22(NULL)
#         shinyjs::enable("btnGerar22")
#       }
#     })
#     
#     
#     output$error_message_display2 <- renderUI({
#       if (!is.null(error_message22()) && length(error_message22()) > 0) {
#         div(style = "color: grey; font-size: 10px;", HTML(error_message22()))
#       }
#     })


