# Load necessary library
library(dplyr)

# Read the dataset
# Replace 'dataset/new_phc_mmr_combine.csv' with the path to your actual CSV file
data <- read.csv('dataset/new_phc_mmr_combine.csv')

# Filter out rows where AverageAge is "N/A"
data <- data %>% filter(AverageAge != "N/A")

# Define race_mapping
race_mapping <- list(
  "Hispanic and any race" = 1,
  "Non-Hispanic American Indian and Alaska Native" = 2,
  "Non-Hispanic Asian, Native Hawaiian, or Other Pacific Islander" = 3,
  "Non-Hispanic Black" = 4,
  "Non-Hispanic White" = 5
)

# Function to classify region
assign_race <- function(race_group) {
  if (race_group %in% c("Hispanic and any race")) {
    return(1)  # 1 for Northeast
  } else if (race_group %in% c("Non-Hispanic American Indian and Alaska Native")) {
    return(2)  # 2 for Midwest
  } else if (race_group %in% c("Non-Hispanic Asian, Native Hawaiian, or Other Pacific Islander")) {
    return(3)  # 3 for South
  } else if (race_group %in% c("Non-Hispanic Black")) {
    return(4)  # 4 for West
  } else {
    return(5)  
  }
}

data$Region <- sapply(data$state, assign_race)

# Save the merged data to a new CSV file
write_csv(merged_data, "dataset/final.csv")

