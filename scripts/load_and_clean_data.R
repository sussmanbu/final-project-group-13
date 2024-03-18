# This file is purely as an example. 
# There are a few places

suppressPackageStartupMessages(library(tidyverse))


mmr_data <- read_csv(here::here("dataset", "IHME_USA_MMR_STATE_RACE_ETHN_1999_2019_ESTIMATES_Y2023M07D03.CSV"))

## CLEAN the data
# mmr_data_clean <- loan_data
# 
# write_csv(loan_data_clean, file = here::here("dataset", "loan_refusal_clean.csv"))
# 
# save(loan_data_clean, file = here::here("dataset/loan_refusal.RData"))
