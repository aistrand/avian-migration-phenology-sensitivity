setwd("/Users/alvastrand")

path <- "Downloads/MigSen_arc/Data/"



filename <- paste0(path, "data_arr.RDS")

df <- readRDS(filename)

nrow(df)

View(df)

filename <- "data_arr.csv"

write.csv(df, paste0("Downloads/", filename), row.names = FALSE)



df_species <- df[,c("sci_name", "species")]

nrow(df_species)

df_species_deduplicated <- df_species[!duplicated(df_species), ]

nrow(df_species_deduplicated)

View(df_species_deduplicated)

filename <- "species_names_Casey.csv"

write.csv(df_species_deduplicated, paste0("Downloads/", filename), row.names = FALSE)



filename <- paste0(path, "data_sensi.RDS")

df <- readRDS(filename)

nrow(df)

View(df)

filename <- "data_sensi.csv"

write.csv(df, paste0("Downloads/", filename), row.names = FALSE)



filename <- paste0(path, "fit_df_tab5.rds")

df <- readRDS(filename)

nrow(df)

View(df)



filename <- paste0(path, "fit_df_tab6.rds")

df <- readRDS(filename)

nrow(df)

View(df)



filename <- paste0(path, "for_green-up_dl.rds")

df <- readRDS(filename)

nrow(df)

View(df)



filename <- paste0(path, "master_cell_grid.rds")

df <- readRDS(filename)

nrow(df)

View(df)



filename <- paste0(path, "MidGreenup_2020-08-06-forest.rds")

df <- readRDS(filename)

nrow(df)

View(df)



filename <- paste0(path, "mrg2_xi_PC.rds")

df <- readRDS(filename)

nrow(df)

View(df)