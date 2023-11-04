# library(dggridR)

# hexgrid6 <- dggridR::dgconstruct(res = 6)

library(rgdal)

getwd()

setwd("~/Documents/OU/Research/data")

getwd()

# fname <- as.character(sp_key[g_ind2,]$filenames[grep('.shp', sp_key[g_ind2, 'filenames'])])

# sp_rng <- rgdal::readOGR(fname[1], verbose = FALSE)

gdb <- path.expand("BOTW/BOTW.gdb") # ?

ogrListLayers(gdb)

# attr(,"driver") # ?
# OpenFileGDB" # ?

# start_time <- Sys.time()

all <- readOGR(gdb, "All_Species")

# end_time <- Sys.time()

# print(end_time - start_time)

# ogrInfo(gdb)

# ogrInfo(gdb, "All_Species")

# ogrFIDs(gdb)

# ogrFIDs(gdb, "All_Species")

# ogrDrivers()

# OGRSpatialRef(gdb)

# OGRSpatialRef(gdb, "All_Species")

 <- readOGR(gdb, "BirdLife_HBW_Taxonomic_Checklist_V4")