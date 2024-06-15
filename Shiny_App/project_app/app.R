library(shiny)
library(ggplot2)
library(rsconnect)
setwd("~/Desktop/Shiny_App")


#Read in sources
nba_data <- read.csv("data/nba_data.csv") 
source("scripts/sidebar.r")
source("project_app/home.R")
source("project_app/teamrank.R")
source("project_app/three_pointers.R")
source("project_app/ppg.R")
source("project_app/factors.R")
source("project_app/report.R")

# Define UI for tabs
ui <- fluidPage(
  titlePanel("NBA Data Dashboard"),
  tabsetPanel(
    tabPanel("Home", home_ui("home")),
    tabPanel("Team Rank", teamrank_ui("team_rank", nba_data = nba_data)),
    tabPanel("Three Point Shooting", three_pointers_ui("three_pointers", nba_data = nba_data)),
    tabPanel("Points Per Game", ppg_ui("ppg", nba_data = nba_data)),
    tabPanel("Key Stats Impacting Team Rank", factors_ui("factors_ui", nba_data = nba_data)),
    tabPanel("Project Report", report_ui("report"))
  )
)

# Define server logic for each tab
server <- function(input, output, session) {

  home_server(input,output,session)
  
  teamrank_server(input,output, session , nba_data = nba_data)
  
  three_pointers_server(input,output, session , nba_data = nba_data)
  
  ppg_server(input,output, session , nba_data = nba_data)
  
  factors_server(input,output, session , nba_data = nba_data)
  
  report_server(input,output, session)
}

# Run the application
shinyApp(ui = ui, server = server)