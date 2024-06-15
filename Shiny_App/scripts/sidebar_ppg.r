create_sidebarPanel_ppg <- function(nba_data, ns) {
  sidebarPanel(
    selectInput("selected_year_ppg", "Select Year:",
                choices = seq(min(nba_data$Year), max(nba_data$Year)),
                selected = max(nba_data$Year))
  )
}