# User interface
library(shiny)
library(leaflet)

ui <- fluidPage(
  tags$head(
    tags$style(HTML("
      @import url('/fonts.googleapis.com/css?family=Merriweather');
    "))
  ),

  headerPanel(
    h1("Democratic Information of Sri Lanka",
       style = "font-family: 'Merriweather', serif;
       font-weight: 500; line-height: 1.1;
       color: #0f542b;")),

  p("This application graphically illustrates the democratic information such as Sex, Ethinicity and Religious of Sri Lanka at district level",
    style = "font-family: 'Merriweather', serif;
       font-weight: 0; line-height: 1.1;
    color: #032d0e;"),

  sidebarLayout(

    sidebarPanel(
      selectInput("prods", "Group", choices = c("Sex", "Ethinicity", "Relious"), multiple = FALSE),
      checkboxInput("labels", "Show values"),
      helpText('This App is designed to show Sri Lankan democratic information district wise.',
              'Select one under Slidebar to specify your interest and click on the Check box to
                view the values. Clicks on the Pie chart will give you all relevant information 
                about the district.',
               'Please note that percentage of categories are indicated in the Pie chart and the size of
               the chart is proportion to the population')
    ),

    mainPanel(
      leafletOutput("map", width = "100%", height = "740")
    )

  )
)

