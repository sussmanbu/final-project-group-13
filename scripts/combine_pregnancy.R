library(readr)
library(dplyr)

# Read data from CSV files
pregnancy_data <- read_csv("dataset/Cleaned_Pregnancy_Data.csv")
phc_data <- read_csv("dataset/phc_mmr_combined.csv")

print(colnames(pregnancy_data))
print(colnames(phc_data))

phc_data <- rename(phc_data, year = year_id, state = location_name)

mean_age_data <- pregnancy_data %>%
  group_by(year, state) %>%
  summarize(AverageAge = mean(average_age_of_pregnancy, na.rm = TRUE), .groups = 'drop')

phc_enriched <- left_join(phc_data, mean_age_data, by = c("year", "state"))

phc_enriched$AverageAge <- ifelse(is.na(phc_enriched$AverageAge), "N/A", phc_enriched$AverageAge)

write_csv(phc_enriched, "dataset/phc_mmr_with_age.csv")


library(readr)
library(dplyr)

data <- read_csv("dataset/phc_mmr_with_age.csv")

northeast <- c("Connecticut", "Massachusetts", "Maine", "Maine", 
               "New Hampshire", "Rhode Island", "Vermont", "New Jersey", 
               "New York", "Pennsylvania")
midwest <- c("Indiana", "Illinois", "Michigan", "Ohio", "Wisconsin", "Iowa", 
             "Kansas", "Minnesota", "Missouri", "Nebraska", "North Dakota", 
             "South Dakota")
south <- c("Delaware", "District of Columbia", "Florida", "Georgia", "Maryland", 
           "North Carolina", "South Carolina", "Virginia", "West Virginia", 
           "Alabama", "Kentucky", "Mississippi", "Tennessee", "Arkansas", 
           "Louisiana", "Oklahoma", "Texas")
west <- c("Arizona", "Colorado", "Idaho", "New Mexico", "Montana", "Utah", 
          "Nevada", "Wyoming", "Alaska", "California", "Hawaii", "Oregon", 
          "Washington")


assign_region <- function(state) {
  if (state %in% northeast) {
    return("Northeast")
  } else if (state %in% midwest) {
    return("Midwest")
  } else if (state %in% south) {
    return("South")
  } else if (state %in% west) {
    return("West")
  } else {
    return(NA) 
  }
}

# Apply the function to create a new Region column
data$Region <- sapply(data$state, assign_region)

# Optionally, write the updated data back to a CSV
write_csv(data, "dataset/phc_mmr_with_age.csv")

# Print the head of the dataframe to check
print(head(data))