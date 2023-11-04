#!/bin/bash

#
RUN_DATE="2022-05-13"

#
ITER="5000"

# If folders do not exist, ...

mkdir /scratch/aistrand/Bird_Phenology/Data/Processed/arrival_IAR_hm_${RUN_DATE}_${ITER}
mkdir /scratch/aistrand/Bird_Phenology/Data/Processed/arrival_IAR_hm_${RUN_DATE}_${ITER}/output_files
mkdir /scratch/aistrand/Bird_Phenology/Data/Processed/arrival_IAR_hm_${RUN_DATE}_${ITER}/error_log_files

# scientific_name="Antrostomus_carolinensis"

# echo $scientific_name, $ITER

# sbatch /home/aistrand/Bird_Phenology/Scripts/4-arr-IAR-hm/species/4-${scientific_name}_Copy.sh $scientific_name $ITER $RUN_DATE

while read line
do
  scientific_name="${line%\"}"
  scientific_name="${scientific_name#\"}"
  echo $line, $scientific_name, $ITER
  sbatch /home/aistrand/Bird_Phenology/Scripts/4-arr-IAR-hm/species/4-${scientific_name}_Copy.sh $scientific_name $ITER $RUN_DATE
done < /home/aistrand/Bird_Phenology/Data/IAR_species_list_Hirundo_rustica_Antrostomus_carolinensis.txt