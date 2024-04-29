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
