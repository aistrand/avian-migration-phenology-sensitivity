# install.packages("auk")
# install.packages("tidyverse")
# install.packages("beepr")

# install.packages("swirl")

# install.packages('remotes')
# remotes::install_github('mstrimas/ebppackages')

# install.packages('R.utils')

library(auk)
library(tidyverse)
library(beepr)

# library(swirl)

# command+option+B
# command+option+E

setwd("~/Documents/OU/Research/data")

# Why doesn't this work?
# setwd("/Users/alvastrand/Documents/OU/Research/data")

print(getwd())
# "/Users/alvastrand/Documents/OU/Research/data/eBird"

path = "./eBird/ebd_data_downloaded/"

auk_set_ebd_path(path, overwrite = TRUE)

auk_get_ebd_path()
# "/Users/alvastrand/Documents/OU/Research/data/eBird/ebd_data_downloaded"

filter_ebd <- function(species, species_name, country, start_date, end_date, month, year) {
  
  path_input = paste(auk_get_ebd_path(), "/", sep = "")
  print(path_input)
  
  filename = paste(path_input, "ebd_", species, "_rel", month, "-", year, "/ebd_", species, "_rel", month, 
                   "-", year, ".txt", sep = "")
  
  # filename = paste("ebd_", species, "_rel", month, "-", year, "/ebd_", species, "_rel", month, "-", year,
  #                  ".txt", sep = "")
  
  # Error: Path 'ebd_purmar_relApr-2020/ebd_purmar_relApr-2020.txt' does not exist
  
  print(filename)
  
  sampling_filename = paste("ebd_sampling_rel", month, "-", year, ".txt", sep = "")
  
  # sampling_filename = paste(path_input, "ebd_sampling_rel", month, "-", year, "/ebd_sampling_rel", month, 
  #                           "-", year, ".txt.gz", sep = "")
  
  # sampling_filename = paste("ebd_sampling_rel", month, "-", year, "/ebd_sampling_rel", month, "-", year,
  #                           ".txt.gz", sep = "")
  
  print(sampling_filename)
  
  # ebd <- read_ebd(filename, unique = FALSE, rollup = FALSE)
  
  # glimpse(ebd)
  
  # print(nrow(ebd))
  # # 987,339
  # print(ncol(ebd))
  # # 46
  
  # start_time <- Sys.time()
  
  # ebd <- read_ebd(filename, unique = TRUE, rollup = TRUE)
  
  # end_time <- Sys.time()
  # # Get time elapsed.
  # print(end_time - start_time)
  # # 2.042028 mins.
  
  # print(nrow(ebd))
  # # 825,782
  # print(ncol(ebd))
  # # 45
  
  ebd <- auk_ebd(filename, sampling_filename)
  
  date_range = c("*-01-01", "*-07-31")
  # ?
  
  # states_codes = ebird_states[ebird_states$country == "United States", ]
  
  states = c("US-AL", "US-CT", "US-DE", "US-FL", "US-GA", "US-IL", "US-IN", "US-KY", "US-ME", "US-MD", "US-MA", 
             "US-MI", "US-MS", "US-NH", "US-NJ", "US-NY", "US-NC", "US-OH", "US-PA", "US-RI", "US-SC", "US-TN", 
             "US-VT", "US-VA", "US-WV", "US-WI")
  
  protocol = c("Stationary", "Traveling")
  # ?
  
  distance = c(0, 5)
  
  duration = c(0, 300)
  
  ebd_filters <- ebd %>%
    auk_species(species_name) %>%
    auk_date(date_range) %>%
    auk_country(country) %>%
    auk_state(states) %>%
    auk_protocol(protocol) %>%
    auk_distance(distance) %>%
    auk_duration(duration) %>%
    auk_complete()
  
  # ebd_filters <- ebd %>%
  #   auk_species(species_name) %>%
  #   auk_date(date_range) %>%
  #   auk_country(country) %>%
  #   auk_protocol(protocol) %>%
  #   auk_distance(distance) %>%
  #   auk_duration(duration) %>%
  #   auk_complete()
  
  print(ebd_filters)
  
  # Countries: all with auk_state(states)? Error?
  
  # auk_last_edited()?
  # auk_state()?
  # auk_time()?
  
  path_ebd_output = "./eBird/ebd_output/"
  
  f_ebd = paste(path_ebd_output, "ebd_", country, "_states_east_Mississippi_", species, "_", start_date, "_", end_date, 
                "_complete_rel", month, "-", year, ".txt", sep = "")
  
  # f_ebd = paste(path_ebd_output, "ebd_", country, "_", species, "_", start_date, "_", end_date, 
  #               "_complete_rel", month, "-", year, ".txt", sep = "")
  
  print(f_ebd)
  
  f_sampling = paste(path_ebd_output, "ebd_sampling_", country, "_states_east_Mississippi_", species, "_", start_date, "_", 
                     end_date, "_complete_rel", month, "-", year, ".txt", sep = "")
  
  # f_sampling = paste(path_ebd_output, "ebd_sampling_", country, "_", species, "_", start_date, "_", end_date, 
  #                    "_complete_rel", month, "-", year, ".txt", sep = "")
  
  print(f_sampling)
  
  start_time <- Sys.time()
  
  auk_filter(ebd_filters, file = f_ebd, file_sampling = f_sampling)
  # # This line of code produces two files (with filenames f_ebd and f_sampling) that should be in /Users/alvastrand.
  
  end_time <- Sys.time()
  # Get time elapsed.
  print(end_time - start_time)
  # 14.52106 mins.
  # 15.9 mins.
  
  # 16.27747 mins.
  # 13.68565 mins.
  
}

path_output = "./output/"

filename = paste(path_output, "obligate_aerial_insectivores_ebird_species_codes.csv", sep = "")
print(filename)

df = read.csv(file = filename)

# print(nrow(df))
# # 19

country = "US"
# Canada?

start_date = "0101"
end_date = "0731"

month = "Apr"
year = "2020"

# print(df[["species_code"]])

# for (i in 1:nrow(df)) {
#   
#   print(i)
#   
#   species = df[["species_code"]][i]
#   print(species)
#   
#   species_name = df[["common_name"]][i]
#   print(species_name)
#   
#   if (species == "barswa" | species == "purmar") {
#     next
#   }
#   
#   filter_ebd(species, species_name, country, start_date, end_date, month, year)
# }

beep()