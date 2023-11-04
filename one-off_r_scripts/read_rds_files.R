getwd()

df_a_i <- read.csv(file = "aerial_insectivores_read_ebird_data_output_v2.R.csv")

print(nrow(df_a_i))

# head(a_i_df)

for (i in 1:nrow(df_a_i)) {
  
  species_code <- df_a_i[i, "species_code"]
  
  print(species_code)
  
  filename <- paste("botw_species/botw_", species_code, ".rds", sep = "")
  
  df_species <- readRDS(filename)
  
  print(nrow(df_species))
  
  if (i == 1) {
    break
  }
  
}