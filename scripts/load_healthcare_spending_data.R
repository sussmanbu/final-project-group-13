## script to load and clean healthcare spending data

suppressPackageStartupMessages(library(tidyverse))

us_per_capita20 <- 
  read_csv(here::here("dataset/healthcare_spending", "US_PER_CAPITA20.CSV"))

# choose columns we want
us_percap <- us_per_capita20 |> 
  reframe(Code, Item, REGION_NAME, State_Name, 
          Y1999, Y2000, Y2001, Y2002, Y2003, Y2004, Y2005, Y2006, Y2007, 
          Y2008, Y2009, Y2010, Y2011, Y2012, Y2013, Y2014, Y2015, Y2016, 
          Y2017, Y2018, Y2019)

us_phc_percap <- us_percap |> 
  filter(Item == "Personal Health Care ($)")

us_phc_percap[1, 4] = "United States"

us_phc_percap <- na.omit(us_phc_percap)

us_phc_percap <- us_phc_percap |> 
  reframe(State_Name, 
          Y1999, Y2000, Y2001, Y2002, Y2003, Y2004, Y2005, Y2006, Y2007, 
          Y2008, Y2009, Y2010, Y2011, Y2012, Y2013, Y2014, Y2015, Y2016, 
          Y2017, Y2018, Y2019)

us_phc_percap$region <- us_phc_percap$State_Name

northeast <- c("Connecticut", "Massachusetts", "Maine", "Maine", 
               "New Hampshire", "Rhode Island", "Vermont", "New Jersey", 
               "New York", "Pennsylvania")
midwest <- c("Indiana", "Illinois", "Michigan", "Ohio", "Wisconsin", "Iowa", 
             "Kansas", "Minnesota", "Missouri", "Nebraska", "North Dakota", 
             "South Dakota")
south <- c("Delaware", "District of Columbia", "Floria", "Georgia", "Maryland", 
          "North Carolina", "South Carolina", "Virginia", "West Virgina", 
          "Alabama", "Kentucky", "Mississippi", "Tennessee", "Arkansas", 
          "Louisiana", "Oaklahoma", "Texas")
west <- c("Arizona", "Colorado", "Idaho", "New Mexico", "Montana", "Utah", 
          "Nevada", "Wyoming", "Alaska", "California", "Hawaii", "Oregon", 
          "Washington")


# for(i in 1:52){
#   if (us_phc_percap[i, 1] in northeast){
#     us_phc_percap[i, 23] = "Northeast"
#   } else if 
# }






# medcaid
medicaid_aggregate20 <- 
  read_csv(here::here("dataset/healthcare_spending", "MEDICAID_AGGREGATE20.CSV"))

medicaid_enrollment20 <- 
  read_csv(here::here("dataset/healthcare_spending", "MEDICAID_ENROLLMENT20.CSV"))

medicaid_per_enrollee20 <- 
  read_csv(here::here("dataset/healthcare_spending", "MEDICAID_PER_ENROLLEE20.CSV"))

colnames(medicaid_aggregate20)[5] <- "REGION_NAME"

# medicaid_stacked <- 
#   rbind(medicaid_aggregate20, medicaid_enrollment20, medicaid_per_enrollee20)

# medicare
medicare_aggregate20 <- 
  read_csv(here::here("dataset/healthcare_spending", "MEDICARE_AGGREGATE20.CSV"))

medicare_enrollment20 <- 
  read_csv(here::here("dataset/healthcare_spending", "MEDICARE_ENROLLMENT20.CSV"))

medicare_per_enrollee20 <- 
  read_csv(here::here("dataset/healthcare_spending", "MEDICARE_PER_ENROLLEE20.CSV"))

colnames(medicare_aggregate20)[5] <- "REGION_NAME"
colnames(medicare_per_enrollee20)[5] <- "REGION_NAME"

# medicare_stacked <- 
#   rbind(medicare_aggregate20, medicare_enrollment20, medicare_per_enrollee20)

# private health insurance
phi_aggregate20 <- 
  read_csv(here::here("dataset/healthcare_spending", "PHI_AGGREGATE20.CSV"))

phi_enrollment20 <- 
  read_csv(here::here("dataset/healthcare_spending", "PHI_ENROLLMENT20.CSV"))

phi_per_enrollee20 <- 
  read_csv(here::here("dataset/healthcare_spending", "PHI_PER_ENROLLEE20.CSV"))

colnames(phi_aggregate20)[5] <- "REGION_NAME"
colnames(phi_per_enrollee20)[5] <- "REGION_NAME"

# phi_stacked <- 
#   rbind(phi_aggregate20, phi_enrollment20, phi_per_enrollee20)

# US OVERALL
us_aggregate20 <- 
  read_csv(here::here("dataset/healthcare_spending", "US_AGGREGATE20.CSV"))

us_per_capita20 <- 
  read_csv(here::here("dataset/healthcare_spending", "US_PER_CAPITA20.CSV"))

us_population20 <- 
  read_csv(here::here("dataset/healthcare_spending", "US_POPULATION20.CSV"))

colnames(us_aggregate20)[5] <- "REGION_NAME"
colnames(us_per_capita20)[5] <- "REGION_NAME"

# us_stacked <- 
#   rbind(us_aggregate20, us_per_capita20, us_population20)

# stacked data frames

# stacked <- rbind(medicaid_aggregate20, medicare_aggregate20)
# 
# healthcare_spending_enrollment_stacked 
#   <- rbind()

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
