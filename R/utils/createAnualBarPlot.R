library(ggplot2)
library(dplyr)

createAnualBarPlot <- function(years, nationalData, firstLevelData, localityNames = NULL,
                               x_axis_label = "Locality", y_axis_label = "Total Cases", 
                               plot_title = "Annual COVID-19 Cases by Locality", legend_names = NULL) {
  # Check if both vectors are NULL or empty
  if ((is.null(nationalData) || length(nationalData) == 0) && 
      (is.null(firstLevelData) || length(firstLevelData) == 0)) {
    cat("No data available.")
    return(NULL)
  }
  
  # Create data frames for national and first-level data
  if (!is.null(nationalData) && length(nationalData) > 0) {
    national_df <- data.frame(Locality = "National", Year = years, Cases = rep(nationalData, each = length(years)))
  }
  
  if (!is.null(firstLevelData) && length(firstLevelData) > 0) {
    first_level_df <- data.frame(Locality = rep(localityNames, times = length(years)), Year = rep(years, each = length(localityNames)), Cases = rep(firstLevelData, each = length(years)))
  }
  
  # Combine data frames (if both national and first-level data are available)
  if (!is.null(nationalData) && length(nationalData) > 0 && 
      !is.null(firstLevelData) && length(firstLevelData) > 0) {
    df <- rbind(national_df, first_level_df)
  } else if (!is.null(nationalData) && length(nationalData) > 0) {
    df <- national_df
  } else {
    df <- first_level_df
  }
  
  # Calculate the yearly sum of cases for each locality
  df_summary <- df %>%
    group_by(Locality, Year) %>%
    summarize(TotalCases = sum(Cases))
  
  # Use a palette of blue shades
  blue_palette <- colorRampPalette(c("#0072B2", "#00A6E3", "#00B2EB",  "#00C1F9"))
  
  # Create the side-by-side bar chart with blue shades
  p <- ggplot(df_summary, aes(x = Locality, y = TotalCases, fill = factor(Year))) +
    geom_bar(stat = "identity", position = "dodge") +
    labs(title = plot_title,
         x = x_axis_label,
         y = y_axis_label,
         fill = "Year") +
    theme_minimal() +
    scale_fill_manual(values = blue_palette(length(unique(df_summary$Year))), name = "Year") +
    theme(legend.position = "top")
  
  return(p)
}

# # Example usage of the function with sample data
# years <- c(2022, 2023, 2024)
# nationalData <- c(500, 600, 700)
# firstLevelData <- c(100, 120, 150)
# localityNames <- c("Locality A", "Locality B", "Locality C")
# 
# # Generate random legend names
# legend_names <- c("2022", "2023", "2024")
# 
# # Calling the function with custom parameters
# createAnualBarPlot(years, nationalData, firstLevelData, localityNames,
#                x_axis_label = "Locality Name", y_axis_label = "Total Cases",
#                plot_title = "COVID-19 Cases by Locality",
#                legend_names = legend_names)
