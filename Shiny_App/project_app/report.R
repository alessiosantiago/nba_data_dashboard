report_ui <- function(id) {
  ns <- NS(id)
  tabPanel("Project Report",
           fluidPage(
             tags$head(
               tags$style(HTML("
                 .container-fluid {
                   padding: 2% 2%;
                   margin: 0 auto;
                   width: 100%;
                 }
                 .col-sm-12 {
                   padding: 0;
                   margin: 0;
                   width: 100%;
                 }
               "))
             ),
             column(
               width = 12,
               h2("Project Report"),
               htmlOutput("project_report_html")
             )
           )
  )
}

# Server logic to render the HTML content
report_server <- function(input, output, session) {
  setwd("~/Desktop/Shiny_App")
  file_path <- "data/report.html"
  output$project_report_html <- renderUI({
    includeHTML(file_path)
  })
}