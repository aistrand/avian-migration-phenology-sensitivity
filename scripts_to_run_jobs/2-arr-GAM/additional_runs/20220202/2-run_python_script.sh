#!/bin/bash

# 2022-02-02

# 1500

#SBATCH --partition=normal #longjobs
#SBATCH --ntasks=1 #
#SBATCH --mem=1G #
#SBATCH --output=arr-GAM-%J.out # output_files/
#SBATCH --error=arr-GAM-%J.err # error_log_files/
#SBATCH --time=24:00:00 #
#SBATCH --job-name=arr-GAM #
#SBATCH --chdir=/scratch/aistrand/Bird_Phenology/Data/Processed/arrival_GAM_2022-02-02_1500 #

# filename=$1
filename='banswa_cells_years_last_178.txt'

module load Python/3.9.5-GCCcore-10.3.0

python /home/aistrand/Bird_Phenology/Scripts/2-arr-GAM/2-submit_jobs.py $filename