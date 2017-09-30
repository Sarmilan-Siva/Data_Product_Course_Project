library(dplyr)
library(shiny)
library(leaflet)
library(leaflet.minicharts)

SLdist2L <- read.csv("./data/SLdist2L.csv")


basemap <- leaflet() %>%
  addProviderTiles(providers$OpenStreetMap.HOT)

# server function
function(input, output, session) {
  colors <- c("#082d17", "#1b6337", "#36bc6a", "#57e58e", "#7c847f")
  # Initialize map
  output$map <- renderLeaflet({
    basemap %>%
      addMinicharts(
        SLdist2L$lon, SLdist2L$lat,
        type = "pie",
        layerId = SLdist2L$DISTRICT_N,
        opacity = 0.8,
        #colorPalette = colors,
        width = 50 * sqrt(SLdist2L$Pop) / sqrt(max(SLdist2L$Pop)), transitionTime = 0
      )
  })

  # Update charts each time input value changes
  observe({
    if (input$prods == "Sex") {
      data <- SLdist2L[,c("Male", "Female")]
    } else if (input$prods == "Ethinicity") {
      data <- SLdist2L[, c("Sinhalese", "Tamils", "IndianTamils", "Muslims", "OtherEthGR")]
    } else if (input$prods == "Religion") {
      data <- SLdist2L[, c("Buddhist", "Hindu", "Islam", "Christians", "OtherReligGR")]
    }

    leafletProxy("map", session) %>%
      updateMinicharts(
        SLdist2L$DISTRICT_N,
        chartdata = data,
        colorPalette = colors,
        showLabels = input$labels
      )
  })
}

