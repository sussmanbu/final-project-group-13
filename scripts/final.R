# Load the data
data <- read.csv("dataset/new_phc_mmr_combine.csv")

# Convert race_group options into numeric values
race_group_mapping <- c(
  "Hispanic and any race" = 1,
  "Non-Hispanic American Indian and Alaska Native" = 2,
  "Non-Hispanic Asian, Native Hawaiian, or Other Pacific Islander" = 3,
  "Non-Hispanic Black" = 4,
  "Non-Hispanic White" = 5
)

# Replace race_group values using the mapping
data$race_group <- race_group_mapping[data$race_group]

# Convert race_group to numeric
data$race_group <- as.numeric(data$race_group)

# Convert region options into numeric values
region_mapping <- c(
  "south" = 1,
  "west" = 2,
  "northeast" = 3,
  "midwest" = 4
)

# Replace region values using the mapping
data$region <- region_mapping[tolower(data$Region)] # tolower handles case sensitivity

# Convert region to numeric
data$region <- as.numeric(data$region)

# Remove rows with NA in AverageAge and convert it to integer
data <- data[!is.na(data$AverageAge), ]
data$AverageAge <- as.integer(data$AverageAge)

# View the first few rows to verify the changes
head(data)

# Save the cleaned data
write.csv(data, "dataset/cleaned_phc_mmr_combine.csv", row.names = FALSE)
