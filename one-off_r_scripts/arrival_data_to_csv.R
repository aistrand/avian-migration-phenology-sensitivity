arr_date <- '2022-05-13'

setwd(paste0('/Volumes/TOSHIBA\ EXT/Data/Processed/arrival_master_', arr_date, '_5000'))

arr_master <- readRDS(paste0('arrival_master_', arr_date, '.rds'))

filename <- paste0('arrival_master_', arr_date, '.csv')

write.csv(arr_master, paste0(filename), row.names = FALSE)