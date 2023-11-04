#!/bin/bash

# DATE="2021-10-21"

# ITER="10"

# mkdir /labs/Tingley/phenomismatch/Bird_Phenology/Data/Processed/arrival_GAM_$DATE

# mkdir /home/aistrand/Bird_Phenology/Data/Processed/arrival_GAM_$DATE_$ITER

# while read name
# do
#   temp="${name%\"}"
#   temp="${temp#\"}"
#   sbatch species/2-$temp.sh
# done < ../../Data/eBird_species_list.txt

name="Hirundo_rustica"

sbatch /home/aistrand/Bird_Phenology/Scripts/2-arr-GAM/species/2-$name_Copy.sh

# cp 2-arr-GAM.R ../../Data/Processed/arrival_GAM_$DATE/2-arr-GAM-$DATE.R