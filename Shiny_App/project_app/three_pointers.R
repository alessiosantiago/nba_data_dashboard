library(plotly)
library(shiny)
three_pointers_ui <- function(id, nba_data) {
  ns <- NS(id)
  fluidPage(
    titlePanel("NBA 3 Pointers Made and Attempted from 1980 - 2019"),
    fluidRow(
      column(width = 11,
             p("On this page, you can explore three-point shooting statistics for NBA teams across different eras. Select the team of your choice below:")
      )
    ),
    sidebarLayout(
      sidebarPanel(
        # Dropdown input for selecting team
        selectInput("team_3p", "Select Team:",
                    choices = sort(unique(nba_data$Team)))
      ),
      mainPanel(
        plotlyOutput("bar_plot_x3pm", width = "650px"),
        plotlyOutput("bar_plot_x3pa", width = "675px")
      )
    )
  )
}

# Server Logic for Three-Pointers Tab
three_pointers_server <- function(input, output, session, nba_data) {
  filtered_data_2 <- reactive({
    subset(nba_data, Team == input$team_3p)
  })
  
  output$bar_plot_x3pm <- renderPlotly({
    gg <- ggplot(filtered_data_2(), aes(x = as.factor(Year), y = X3P, text = paste("3PM:", X3P, "<br>Year:", Year))) +
      geom_bar(stat = "identity", aes(fill = "Three-Pointers Made"), width = 0.7, position = position_dodge(width = 0.8)) +  
      scale_fill_manual(values = c("#99CC99")) +  # Lighter green
      theme_minimal() +
      labs(title = paste("Total Three-Pointers Made per Game by Year -", input$team_3p),
           x = "Year", y = "Average Count per Game") +
      theme(axis.text.x = element_text(angle = 60, hjust = 1, size = 6),  # Adjust font size and angle of x-axis labels
            plot.title = element_text(margin = margin(t = 20, b = 20)))  # Adjust title margin
    
    ggplotly(gg, tooltip = "text") %>% 
      layout(hoverlabel = list(bgcolor = "white", font = list(color = "black"))) %>%  # Tooltip style
      layout(margin = list(l = 50, r = 50, t = 100, b = 50))  # Adjust margins as needed)  # Adjust title position
    
  })
  
  output$bar_plot_x3pa <- renderPlotly({
    gg <- ggplot(filtered_data_2(), aes(x = as.factor(Year), y = X3PA, text = paste("3PA:", X3PA, "<br>Year:", Year))) +
      geom_bar(stat = "identity", aes(fill = "Three-Pointers Attempted"), width = 0.7, position = position_dodge(width = 0.8)) +  # Adjust width and dodge position
      scale_fill_manual(values = c("#FF9999")) +  # Lighter red
      theme_minimal() +
      labs(title = paste("Total Three-Pointers Attempted per Game by Year -", input$team_3p),
           x = "Year", y = "Average Count per Game") +
      theme(axis.text.x = element_text(angle = 60, hjust = 1, size = 6),  # Adjust font size and angle of x-axis labels
            plot.title = element_text(margin = margin(t = 20, b = 20)))  # Adjust title margin
    
    ggplotly(gg, tooltip = "text") %>% 
      layout(hoverlabel = list(bgcolor = "white", font = list(color = "black"))) %>%  # Tooltip style
      layout(margin = list(l = 50, r = 50, t = 100, b = 50))
  })
}



