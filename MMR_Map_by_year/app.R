suppressPackageStartupMessages(library(tidyverse))
library(shiny)
library(maps)

library(rsconnect)
library(shiny)
library(dplyr)
library(ggplot2)
library(ggmap)
library(patchwork)
library(readr)
library(here)


mapp <- read_csv(here::here("dataset/phc_mmr_combined.csv"), col_types = cols(
  location_name = col_character(),
  year_id = col_double(),
  spending = col_double(),
  mean_val = col_double()
)) 

states_map <- map_data("state")

ui <- fluidPage(
  titlePanel("MMR Map by Year"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("year", "Year", min = 1999, max = 2019, value = 1999, step = 1)
    ),
    mainPanel(
      plotOutput("mapPlot")
    )
  )
)

server <- function(input, output) {
  output$mapPlot <- renderPlot({
    mmr_year <- mapp %>%
      filter(year_id == input$year) %>%
      mutate(state = tolower(location_name))
    
    map_mmr <- merge(states_map, mmr_year, by.x = "region", by.y = "state", all.x = TRUE)
    
    
    ggplot(map_mmr, aes(x = long, y = lat, group = group, fill = mean_val)) +
      geom_polygon(color = "white") +
      scale_fill_viridis_c(option = "C", direction = -1) +
      coord_fixed(1.3) +
      labs(fill = "MMR Value") +
      theme_void()
  })
}


shinyApp(ui = ui, server = server)