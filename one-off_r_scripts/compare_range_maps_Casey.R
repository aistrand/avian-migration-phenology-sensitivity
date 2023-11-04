# library(rgdal)
library(sf)
library(maptools)

# getwd()

dsn <- "Tachycineta_bicolor_22712057.shp"

# print(rgdal::ogrListLayers(dsn))

df_casey <- sf::st_read(dsn, layer = "Tachycineta_bicolor_22712057")

print(df_casey)


species_code <- "treswa"

filename <- paste("botw_species/botw_", species_code, ".rds", sep = "")

df_species <- readRDS(filename)

print(df_species)


data(wrld_simpl)

row_nb <- 2


subset_wrld_simpl <- wrld_simpl %>% subset(., ISO3 %in% c("USA", "CAN", "MEX"))

plot(subset_wrld_simpl, xlim = c(-120, -80), ylim = c(0, 60))

plot(wrld_simpl)

plot(df_casey[row_nb, 1], col = "red", add = TRUE)

plot(df_casey[row_nb, 1], col = "red")


subset_wrld_simpl <- wrld_simpl %>% subset(., ISO3 %in% c("USA", "CAN", "MEX"))

plot(subset_wrld_simpl, xlim = c(-120, -80), ylim = c(0, 60))

plot(df_species[row_nb, 1], col = "red", add = TRUE)