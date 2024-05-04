# Load necessary packages
library(readr)
library(dplyr)

# Load mmr_clean file
mmr_clean <- read_csv("dataset/mmr_clean.csv")

# Load phc_mmr_with_age.csv file
phc_mmr_with_age <- read_csv("dataset/phc_mmr_with_age.csv")

# Inspect and standardize column names if necessary
names(mmr_clean)
names(phc_mmr_with_age)

# Modify column names and formats in mmr_clean to match phc_mmr_with_age
mmr_clean <- mmr_clean %>%
  rename(state = location_name, year = year_id)

# Convert state and year to lower case to standardize (if needed)
mmr_clean$state <- tolower(mmr_clean$state)
phc_mmr_with_age$state <- tolower(phc_mmr_with_age$state)

# Merge the datasets based on state and year
merged_data <- left_join(phc_mmr_with_age, mmr_clean %>% select(state, year, race_group), by = c("state", "year"))

# Save the merged data to a new CSV file
write_csv(merged_data, "dataset/new_phc_mmr_combine.csv")

# Print the head of the dataframe to check
print(head(data))

