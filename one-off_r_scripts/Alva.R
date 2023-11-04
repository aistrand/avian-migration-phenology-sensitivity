library(dggridR)

getwd()

setwd("~/Documents/OU/Research/data")

getwd()

# species = "barswa"
# species = "cliswa"
# species = "nrwswa"
species = "treswa"

start_date = "0101"
end_date = "0731"

month = "Apr"
year = "2020"

filename = paste("./eBird/ebd_output/", "ebd_US_states_east_Mississippi_", 
                 species, 
                 "_", 
                 start_date, 
                 "_", 
                 end_date, 
                 "_complete_zerofilled_rel", 
                 month, 
                 "-", 
                 year, 
                 ".csv", sep = "")

data <- read.csv(filename, header = TRUE)

hexgrid6 <- dgconstruct(res = 6)

data$cell <- dgGEO_to_SEQNUM(hexgrid6, in_lon_deg = data$longitude, in_lat_deg = data$latitude)[[1]]



library(rgdal)
library(sf)
library(maptools)
library(raster)
library(sp)
library(rgeos)

# getwd()

# setwd("~/Documents/OU/Research/data")

getwd()


# fname <- as.character(sp_key[g_ind2, ]$filenames[grep('.shp', sp_key[g_ind2, 'filenames'])])

# sp_rng <- rgdal::readOGR(fname[1], verbose = FALSE)


dsn <- "BOTW/BOTW.gdb"

print(rgdal::ogrListLayers(dsn))

start_time <- Sys.time()

print(start_time)

# df_all <- readOGR(dsn, "All_Species", verbose = FALSE)

# Error in ogrInfo(dsn = dsn, layer = layer, encoding = encoding, use_iconv = use_iconv,  : 
# Multiple incompatible geometries: wkbPolygon: 17371; NA: 173

# df_all <- readOGR(dsn, "All_Species", verbose = FALSE, require_geomType = "wkbPolygon")

df_all <- sf::st_read(dsn, layer = "All_Species")

# read_sf?*

# end_time <- Sys.time()

# print(end_time - start_time)

# 16.04451 minutes.

# class(df_all)

# str(df_all)

# colnames(df_all)

# head(df_all)

# puma <- df_all[df_all$SCINAME == "Progne subis", ]

# print(puma)

# puma_new <- st_simplify(puma)

# puma_new <- st_simplify(puma, dTolerance = 0.25)

# length(st_geometry(puma)[[1]])

# length(unlist(st_geometry(puma)[[1]]))

# length(st_geometry(puma_new)[[1]])

# length(unlist(st_geometry(puma_new)[[1]]))


# data(wrld_simpl)

# plot(wrld_simpl)

# subset_wrld_simpl <- wrld_simpl %>% subset(., ISO3 %in% c("USA", "CAN", "MEX"))
  
# plot(subset_wrld_simpl, xlim = c(-120, -80), ylim = c(0, 60))

# plot(puma[1, 1], col = "red", add = TRUE)


treswa <- df_all[df_all$SCINAME == "Tachycineta bicolor", ]

print(treswa)


df_a_i <- read.csv(file = "aerial_insectivores_read_ebird_data_output_v2.R.csv")

print(nrow(df_a_i))

# head(a_i_df)

for (i in 1:nrow(df_a_i)) {
  
  scientific_name <- df_a_i[i, "scientific_name"]
  
  print(scientific_name)
  
  df_species <- df_all[df_all$SCINAME == scientific_name, ]
  
  print(nrow(df_species))
  
  # print(df_species)
  
  species_code <- df_a_i[i, "species_code"]
  
  print(species_code)
  
  # filename <- paste("botw_species/botw_", species_code, ".shp", sep = "")
  
  filename <- paste("botw_species/botw_", species_code, ".rds", sep = "")
  
  print(filename)
  
  # write_sf(df_species, filename)
  
  saveRDS(df_species, filename)
  
}