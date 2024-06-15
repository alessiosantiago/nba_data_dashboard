library(shiny)
library(ggplot2)
library(plotly)
source("scripts/sidebar_ppg.r")

# UI for Points Per Game (PPG)
ppg_ui <- function(id, nba_data) {
  ns <- NS(id)
  fluidPage(
    titlePanel("League-Wide Distribution of Points Per Game by Year"),
    fluidRow(
      column(width = 11,
             p("On this page, you can explore the distribution of league-wide points per game (PPG) for a specific year in the NBA. Select a year from the dropdown menu to view the boxplot representing the distribution of PPG across all teams.")
      )
    ),
    sidebarLayout(
      create_sidebarPanel_ppg(nba_data),
      source("scripts/body_ppg.r")
    )
  )
}

# Server Logic for Points Per Game (PPG)
ppg_server <- function(input, output, session, nba_data) {
  filtered_data_3 <- reactive({
    req(input$selected_year_ppg)
    subset(nba_data, Year == input$selected_year_ppg)
  })
  
  output$ppg_boxplot <- renderPlotly({
    data <- filtered_data_3()
    
    p <- ggplot(data, aes(x = factor(Year), y = PTS, text = paste("Team: ", Team, "<br>PPG: ", PTS))) +
      geom_boxplot(fill = "#99CC99") +  
      theme_minimal() +
      labs(title = paste("Leauge-Wide Points Per Game Distribution for Year", input$selected_year_ppg),
           x = "Year", y = "Points Per Game") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
    
    # Convert ggplot to plotly with tooltips
    p <- ggplotly(p, tooltip = "text")
    
    # Adjust plotly layout
    p <- p %>% 
      layout(
        title = list(text = paste("Leauge-Wide Points Per Game Distribution for Year", input$selected_year_ppg), y = 0.95),
        margin = list(l = 50, r = 50, t = 50, b = 50)  # Adjust margins
      )
    
    p
  })
}

