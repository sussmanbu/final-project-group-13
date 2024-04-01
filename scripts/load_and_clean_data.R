## script to load and clean initial dataset

suppressPackageStartupMessages(library(tidyverse))

mmr_data <- read_csv(here::here("dataset", "IHME_USA_MMR_STATE_RACE_ETHN_1999_2019_ESTIMATES_Y2023M07D03.CSV"))

## CLEAN the data

mmr_data_clean <- mmr_data

mmr_data_clean <-
mmr_data |> 
  reframe(location_id, location_name, race_group, year_id, val, lower, upper)

write_csv(mmr_data_clean, file = here::here("dataset", "mmr_clean.csv"))

save(mmr_data_clean, file = here::here("dataset/mmr.RData"))

