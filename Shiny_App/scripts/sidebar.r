create_sidebarPanel <- function(nba_data, ns) {
  sidebarPanel(
    # Input for selecting team
    selectInput("team", "Select Team:",
                choices = sort(unique(nba_data$Team))),
    # Input for selecting start year
    selectInput("start_year", "Start Year:",
                choices = seq(min(nba_data$Year), max(nba_data$Year)),
                selected = min(nba_data$Year)),
    # Input for selecting end year
    selectInput("end_year", "End Year:",
                choices = seq(min(nba_data$Year), max(nba_data$Year)),
                selected = max(nba_data$Year))
  )
}