#!/bin/bash

# 2022-02-05

# 1500

#SBATCH --partition=all # longjobs
#SBATCH --ntasks=1 #
#SBATCH --mem=1G #
#SBATCH --output=arr-GAM-%J.out # output_files/
#SBATCH --error=arr-GAM-%J.err # error_log_files/
#SBATCH --time=48:00:00 # 7-00:00:00?
#SBATCH --job-name=arr-GAM #
#SBATCH --chdir=/scratch/aistrand/Bird_Phenology/Data/Processed/arrival_GAM_2022-02-05_1500 #

# filename='banswa_cells_years_last_178.txt'
filename='all_species_barswa_banswa_cells_years.txt'

# file_index='8209'
file_index='8211'

module load Python/3.9.5-GCCcore-10.3.0

python /home/aistrand/Bird_Phenology/Scripts/2-arr-GAM/2-submit_jobs.py $filename $file_index