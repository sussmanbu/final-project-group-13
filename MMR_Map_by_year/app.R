suppressPackageStartupMessages(library(tidyverse))
library(shiny)
library(maps)
library(rsconnect)
library(dplyr)
library(ggplot2)
library(ggmap)
library(patchwork)
library(readr)
library(here)

# Load data
mapp <- read_csv(here::here("dataset/phc_mmr_combined.csv"), col_types = cols(
  location_name = col_character(),
  year_id = col_double(),
  spending = col_double(),
  mean_val = col_double()
)) 

# Get the states map data
states_map <- map_data("state")

# UI definition
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

# Server logic
server <- function(input, output) {
  
  # Determine the fixed scale limits based on the entire dataset
  min_val <- min(mapp$mean_val, na.rm = TRUE)
  max_val <- max(mapp$mean_val, na.rm = TRUE)
  
  output$mapPlot <- renderPlot({
    mmr_year <- mapp %>%
      filter(year_id == input$year) %>%
      mutate(state = tolower(location_name))
    
    map_mmr <- merge(states_map, mmr_year, by.x = "region", by.y = "state", all.x = TRUE)
    
    ggplot(map_mmr, aes(x = long, y = lat, group = group, fill = mean_val)) +
      geom_polygon(color = "white") +
      scale_fill_viridis_c(option = "C", direction = -1, limits = c(min_val, max_val)) +
      coord_fixed(1.3) +
      labs(fill = "MMR Value") +
      theme_void()
  })
}

# Run the Shiny app
shinyApp(ui = ui, server = server)











