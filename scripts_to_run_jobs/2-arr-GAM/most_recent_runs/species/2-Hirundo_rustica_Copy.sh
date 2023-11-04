#!/bin/bash

# RUN_DATE="2021-11-16"

# ITER="1500"

#SBATCH --partition=normal # large_mem, debug
#SBATCH --ntasks=1 #
#SBATCH --mem=15G # 24G
#SBATCH --output=arr-GAM-Hirundo_rustica_%J.out # scientific_name? cells? years? output_files/?
#SBATCH --error=arr-GAM-Hirundo_rustica_%J.err # error_log_files/?
#SBATCH --time=24:00:00 #
#SBATCH --job-name=arr-GAM-Hirundo_rustica #
#SBATCH --chdir=/scratch/aistrand/Bird_Phenology/Data/Processed/arrival_GAM_2021-11-16_1500 # * RUN_DATE? ITER?

# Echo name of node
echo `hostname`

module load R/4.0.2-foss-2020a

RUN_DATE=$1
ITER=$2
species=$3
scientific_name=$4
cells=$5
years=$6

Rscript /home/aistrand/Bird_Phenology/Scripts/2-arr-GAM/2-arr-GAM_Copy_OSCER.R $RUN_DATE $ITER $species $scientific_name $cells $years

# Amount of memory used
sstat --format="AveCPU,AvePages,AveRSS,MaxRSS,AveVMSize,MaxVMSize" $SLURM_JOBID.batch #