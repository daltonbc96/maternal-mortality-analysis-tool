createCustomCard <- function(title, content) {
  argonCard(
    width = 12,
    border_level = 10,
    shadow = TRUE,
    background_color = '#f6f9fc',
    title = h2(title, style = 'color:#009cda;'),
    content
  )
}
createCustomCardDefault <- function(content) {
  return(
    argonColumn(
      width = 6,
      argonCard(
        width = 12,
        border_level = 10,
        shadow = TRUE,
        background_color = '#f6f9fc',
        content
      )
    )
  )
}