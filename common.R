
# clear workspace
rm(list = ls(all = TRUE))

# clear all packages except base
#lapply(names(sessionInfo()$loadedOnly), require, character.only = TRUE)
#invisible(lapply(paste0('package:', names(sessionInfo()$otherPkgs)), detach, character.only=TRUE, unload=TRUE, force=TRUE))



# set translation language
lang <- "en"



# import translations
test <- googlesheets4::read_sheet(
     "https://docs.google.com/spreadsheets/d/1GRvHou9l29MhyMSL1Wx3AOI9lUDrBmCOTJJycxrC1pw/edit#gid=1187534738",
     range = "test_chapter", col_types = "c") %>%
     clean_names()
#test <- import(here("translations", "data", "test.rds"))




# to ensure that tidyverse packages prevail
filter <- dplyr::filter
select <- dplyr::select
summarise <- dplyr::summarise
summary <- base::summary
incidence <- incidence2::incidence
clean_names <- janitor::clean_names

#load core packages
pacman::p_load(
     rio,
     here,
     DT,
     stringr,
     lubridate,
     tidyverse
)

# import the cleaned ebola linelist
linelist <- rio::import(here::here("data", "case_linelists", "linelist_cleaned.rds"))

# import the count data - facility level
#count_data <- rio::import(here::here("data", "facility_count_data.rds"))

# Settings

options(scipen=1, digits=7)

# print only text (not code)
# library(knitr)
# opts_chunk$set(list(echo = FALSE, eval = FALSE))
