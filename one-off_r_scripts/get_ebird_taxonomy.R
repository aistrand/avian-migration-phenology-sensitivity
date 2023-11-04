library(auk)

setwd("~/Documents/OU/Research/data/eBird/ebd_output")

print(getwd())
# "/Users/alvastrand/Documents/OU/Research/data/eBird/ebd_output"

df_taxonomy <- get_ebird_taxonomy()

filename = "ebird_taxonomy.csv"

write.csv(df_taxonomy, file = filename, row.names = FALSE)