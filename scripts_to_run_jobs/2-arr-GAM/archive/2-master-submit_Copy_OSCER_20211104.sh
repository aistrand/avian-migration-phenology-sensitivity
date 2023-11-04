#!/bin/bash

RUN_DATE="2021-11-04"

ITER="1500"

# mkdir does not overwrite

# mkdir /scratch/aistrand/Bird_Phenology/Data/Processed/arrival_GAM_${RUN_DATE}_${ITER}
# mkdir /scratch/aistrand/Bird_Phenology/Data/Processed/arrival_GAM_${RUN_DATE}_${ITER}/output_files
# mkdir /scratch/aistrand/Bird_Phenology/Data/Processed/arrival_GAM_${RUN_DATE}_${ITER}/error_log_files

while read line
do
  species=$(echo ${line} | awk -F"," '{print $1}')
  scientific_name=$(echo ${line} | awk -F"," '{print $2}')
  cells=$(echo ${line} | awk -F"," '{print $3}')
  years=$(echo ${line} | awk -F"," '{print $4}')
  echo ${species}, ${scientific_name}, ${cells}, ${years}
  sbatch /home/aistrand/Bird_Phenology/Scripts/2-arr-GAM/species/2-${scientific_name}_Copy.sh $RUN_DATE $ITER $species $scientific_name $cells $years
# done < /home/aistrand/Bird_Phenology/Data/barswa_cells_years_2.txt
# done < /home/aistrand/Bird_Phenology/Data/barswa_cells_years_100_excluding_2.txt
done < /home/aistrand/Bird_Phenology/Data/barswa_cells_years_last_100_excluding_1.txt

# done < /home/aistrand/Bird_Phenology/Data/barswa_cells_years_1500.txt
# done < /home/aistrand/Bird_Phenology/Data/barswa_cells_years.txt

# done < /Users/alvastrand/Bird_Phenology/Data/barswa_cells_years_2.txt

# species="barswa"
# scientific_name="Hirundo_rustica"
# cells="120"
# years="2019"

# echo ${species}, ${scientific_name}, ${cells}, ${years}

# sbatch /home/aistrand/Bird_Phenology/Scripts/2-arr-GAM/species/2-${scientific_name}_Copy.sh $RUN_DATE $ITER $species $scientific_name $cells $years