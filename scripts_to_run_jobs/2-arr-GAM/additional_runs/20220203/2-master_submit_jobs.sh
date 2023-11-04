#!/bin/bash

RUN_DATE="2022-02-03"

ITER="1500"

# mkdir does not overwrite

mkdir /scratch/aistrand/Bird_Phenology/Data/Processed/arrival_GAM_${RUN_DATE}_${ITER}
mkdir /scratch/aistrand/Bird_Phenology/Data/Processed/arrival_GAM_${RUN_DATE}_${ITER}/output_files
mkdir /scratch/aistrand/Bird_Phenology/Data/Processed/arrival_GAM_${RUN_DATE}_${ITER}/error_log_files

sbatch /home/aistrand/Bird_Phenology/Scripts/2-arr-GAM/2-run_python_script.sh