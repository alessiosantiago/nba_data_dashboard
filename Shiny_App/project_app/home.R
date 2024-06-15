# Define UI for the front page
home_ui <- function(id) {
  ns <- NS(id)
  fluidPage(
    titlePanel("Welcome to the NBA Data Dashboard"),
    mainPanel(
      h2("Explore NBA Data Insights"),
      p("Dive into the history of NBA team performances with these interactive visualizations. Explore trends, statistics, and correlations that have shaped the league over decades."),
      h3("Tabs Overview:"),
      tags$ul(
        tags$li("Team Rank: Track NBA teams' standings over time by selecting a team and a date range."),
        tags$li("Three-Pointers: Compare three-point shooting statistics across different seasons for selected teams."),
        tags$li("Points Per Game: View the distribution of league-wide points per game over the years."),
        tags$li("Key Stats Impacting Team Rank: Analyze how selected statistics across decades correlate with team standings.")
      )
    )
  )
}

# Define server logic for the home page
home_server <- function(input, output, session) {
  # No server-side logic is needed for the home page in this example
} 

