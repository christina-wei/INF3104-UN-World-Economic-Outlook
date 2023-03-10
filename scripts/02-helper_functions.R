#### Preamble ####
# Purpose: Collection of helper functions
# Author: Christina Wei
# Date: 19 February 2023
# Contact: christina.wei@mail.utoronto.ca
# License: MIT
# Prerequisites: none

#### Workspace setup ####

library(tidyverse)

## Write data to the inputs/data path in the project

save_to_csv = function(data, name) {
  write_csv(
    x = data,
    file = paste("inputs/data/", name, sep="")
  )
}

## Function to filter world economic outlook data based on a subject code
## Also pivots data into a clean format

filter_world_economic_outlook_data = function(data, subject_code, subject_name) {
  
  filtered_data = 
    data |>
    filter(weo_subject_code == subject_code) |>
    select(
      -weo_country_code,
      -weo_subject_code,
      -country,
      -subject_descriptor,
      -subject_notes,
      -units,
      -scale,
      -country_series_specific_notes,
      -estimates_start_after
    )
  
  # Pivot data
  filtered_data =
    filtered_data |>
    pivot_longer(
      cols = !country_iso,
      names_to = "year",
      values_to = subject_name,
      values_transform = as.numeric
    )  
  
  # Use data up to and including 2021
  filtered_data =
    filtered_data |>
    filter (year <= 2021)
  
  return(filtered_data)
}