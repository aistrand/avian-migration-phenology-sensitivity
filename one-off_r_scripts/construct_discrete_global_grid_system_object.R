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
library(raster)
library(sf)

# getwd()

# setwd("~/Documents/OU/Research/data")

getwd()


# fname <- as.character(sp_key[g_ind2,]$filenames[grep('.shp', sp_key[g_ind2, 'filenames'])])

# sp_rng <- rgdal::readOGR(fname[1], verbose = FALSE)


dsn <- path.expand("BOTW/BOTW.gdb") # ?

print(subset(rgdal::ogrDrivers(), grepl("GDB", name)))

print(rgdal::ogrListLayers(dsn))

# attr(,"driver") # ?
# OpenFileGDB" # ?


start_time <- Sys.time()

# all <- readOGR(dsn, "All_Species", verbose = FALSE)

# Error in ogrInfo(dsn = dsn, layer = layer, encoding = encoding, use_iconv = use_iconv,  : 
# Multiple incompatible geometries: wkbPolygon: 17371; NA: 173

# all <- readOGR(dsn, "All_Species", verbose = FALSE, require_geomType = "wkbPolygon")

all <- sf::st_read(dsn, layer = "All_Species")

end_time <- Sys.time()

print(end_time - start_time)

# 16.04451 minutes.


# Reading layer `All_Species' from data source `/Users/alvastrand/BOTW/BOTW.gdb' using driver `OpenFileGDB'
# Simple feature collection with 17544 features and 17 fields
# Geometry type: GEOMETRY
# Dimension:     XY
# Bounding box:  xmin: -180 ymin: -85.58276 xmax: 180 ymax: 85.00589
# Geodetic CRS:  WGS 84
# Warning message:
# In CPL_read_ogr(dsn, layer, query, as.character(options), quiet,  :
#                     GDAL Message 1: organizePolygons() received a polygon with more than 100 parts. The processing may be really slow.  You can 
#                 skip the processing by setting METHOD=SKIP, or only make it analyze counter-clock wise parts by setting METHOD=ONLY_CCW if you can 
#                 assume that the outline of holes is counter-clock wise defined


rgdal::writeOGR(all, dsn = "BOTW", layer = "All_Species", driver = "ESRI Shapefile")


# checklist <- readOGR(dsn, "BirdLife_HBW_Taxonomic_Checklist_V4")

# Error in readOGR(dsn, "BirdLife_HBW_Taxonomic_Checklist_V4") : 
# no features found
# In addition: Warning message:
# In ogrInfo(dsn = dsn, layer = layer, encoding = encoding, use_iconv = use_iconv,  :
# ogrInfo: all features NULL


# ogrInfo(dsn, "All_Species")

# ogrFIDs(dsn, "All_Species")

# ogrDrivers()

# OGRSpatialRef(dsn, "All_Species")


# remotes::install_github("RS-eco/rasterSp", build_vignettes = T)


# install.packages("foreign")

# library(foreign)

# read.dbf("BOTW/BOTW.gdb")