library(dplyr)

data <- read.csv("dataset-ignore.gitignore/NationalAndStatePregnancy_PublicUse.csv")

data_clean <- select(data, -contains("abortion"), -contains("birth"), -contains("miscarriage"), -contains("population"))
data_ordered <- arrange(data_clean, state, year)
write.csv(data_ordered, "dataset/Cleaned_Pregnancy_Data.csv", row.names = FALSE)

library(dplyr)
library(ggplot2)

if(!("pregnancyratetotal" %in% names(data_clean))) {
  stop("The required column 'pregnancyratetotal' is not found in the dataset.")
}

ggplot(data_clean, aes(x = year, y = pregnancyratetotal, group = state, color = state)) +
  geom_line() +
  labs(title = "Trend of Pregnancy Rate by State",
       x = "year",
       y = "pregnancyratetotal",
       color = "state") +
  theme_minimal()



library(dplyr)
pregnancy_data <- read.csv("dataset/Cleaned_Pregnancy_Data.csv")

# Define midpoints for age-specific pregnancy rates
midpoints <- c(
  pregnancyrate1517 = 16,    
  pregnancyrate1819 = 18.5,  
  pregnancyrate2024 = 22,    
  pregnancyrate2529 = 27,    
  pregnancyrate3034 = 32,    
  pregnancyrate3539 = 37,    
  pregnancyrate40plus = 42   
)


pregnancy_data <- pregnancy_data %>%
  rowwise() %>%  # Ensure that we perform operations row-wise
  mutate(
    total_weighted_age = sum(c_across(names(midpoints)) * unlist(midpoints), na.rm = TRUE),
    total_rates = sum(c_across(names(midpoints)), na.rm = TRUE),
    average_age_of_pregnancy = if_else(total_rates > 0, total_weighted_age / total_rates, NA_real_)  # Avoid division by zero
  ) %>%
  ungroup() 

head(pregnancy_data, n = 10)

#replacing abbr to full name
state_names <- c(
  AL = "Alabama", AK = "Alaska", AZ = "Arizona", AR = "Arkansas", CA = "California",
  CO = "Colorado", CT = "Connecticut", DC = "District of Columbia", DE = "Delaware", FL = "Florida", GA = "Georgia",
  HI = "Hawaii", ID = "Idaho", IL = "Illinois", IN = "Indiana", IA = "Iowa",
  KS = "Kansas", KY = "Kentucky", LA = "Louisiana", ME = "Maine", MD = "Maryland",
  MA = "Massachusetts", MI = "Michigan", MN = "Minnesota", MS = "Mississippi",
  MO = "Missouri", MT = "Montana", NE = "Nebraska", NV = "Nevada", NH = "New Hampshire",
  NJ = "New Jersey", NM = "New Mexico", NY = "New York", NC = "North Carolina",
  ND = "North Dakota", OH = "Ohio", OK = "Oklahoma", OR = "Oregon", PA = "Pennsylvania",
  RI = "Rhode Island", SC = "South Carolina", SD = "South Dakota", TN = "Tennessee",
  TX = "Texas", UT = "Utah", VT = "Vermont", VA = "Virginia", WA = "Washington",
  WV = "West Virginia", WI = "Wisconsin", WY = "Wyoming"
)


pregnancy_data <- pregnancy_data %>%
  mutate(state = recode(state, !!!state_names))


head(pregnancy_data)

pregnancy_data$region <- pregnancy_data$state
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

pregnancy_data <- pregnancy_data %>%
  mutate(
    region = case_when(
      state %in% northeast ~ "Northeast",
      state %in% midwest   ~ "Midwest",
      state %in% south     ~ "South",
      state %in% west      ~ "West",
      TRUE                 ~ "Other"  
    )
  )


head(pregnancy_data)

write.csv(pregnancy_data, "dataset/Cleaned_Pregnancy_Data.csv", row.names = FALSE)
