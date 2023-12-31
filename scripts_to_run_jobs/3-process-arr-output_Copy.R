######################
# 3 - process arrival GAM output
#
# Aggregate posterior info and diagnostic info from 2-arr-GAM.R to be used in IAR model
# Determine which cells should be used in IAR model (cells that overlap breeding and migratory ranges, but do not overlap resident or non-breeding ranges)
#
######################


# Top-level dir -----------------------------------------------------------

# # #desktop/laptop
# # dir <- '~/Google_Drive/R/'


# db/hm query dir ------------------------------------------------------------

# # gam_dir <- 'arrival_GAM_2020-07-10'

gam_dir <- 'arrival_GAM_2022-02-05_1500'

# # gam_dir2 <- NULL
# #gam_dir2 <- 'arrival_GAM_2020-07-23-Vireo-olivaceus'
gam_date <- substr(gam_dir, start = 13, stop = 22)
# #gam_date2 <- substr(gam_dir2, start = 13, stop = 22)
# # gam_date2 <- NULL
# #years specified for 2-arr-GAM

# # years <- 2002:2017

# years <- 2002

years <- 2002:2019


# runtime -----------------------------------------------------------------

tt <- proc.time()


# Load packages -----------------------------------------------------------

library(dplyr)
# library(dggridR)
# library(sp)
# library(maptools)
# library(raster)
# library(rgdal)
# library(rgeos)


# calculate grid/land overlap ---------------------------------------------

# #make hexgrid
# hexgrid6 <- dggridR::dgconstruct(res = 6)
# 
# # setwd(paste0(dir, 'Bird_Phenology/Data/hex_grid_crop/'))
# 
# setwd('Bird_Phenology/Data/hex_grid_crop/')
# 
# #read in grid
# hge <- rgdal::readOGR('hex_grid_crop.shp', verbose = FALSE)
# hge_cells <- as.numeric(as.character(hge@data[,1]))
# 
# #load maps
# combmap <- maps::map("world", c("USA", "Canada", "Mexico"),
#                      fill = TRUE, plot = FALSE)
# 
# #make maps into spatial polygon object
# IDs <- sapply(strsplit(combmap$names, ":"), function(x) x[1])
# cmap <- maptools::map2SpatialPolygons(combmap, IDs = IDs,
#                                       proj4string = CRS(proj4string(hge)))
# 
# #convert map to equal area projection
# cmap2 <- sp::spTransform(cmap, sp::CRS("+proj=laea +lat_0=0 +lon_0=-70 +x_0=4321000 +y_0=3210000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"))
# 
# #calculate overlap between each hex cell and map
# ovr_df <- data.frame(cell = hge_cells, per_ovr = NA)
# for (i in 1:length(hge))
# {
#   #just one hex cell
#   hge_spoly <- sp::SpatialPolygons(list(hge@polygons[[i]]))
#   proj4string(hge_spoly) <- sp::CRS(proj4string(hge))
# 
#   #tranform to equal area projection
#   hge_spoly2 <- sp::spTransform(hge_spoly, sp::CRS(proj4string(cmap2)))
# 
#   #area of hex cell (should all be the same)
#   hex_area <- rgeos::gArea(hge_spoly2)
#   #get intersection of hex cell and map
#   int <- rgeos::gIntersection(hge_spoly2, cmap2)
#   if (!is.null(int))
#   {
#     #get area of intersection
#     ovr_area <- rgeos::gArea(int)
#   } else {
#     ovr_area <- 0
#   }
# 
#   #percent of hex cell that is covered by land
#   ovr_df$per_ovr[i] <- round(ovr_area / hex_area, 2)
# }


# import eBird species list -----------------------------------------------------

# # setwd(paste0(dir, 'Bird_Phenology/Data/'))

# setwd('Bird_Phenology/Data/')

setwd('/Volumes/TOSHIBA\ EXT/Data/')

# # species_list_i <- read.table('eBird_species_list.txt', stringsAsFactors = FALSE)

species_list_i <- read.table('eBird_species_list_Alva.txt', stringsAsFactors = FALSE)

species_list <- species_list_i[,1]
# #species_list <- 'Vireo_olivaceus'

# barswa
# species_list <- "Hirundo_rustica"

nsp <- length(species_list)
nyr <- length(years)


# Process halfmax results -----------------------------------------------------------------

setwd("Processed/")

# #get number of cell/years
tu_cells <- rep(NA, nsp)
for (i in 1:nsp)
{
  # #i <- 1
  
  # #import halfmax estimates and diagnostics from logit cubic model
  # # setwd(paste0(dir, 'Bird_Phenology/Data/Processed/', gam_dir))
  
  print(species_list[i])
  
  temp_arr_GAM <- readRDS(paste0('arrival_GAM_', species_list[i], '.rds'))

  # # if (!is.null(gam_dir2))
  # # {
  # #   setwd(paste0(dir, 'Bird_Phenology/Data/Processed/', gam_dir2))
  # #   
  # #   temp_arr_GAM2 <- readRDS(paste0('arrival_GAM_', species_list[i], '.rds'))
  # #   temp_arr_GAM <- rbind(temp_arr_GAM, temp_arr_GAM2)
  # # }
  tu_cells[i] <- length(unique(temp_arr_GAM$cell))
}



# # #reference key for species synonyms for ranges
# # setwd(paste0(dir, 'Bird_Phenology/Data/BirdLife_range_maps/metadata/'))
# # sp_key <- read.csv('species_filenames_key.csv')



counter <- 1
for (i in 1:nsp)
{
  # #i <- 1
  
  # #import halfmax estimates and diagnostics from GAM
  # # setwd(paste0(dir, 'Bird_Phenology/Data/Processed/', gam_dir))
  
  temp_arr_GAM <- readRDS(paste0('arrival_GAM_', species_list[i], '.rds'))
  
  # # if (!is.null(gam_dir2))
  # # {
  # #   setwd(paste0(dir, 'Bird_Phenology/Data/Processed/', gam_dir2))
  # #   temp_arr_GAM2 <- readRDS(paste0('arrival_GAM_', species_list[i], '.rds'))
  # #   temp_arr_GAM <- rbind(temp_arr_GAM, temp_arr_GAM2)
  # # }
  
  if (i == 1)
  {
    na_reps <- rep(NA, max(tu_cells) * nyr * nsp)
    
    diagnostics_frame <- data.frame(species = na_reps,
                                    year = na_reps,
                                    cell = na_reps,
                                    arr_GAM_hm_mean = na_reps,
                                    arr_GAM_hm_sd = na_reps,
                                    max_Rhat = na_reps,
                                    min_neff = na_reps,
                                    mlmax = na_reps,
                                    plmax = na_reps,
                                    num_diverge = na_reps,
                                    num_tree = na_reps,
                                    num_BFMI = na_reps,
                                    delta = na_reps,
                                    tree_depth = na_reps,
                                    t_iter = na_reps,
                                    n1 = na_reps,
                                    n1W = na_reps,
                                    n0 = na_reps,
                                    n0i = na_reps,
                                    njd = na_reps,
                                    njd1 = na_reps,
                                    njd0 = na_reps,
                                    njd0i = na_reps)
  }
  
  # #filter by breeding/migration cells
  # #match species name to shp file name
  # g_ind <- grep(species_list[i], sp_key$file_names_2016)
  # 
  # #check for synonyms if there are no matches
  # if (length(g_ind) == 0)
  # {
  #   g_ind2 <- grep(species_list[i], sp_key$BL_Checklist_name)
  # } else {
  #   g_ind2 <- g_ind
  # }
  
  # #change dir to shp files
  # setwd(paste0(dir, 'Bird_Phenology/Data/BirdLife_range_maps/shapefiles/'))
  # #get filename and read in
  # fname <- as.character(sp_key[g_ind2,]$filenames[grep('.shp', sp_key[g_ind2, 'filenames'])])
  # #read in shp file
  # sp_rng <- rgdal::readOGR(fname[1], verbose = FALSE)
  
  # #filter by breeding (2) and migration (4) range - need to convert spdf to sp
  # nrng <- sp_rng[which(sp_rng$SEASONAL == 2 | sp_rng$SEASONAL == 4),]
  
  # #filter by resident (1) and non-breeding (3) to exclude hex cells that contain 2/4 and 1/3
  # nrng_rm <- sp_rng[which(sp_rng$SEASONAL == 1 | sp_rng$SEASONAL == 3),]

  # #remove unneeded objects
  # rm(sp_rng)

  # #if there is a legitimate range
  # if (NROW(nrng@data) > 0 & raster::extent(nrng)@xmax > -95)
  # {
  #   #good cells
  #   nrng_sp <- sp::SpatialPolygons(nrng@polygons)
  #   sp::proj4string(nrng_sp) <- sp::CRS(sp::proj4string(nrng))
  #   #find intersections with code from here: https://gis.stackexchange.com/questions/140504/extracting-intersection-areas-in-r
  #   poly_int <- rgeos::gIntersects(hge, nrng_sp, byid = TRUE)
  #   tpoly <- which(poly_int == TRUE, arr.ind = TRUE)[,2]
  #   br_mig_cells <- hge_cells[as.numeric(tpoly[!duplicated(tpoly)])]
  # 
  #   #bad cells
  #   if (length(nrng_rm) > 0)
  #   {
  #     nrng_rm_sp <- sp::SpatialPolygons(nrng_rm@polygons)
  #     sp::proj4string(nrng_rm_sp) <- sp::CRS(sp::proj4string(nrng_rm))
  #     poly_int_rm <- rgeos::gIntersects(hge, nrng_rm_sp, byid = TRUE)
  #     tpoly_rm <- which(poly_int_rm == TRUE, arr.ind = TRUE)[,2]
  #     res_ovr_cells <- hge_cells[as.numeric(tpoly_rm[!duplicated(tpoly_rm)])]
  #     
  #     #remove cells that appear in resident and overwinter range that also appear in breeding range
  #     cell_mrg <- c(br_mig_cells, res_ovr_cells)
  #     to_rm <- c(cell_mrg[duplicated(cell_mrg)], 812, 813, 841)
  #     
  #     rm(nrng_rm)
  #     rm(nrng_rm_sp)
  #     rm(res_ovr_cells)
  #     
  #   } else {
  #     cell_mrg <- br_mig_cells
  #     to_rm <- c(812, 813, 841)
  #   }
  #   
  #   #remove unneeded objects
  #   rm(nrng)
  #   rm(nrng_sp)
  #   
  #   c_rm <- which(br_mig_cells %in% to_rm)
  #   if (length(c_rm) > 0)
  #   {
  #     overlap_cells <- br_mig_cells[-c_rm]  
  #   } else {
  #     overlap_cells <- br_mig_cells
  #   }
  #   
  #   #remove unneeded objects
  #   rm(br_mig_cells)
  #   rm(cell_mrg)
  #   rm(to_rm)
  #   
  #   #get cell centers
  #   cell_centers <- dggridR::dgSEQNUM_to_GEO(hexgrid6, overlap_cells)
  #   cc_df <- data.frame(cell = overlap_cells, lon = cell_centers$lon_deg, 
  #                       lat = cell_centers$lat_deg)
  #   
  #   #remove unneeded objects
  #   rm(cell_centers)
  #   rm(overlap_cells)
  #   
  #   cells <- cc_df$cell
  #   ncell <- length(cells)
  #   
  #   #remove unneeded objects
  #   rm(cc_df)
  # } else {
  #   ncell <- NA
  # }
  
  cells <- sort(unique(temp_arr_GAM$cell))
  
  ncell <- length(cells)
  
  #loop through years
  for (j in 1:nyr)
  {
    #j <- 17
    tt_arr1 <- dplyr::filter(temp_arr_GAM, 
                                 year == years[j])
    
    if (!is.na(ncell))
    {
      for (k in 1:ncell)
      {
        #k <- 1
        
        diagnostics_frame$species[counter] <- species_list[i]
        diagnostics_frame$year[counter] <- years[j]
        diagnostics_frame$cell[counter] <- cells[k]
        # diagnostics_frame$shp_fname[counter] <- fname[1]
        
        #get model fits
        tt_arr2 <- dplyr::filter(tt_arr1, 
                             cell == cells[k])
        
        print(paste0('species: ', species_list[i], ', ',
                     'year: ', years[j], ', ', 
                     'cell: ', cells[k]))
        
        if (NROW(tt_arr2) > 0)
        {
          diagnostics_frame$min_neff[counter] <- tt_arr2$min_neff
          diagnostics_frame$max_Rhat[counter] <- tt_arr2$max_Rhat
          #did mean have local max
          diagnostics_frame$mlmax[counter] <- tt_arr2$mlmax
          #percent of iter with local max
          diagnostics_frame$plmax[counter] <- tt_arr2$plmax
          diagnostics_frame$num_diverge[counter] <- tt_arr2$num_diverge
          diagnostics_frame$num_tree[counter] <- tt_arr2$num_tree
          diagnostics_frame$num_BFMI[counter] <- tt_arr2$num_BFMI
          diagnostics_frame$delta[counter] <- tt_arr2$delta
          diagnostics_frame$tree_depth[counter] <- tt_arr2$tree_depth
          #total iterations
          diagnostics_frame$t_iter[counter] <- tt_arr2$t_iter
          #number of surveys where species was detected
          diagnostics_frame$n1[counter] <- tt_arr2$n1
          #number of detections that came before jday 60
          diagnostics_frame$n1W[counter] <- tt_arr2$n1W
          #number of surveys where species was not detected
          diagnostics_frame$n0[counter] <- tt_arr2$n0
          #number of non-detections before first detection
          diagnostics_frame$n0i[counter] <- tt_arr2$n0i
          #number of julian days with obs
          diagnostics_frame$njd[counter] <- tt_arr2$njd
          #number of unique days with detections
          diagnostics_frame$njd1[counter] <- tt_arr2$njd1
          #number of unique days with non-detection
          diagnostics_frame$njd0[counter] <- tt_arr2$njd0
          #number of unique days of non-detections before first detection
          diagnostics_frame$njd0i[counter] <- tt_arr2$njd0i

          #posterior for halfmax
          cndf <- colnames(tt_arr2)
          hm_iter_ind <- grep('hm_iter', cndf)
          hm_posterior <- as.numeric(tt_arr2[,hm_iter_ind])

          #calculate posterior mean and sd
          if (sum(!is.na(hm_posterior)) > 0)
          {
            diagnostics_frame$arr_GAM_hm_mean[counter] <- mean(hm_posterior)
            diagnostics_frame$arr_GAM_hm_sd[counter] <- sd(hm_posterior)
          }
        }
        counter <- counter + 1
      } # if loop for at least one cell - species without sufficient ranges have 0 cells
    } # k -cell
  } # j - year
} # i - species


# strip excess NAs --------------------------------------------------------

if (sum(is.na(diagnostics_frame$species)) > 0)
{
  to.rm <- min(which(is.na(diagnostics_frame$species))):NROW(diagnostics_frame)
  diagnostics_frame2 <- diagnostics_frame[-to.rm,]
} else {
  diagnostics_frame2 <- diagnostics_frame
}


# combine data with overlap df --------------------------------------------

# diagnostics_frame3 <- dplyr::left_join(diagnostics_frame2, ovr_df, by = 'cell')

diagnostics_frame3 <- diagnostics_frame2


# filter by diagnostics ---------------------------------------------------

### not valid if any of the following conditions are met

# val_idx_hm <- which(diagnostics_frame3$num_diverge > 0 |
#                    diagnostics_frame3$max_Rhat >= 1.02 |
#                    diagnostics_frame3$min_neff < 400 |
#                    diagnostics_frame3$num_BFMI > 0 |
#                    diagnostics_frame3$arr_GAM_hm_sd > 15 |
#                    diagnostics_frame3$per_ovr < 0.05 | #land > 5% of cell
#                    diagnostics_frame3$plmax < 0.99 | #local max for > 99% of curves
#                    is.na(diagnostics_frame3$arr_GAM_hm_mean))

val_idx_hm <- which(diagnostics_frame3$num_diverge > 0 |
                      diagnostics_frame3$max_Rhat >= 1.02 |
                      diagnostics_frame3$min_neff < 400 |
                      diagnostics_frame3$num_BFMI > 0 |
                      diagnostics_frame3$arr_GAM_hm_sd > 15 |
                      diagnostics_frame3$plmax < 0.99 | #local max for > 99% of curves
                      is.na(diagnostics_frame3$arr_GAM_hm_mean))

diagnostics_frame3$VALID_hm <- TRUE
diagnostics_frame3$VALID_hm[val_idx_hm] <- FALSE


# Filter data based on criteria -----------------------------------------------------------

# Species-years to model:
#     Species with at least 'NC' cells in all three years for final three years
#     Species-years with at least 'NC' cells for those species

NC <- 3
diagnostics_frame3$MODEL_hm <- FALSE
df_out <- data.frame()
#which species/years meet criteria for model
for (i in 1:length(species_list))
{
    #i <- 1

    print(i)
    #filter by species
    t_sp <- dplyr::filter(diagnostics_frame3, species == species_list[i])

    if (NROW(t_sp) > 0)
    {
      #number of cells with good data in each year from last three years of data
      nobs_yr_hm <- c()
      for (j in tail(years, n = 3))
      {
        #j <- 2016
        ty_sp3 <- dplyr::filter(t_sp, year == j)
        ind_hm <- sum(ty_sp3$VALID_hm)
        nobs_yr_hm <- c(nobs_yr_hm, ind_hm)
      }

      #if all three years have greater than or = to 'NC' cells of data, figure
      #...out which years have at least 'NC' cells
      #HM
      yrs_kp_hm <- c()
      if (sum(nobs_yr_hm >= NC) == 3)
      {
        #see which years have more than 3 cells of data
        nobs_yr2_hm <- c()
        for (j in min(years):max(years))
        {
          #j <- 2002
          ty2_sp3_hm <- dplyr::filter(t_sp, year == j)
          ind2_hm <- sum(ty2_sp3_hm$VALID_hm)
          nobs_yr2_hm <- c(nobs_yr2_hm, ind2_hm)
        }

        #years to keep (more than three cells of data)
        yrs_kp_hm <- years[which(nobs_yr2_hm >= NC)]
      }

      if (length(yrs_kp_hm) > 0)
      {
        t_sp[which(t_sp$year %in% yrs_kp_hm),]$MODEL_hm <- TRUE
      }

      df_out <- rbind(df_out, t_sp)
    }
}
run_time <- (proc.time()[3] - tt[3]) / 60


# order -------------------------------------------------------------------

#order diagnostics frame by species, year, and cell #
df_master <- df_out[with(df_out, order(species, year, cell)),]


# write to RDS --------------------------------------------------

# # if (is.null(gam_date2))
# # {
# #   IAR_dir_path <- paste0(dir, 'Bird_phenology/Data/Processed/IAR_input_', gam_date)
# # } else {
# #   IAR_dir_path <- paste0(dir, 'Bird_phenology/Data/Processed/IAR_input_', gam_date2)
# # }

IAR_dir_path <- paste0('IAR_input_', gam_date)

dir.create(IAR_dir_path)
setwd(IAR_dir_path)

# # if (is.null(gam_date2))
# # {
# #   saveRDS(df_master, paste0('IAR_input-', gam_date, '.rds'))
# # } else {
# #   saveRDS(df_master, paste0('IAR_input-', gam_date2, '.rds'))
# # }

saveRDS(df_master, paste0('IAR_input-', gam_date, '.rds'))

write.csv(df_master, paste0('IAR_input-', gam_date, '.csv'), row.names = FALSE)




# proportion of range with >= 3 years of data --------------------------------------------

#species to model
species_agg <- aggregate(MODEL_hm ~ species, data = df_master, FUN = function(x) sum(x, na.rm = TRUE))
species_tm <- dplyr::filter(species_agg, MODEL_hm > 0)$species

#cells that will be modeled
mt_idx <- which(df_master$MODEL_hm == TRUE)
mt <- df_master[mt_idx,]
#cells with valid GAM data that will be modeled
tmvt_idx <- which(df_master$VALID_hm == TRUE & df_master$MODEL_hm == TRUE)
tmvt <- df_master[tmvt_idx,]

#number total cells
ntc <- aggregate(cell ~ species, mt, function(x) length(unique(x)))
#number obs each cell/species
cnt_csp <- plyr::count(tmvt, c('species', 'cell'))
#cells >=3 years data
ge3_csp <- dplyr::filter(cnt_csp, freq >= 3)
#number cells greater than or equal to 3
ncd <- aggregate(cell ~ species, ge3_csp, function(x) length(unique(x)))
#merge
jj <- dplyr::left_join(ntc, ncd, by = 'species')
#proportion cells with >= 3 data points
jj$pcd <- jj[,3] /  jj[,2]
colnames(jj) <- c('species', 'n_cells', 'n_cells_ge3', 'prop_cell_ge3')
tsid <- which(jj$prop_cell_ge3 > 0.4)

#priority 1
species_1 <- species_tm[tsid]
#priority 2
species_2 <- species_tm[-tsid]


# create list of species to run through IAR model -------------------------

# # setwd(paste0(dir, 'Bird_Phenology/Data/'))

# setwd('Bird_Phenology/Data/')

setwd('/Volumes/TOSHIBA\ EXT/Data/')

write.table(species_1, file = paste0('IAR_species_list_p1.txt'),
            row.names = FALSE, col.names = FALSE)

write.table(species_2, file = paste0('IAR_species_list_p2.txt'),
            row.names = FALSE, col.names = FALSE)