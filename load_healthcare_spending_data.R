## script to load and clean initial dataset

suppressPackageStartupMessages(library(tidyverse))

# medcaid
medicaid_aggregate20 <- 
  read_csv(here::here("dataset/healthcare_spending", "MEDICAID_AGGREGATE20.CSV"))

medicaid_enrollment20 <- 
  read_csv(here::here("dataset/healthcare_spending", "MEDICAID_ENROLLMENT20.CSV"))

medicaid_per_enrollee20 <- 
  read_csv(here::here("dataset/healthcare_spending", "MEDICAID_PER_ENROLLEE20.CSV"))

# medicare
medicare_aggregate20 <- 
  read_csv(here::here("dataset/healthcare_spending", "MEDICARE_AGGREGATE20.CSV"))

medicare_enrollment20 <- 
  read_csv(here::here("dataset/healthcare_spending", "MEDICARE_ENROLLMENT20.CSV"))

medicare_per_enrollee20 <- 
  read_csv(here::here("dataset/healthcare_spending", "MEDICARE_PER_ENROLLEE20.CSV"))

# private health insurance
phi_aggregate20 <- 
  read_csv(here::here("dataset/healthcare_spending", "PHI_AGGREGATE20.CSV"))

phi_enrollment20 <- 
  read_csv(here::here("dataset/healthcare_spending", "PHI_ENROLLMENT20.CSV"))

phi_per_enrollee20 <- 
  read_csv(here::here("dataset/healthcare_spending", "PHI_PER_ENROLLEE20.CSV"))

# US OVERALL
us_aggregate20 <- 
  read_csv(here::here("dataset/healthcare_spending", "US_AGGREGATE20.CSV"))

us_per_capita20 <- 
  read_csv(here::here("dataset/healthcare_spending", "US_PER_CAPITA20.CSV"))

us_population20 <- 
  read_csv(here::here("dataset/healthcare_spending", "US_POPULATION20.CSV"))

## CLEAN the data

# mmr_data_clean <- mmr_data
# 
# mmr_data_clean <-
#   mmr_data |> 
#   reframe(location_id, location_name, race_group, year_id, val, lower, upper)
# 
# write_csv(mmr_data_clean, file = here::here("dataset", "mmr_clean.csv"))
# 
# save(mmr_data_clean, file = here::here("dataset/mmr.RData"))
# 
