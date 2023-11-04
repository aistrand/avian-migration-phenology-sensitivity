#!/bin/bash

#SBATCH --partition=normal #partition - can also specify 'large_mem' # debug
#SBATCH --ntasks=1 #number of tasks
#SBATCH --mem=1G #memory requested # 1G
#SBATCH --output=arr-GAM-Hirundo_rustica_%J.out #STDOUT #DATE #ITER
#SBATCH --error=arr-GAM-Hirundo_rustica_%J.err #STDERR #DATE #ITER
#SBATCH --time=24:00:00
#SBATCH --job-name=arr-GAM-Hirundo_rustica
#SBATCH --chdir=/home/aistrand/Bird_Phenology/Data/Processed/arrival_GAM_2021-10-21_10

# echos name of node
echo `hostname`

# module load gcc/6.4.0

# module load GCC/10.3.0
# module load GCC

# module load singularity/3.0.2

# module load Rstudio-singularity/3.6.2
# module load Rstudio-singularity

module load R/4.0.2-foss-2020a

# singularity exec -B /labs/Tingley -B /UCHC /isg/shared/apps/R/3.5.2/R.sif Rscript /labs/Tingley/phenomismatch/Bird_Phenology/Scripts/2-arr-GAM/2-arr-GAM.R Hirundo_rustica 2002 2017

# Rscript /labs/Tingley/phenomismatch/Bird_Phenology/Scripts/2-arr-GAM/2-arr-GAM.R Hirundo_rustica 2002 2017

Rscript /home/aistrand/Bird_Phenology/Scripts/2-arr-GAM/2-arr-GAM_Copy_OSCER.R

# displays amount of memory used
sstat --format="AveCPU,AvePages,AveRSS,MaxRSS,AveVMSize,MaxVMSize" $SLURM_JOBID.batch