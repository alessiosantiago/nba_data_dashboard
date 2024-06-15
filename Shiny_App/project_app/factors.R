library(shiny)
library(ggplot2)
source("scripts/sidebar_factors.r")
# Define UI for the front page
factors_ui <- function(id, nba_data) {
  ns <- NS(id)
  fluidPage(
    titlePanel("NBA Team Rank vs. Per Game Stats by Decade"),
    fluidRow(
      column(width = 11,
             p("On this page, you can explore how different statistics across decades influence an NBA team's rank. Select a decade and a statistical variable from the dropdown menus to view the scatterplot with a regression line representing the relationship between the chosen statistic and team rank.")
      )
    ),
    sidebarLayout(
        create_sidebarPanel_factors(nba_data),
        source("scripts/body_factors.r")
    )
  )
}

factors_server <- function(input, output, session, nba_data) {
  filtered_data_4 <- reactive({
    decade <- input$decade
    start_year <- as.numeric(substr(decade, 1, 4))
    end_year <- as.numeric(substr(decade, 6, 9))
    subset(nba_data, Year >= start_year & Year < end_year)
  })
  
  #Scatterplot of selected statistic vs team rank
  output$scatterplot <- renderPlotly({
    data <- filtered_data_4()
    
    # Check if the selected stat variable is numeric
    if (!is.numeric(data[[input$stat_variable]])) {
      stop("Selected stat variable is not numeric.")
    }
    
    display_names <- c("FG." = "FG%", "X3P" = "3PM", "X2P" = "2PM", "FT." = "FT%", "TRB" = "TRB",
                       "AST" = "ASTS", "STL" = "STLS", "BLK" = "BLKS", "TOV" = "TOVS", "PTS" = "PTS")
    
    # Create tooltip text
    data$tooltip <- paste("Team:", data$Team, "<br>Year:", data$Year, "<br>Rank:", data$Rk, "<br>", display_names[[input$stat_variable]], ":", data[[input$stat_variable]])
    
    # Create the scatter plot
    p <- ggplot(data, aes_string(x = input$stat_variable, y = "Rk", text = "tooltip")) +
      geom_point(color = "#A0C4DF", linewidth = 3) +  # Scatter plot with tooltip
      labs(x = input$stat_variable, y = "Rank", title = paste("Team Rank vs.", display_names[[input$stat_variable]], "Per Game for", input$decade)) +
      theme_minimal() +
      theme(plot.title = element_text(margin = margin(t = 40, b = 20)))  # Adjust title margin
    
    # Convert ggplot to plotly
    p_plotly <- ggplotly(p, tooltip = "text") %>% 
      layout(hoverlabel = list(bgcolor = "white", font = list(color = "black"))) %>%  # Tooltip style
      layout(title = list(y = 0.95))  # Adjust title position
    
    # Fit the linear model
    fit <- lm(as.formula(paste("Rk ~", input$stat_variable)), data = data)
    
    # Get the regression line data
    x_vals <- seq(min(data[[input$stat_variable]], na.rm = TRUE), max(data[[input$stat_variable]], na.rm = TRUE), length.out = 100)
    new_data <- data.frame(x_vals)
    colnames(new_data) <- input$stat_variable
    y_vals <- predict(fit, newdata = new_data)
    
    # Add the regression line to the plotly plot
    p_plotly %>%
      add_trace(x = x_vals, y = y_vals, mode = "lines", line = list(color = "#FF9999", width = 2), name = "Regression Line")
  })
}


