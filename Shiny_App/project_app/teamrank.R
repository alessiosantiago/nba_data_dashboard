library(shiny)
library(ggplot2)
source("scripts/sidebar.r")

teamrank_ui <- function(id, nba_data) {
  ns <- NS(id)
  fluidPage(
    titlePanel("NBA Team Rank from 1980 - 2019"),
    fluidRow(
      column(width = 11,
             p("On this page, you can explore how an NBA team's standings have evolved over a selected period. Choose a team and specify the start and end years to view their historical rankings.")
      )
    ),
    sidebarLayout(
      create_sidebarPanel(nba_data),
      source("scripts/body.r"),
    )
  )
}
# Define server logic for the team rank page
teamrank_server <- function(input, output, session, nba_data) {
  filtered_data <- reactive({
    subset(nba_data, Team == input$team & Year >= input$start_year & Year <= input$end_year)
  })
  
  output$team_performance_plot <- renderPlotly({
    data <- filtered_data()
    
    p <- ggplot(data, aes(x = Year, y = Rk)) +
      geom_line(color = "#A0C4DF", size = 1) +
      geom_point(aes(text = paste("Team:", Team, "<br>Year:", Year, "<br>Rank:", Rk)), color = "#A0C4DF", size = 2) +
      labs(x = "Year", y = "Rank", title = paste("Rank of", input$team, "over the selected year range")) +
      scale_x_continuous(breaks = seq(as.numeric(input$start_year), as.numeric(input$end_year), by = ifelse(as.numeric(input$end_year) - as.numeric(input$start_year) > 20, 5, 1))) +
      theme_minimal()
    
    ggplotly(p, tooltip = "text", dynamicTicks = TRUE) %>%
      layout(
        title = list(text = paste("Rank of", input$team, "over the selected year range")),
        margin = list(l = 50, r = 50, t = 90, b = 50)
      )
    
  })
}










