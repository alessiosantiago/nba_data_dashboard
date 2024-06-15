create_sidebarPanel_factors <- function(nba_data, ns) {
  sidebarPanel(
    # Dropdown input for selecting statistic
    selectInput("stat_variable", "Select Statistic:",
                choices = c("Field Goals %" = "FG.", "Three-Point Field Goals" = "X3P", "Two-Point Field Goals" = "X2P", "Free Throw %" = "FT.", "Total Rebounds" = "TRB", "Assists" = "AST", "Steals" = "STL", "Blocks" = "BLK", "Turnovers" = "TOV", "Points" = "PTS")),
    # Dropdown input for selecting decade
    selectInput("decade", "Select Decade:",
                choices = c("1980-1990", "1990-2000", "2000-2010", "2010-2020"))
  )
}