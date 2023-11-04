library(auk)
library(tidyverse)
library(beepr)

setwd("~/Documents/OU/Research/data")

print(getwd())
# "/Users/alvastrand/Documents/OU/Research/data"

zerofill_ebd <- function(species, species_name, country, start_date, end_date, month, year) {

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
  
  # sed <- read_sampling(f_sampling, unique = FALSE)
  
  # There were 50 or more warnings (use warnings() to see the first 50)
  # Warning messages:
  # 1: Unknown or uninitialised column: `gridcell`.
  
  # sed <- read_sampling(f_sampling, unique = FALSE, rollup = FALSE)
  
  # Error in read_sampling(f_sampling, unique = FALSE, rollup = FALSE) :
  # unused argument (rollup = FALSE)
  
  # print(nrow(sed))
  # # 9,689,239
  # # 16,494,527
  # print(ncol(sed))
  # # 30
  
  # start_time <- Sys.time()
  
  # sed <- read_sampling(f_sampling, unique = TRUE)
  
  # Barn Swallow: Error: vector memory exhausted (limit reached?)
  
  # end_time <- Sys.time()
  # # Get time elapsed.
  # print(end_time - start_time)
  # # 4.955958 mins.
  
  # print(nrow(sed))
  # # barswa
  # # 8,553,536
  # print(ncol(sed))
  # # 31
  
  # ebd <- read_ebd(f_ebd, unique = FALSE, rollup = FALSE)
  
  # Warning message:
  # Missing column names filled in: 'X47' [47]
  
  # print(nrow(ebd))
  # # 1,098,216
  # # 1,899,557
  # print(ncol(ebd))
  # # 46
  
  # start_time <- Sys.time()
  
  # ebd <- read_ebd(f_ebd, unique = TRUE, rollup = TRUE)
  
  # end_time <- Sys.time()
  # # Get time elapsed.
  # print(end_time - start_time)
  # # 2.523757 mins.
  # # 4.277013 mins.
  
  # print(nrow(ebd))
  # # 921,680
  # # 1,577,559
  # print(ncol(ebd))
  # # 45
  
  start_time <- Sys.time()
  
  ebd_zf <- auk_zerofill(f_ebd, f_sampling, collapse = TRUE)
  
  end_time <- Sys.time()
  # Get time elapsed.
  print(end_time - start_time)
  # 11.09682 mins.
  
  # table(ebd_zf$species_observed)
  
  # Before filtering by number of observers.
  # FALSE: 7,631,856, TRUE: 921,680
  
  ebd_zf_f <- ebd_zf %>%
    filter(number_observers <= 10)
  
  print(table(ebd_zf_f$species_observed))
  
  # After filtering by number of observers.
  # FALSE: 7,463,341, TRUE: 888,430
  
  # Minimum
  print(min(ebd_zf_f$latitude))
  # 23.88817
  # Maximum
  print(max(ebd_zf_f$latitude))
  # 48.2235
  
  # Minimum
  print(min(ebd_zf_f$longitude))
  # -92.88799
  # Maximum
  print(max(ebd_zf_f$longitude))
  # -66.94957
  
  f_zerofilled = paste(path_ebd_output, "ebd_", country, "_states_east_Mississippi_", species, "_", start_date, "_", 
                       end_date, "_complete_zerofilled_rel", month, "-", year, ".csv", sep = "")
  print(f_zerofilled)
  
  start_time <- Sys.time()
  
  write.csv(ebd_zf_f, file = f_zerofilled, row.names = FALSE)
  
  end_time <- Sys.time()
  # Get time elapsed.
  print(end_time - start_time)
  # 3.292666 mins.

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

for (i in 1:nrow(df)) {
  
  print(i)
  
  species = df[["species_code"]][i]
  print(species)
  
  species_name = df[["common_name"]][i]
  print(species_name)
  
  if (species == "souwpw1" | species == "bucnig" | species == "compoo" | species == "whtswi" | species == "blkswi") {
    next
  }
  
  zerofill_ebd(species, species_name, country, start_date, end_date, month, year)
}

beep()