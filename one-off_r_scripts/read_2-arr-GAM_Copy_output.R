# setwd("/Users/alvastrand")

# path <- "Bird_Phenology/Data/Processed/"

# folder <- "arrival_GAM_2021-11-04_1500/"



setwd("/Volumes/")

# path <- "TOSHIBA\ EXT/Data/Processed/consolidated/"

# folder <- "arrival_GAM_2021-11-16_1500/barswa/"

# folder <- "arrival_GAM_2022-02-02_1500/banswa/"

# folder <- "arrival_GAM_2022-02-05_1500/chiswi/"

path <- "TOSHIBA\ EXT/Data/Processed/"

# folder <- "arrival_GAM_2022-02-03_1500/chwwid/"

# folder <- "arrival_GAM_2022-02-03_1500/comnig/"

# folder <- "arrival_GAM_2022-02-03_1500/lesnig/"

# folder <- "arrival_GAM_2022-02-03_1500/whip-p1/"

# folder <- "arrival_GAM_2022-02-05_1500/cavswa/"

# folder <- "arrival_GAM_2022-02-05_1500/cliswa/"

# folder <- "arrival_GAM_2022-02-05_1500/nrwswa/"

# folder <- "arrival_GAM_2022-02-05_1500/purmar/"

# folder <- "arrival_GAM_2022-02-05_1500/treswa/"

# folder <- "arrival_GAM_2022-02-05_1500/vauswi/"

folder <- "arrival_GAM_2022-02-05_1500/vigswa/"



list_files <- list.files(path = paste0(path, folder))

cnt <- 1

for (filename in list_files){
  
  if (grepl(".rds", filename, fixed = TRUE) == TRUE){
  
    print(cnt)
    
    df <- readRDS(paste0(path, folder, filename))
    
    if (cnt == 1){
      df_all <- df
    }
    
    else {
      df_all <- rbind(df_all, df)
    }
    
    cnt <- cnt + 1
    
  }
  
}

# folder <- "arrival_GAM_2021-11-16_1500/"
# 
# list_files <- list.files(path = paste0(path, folder))
# 
# for (filename in list_files){
#   
#   # print(cnt)
#   
#   df <- readRDS(paste0(path, folder, filename))
#   
#   df_all <- rbind(df_all, df)
#   
#   cnt <- cnt + 1
#   
# }

print(nrow(df_all))

# barswa
# filename <- 'arrival_GAM_Hirundo_rustica.rds'

# banswa
# filename <- 'arrival_GAM_Riparia_riparia.rds'

# chiswi
# filename <- 'arrival_GAM_Chaetura_pelagica.rds'

# chwwid
# filename <- 'arrival_GAM_Antrostomus_carolinensis.rds'

# comnig
# filename <- 'arrival_GAM_Chordeiles_minor.rds'

# lesnig
# filename <- 'arrival_GAM_Chordeiles_acutipennis.rds'

# whip-p1
# filename <- 'arrival_GAM_Antrostomus_vociferus.rds'

# cavswa
# filename <- 'arrival_GAM_Petrochelidon_fulva.rds'

# cliswa
# filename <- 'arrival_GAM_Petrochelidon_pyrrhonota.rds'

# nrwswa
# filename <- 'arrival_GAM_Stelgidopteryx_serripennis.rds'

# purmar
# filename <- 'arrival_GAM_Progne_subis.rds'

# treswa
# filename <- 'arrival_GAM_Tachycineta_bicolor.rds'

# vauswi
# filename <- 'arrival_GAM_Chaetura_vauxi.rds'

# vigswa
filename <- 'arrival_GAM_Tachycineta_thalassina.rds'

saveRDS(df_all, paste0(path, filename))



# filename <- 'arrival_GAM_Hirundo_rustica.csv'

# write.csv(df_all, paste0(path, filename), row.names = FALSE)



# filename <- "Bird_Phenology/Data/Processed/arrival_GAM_Hirundo_rustica.rds"

# filename <- "Bird_Phenology/Data/Processed/arrival_GAM_2021-08-19/arrival_GAM_Hirundo_rustica.rds"



# filename <- paste0(path, folder, "arrival_GAM_Hirundo_rustica_2002_5.rds")



# filename <- "Bird_Phenology/Data/output_files/arrival_GAM_Hirundo_rustica_2002_87.rds"

# filename <- "Bird_Phenology/Data/output_files/arrival_GAM_Hirundo_rustica_2002_120.rds"

# filename <- "Bird_Phenology/Data/output_files/arrival_GAM_Hirundo_rustica_2019_120.rds"



path <- "Bird_Phenology/20220107/Data/"

folder <- "arrival_GAM_2021-11-04_1500/"

filename <- paste0(path, folder, "arrival_GAM_Hirundo_rustica_2002_5.rds")

df <- readRDS(filename)

View(df)