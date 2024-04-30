## script to load and clean healthcare spending data

suppressPackageStartupMessages(library(tidyverse))

us_per_capita20 <- 
  read_csv(here::here("dataset/healthcare_spending", "US_PER_CAPITA20.CSV"))

# choose columns we want
us_percap <- us_per_capita20 |> 
  reframe(Code, Item, Region_Name, State_Name, 
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


## add region modifier like original data set

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


for(i in 1:52){
  if (us_phc_percap[i, 1] %in% northeast){
    us_phc_percap[i, 23] = "Northeast Census Region"
  } else if (us_phc_percap[i, 1] %in% midwest){
    us_phc_percap[i, 23] = "Midwest Census Region"
  } else if (us_phc_percap[i, 1] %in% south){
    us_phc_percap[i, 23] = "South Census Region"
  } else if (us_phc_percap[i, 1] %in% west){
    us_phc_percap[i, 23] = "West Census Region"
  }
}

## load in original dataset to compare

load("dataset/mmr.RData")
mmr_combine <- mmr_data_clean |> 
  group_by(location_name, year_id) |> 
  summarize(mean_val = mean(val))

## reshaping to have observation for each state for each year
phc_percap_longer <- us_phc_percap |> 
  pivot_longer(
    cols = starts_with("Y"),
    names_to = ("Year"), 
    values_to = ("spending")
  )


# fix year variable
phc_percap_longer$year_id <- sub("Y", "", phc_percap_longer$Year)


# create summaries for census regions
region_means <- phc_percap_longer |>
  group_by(region, year_id) |> 
  summarize(spending = mean(spending))

colnames(region_means)[colnames(region_means) == "region"] <- "location_name"

## make phc data combine-able
colnames(phc_percap_longer)[colnames(phc_percap_longer) == "State_Name"] <- "location_name"

phc_percap_longer$location_name[phc_percap_longer$location_name == "United States"] <- "National"

phc_percap_longer <- phc_percap_longer |> 
  reframe(location_name, year_id, spending)

# stack region phc data and other phc data
phc_combine <-
  rbind(phc_percap_longer, region_means)

phc_combine |> 
  filter(location_name == "National")
phc_combine |> 
  filter(location_name == "United States")

phc_combine <- phc_combine[phc_combine$location_name != "United States", ]


## combine them
combined_data <- merge(phc_combine, mmr_combine, by = c("location_name", "year_id"), all = TRUE)


## save the data 
write_csv(combined_data, file = here::here("dataset", "phc_mmr_combined.csv"))

save(combined_data, file = here::here("dataset/phc_mmr.RData"))
