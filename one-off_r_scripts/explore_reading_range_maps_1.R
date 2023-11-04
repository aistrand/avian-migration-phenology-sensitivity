# rgdal::writeOGR(all, dsn = "BOTW", layer = "All_Species", driver = "ESRI Shapefile")


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