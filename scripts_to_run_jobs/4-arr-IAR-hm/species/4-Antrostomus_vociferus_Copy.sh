#!/bin/bash

#SBATCH --job-name=hm-2022-05-13-Antrostomus_vociferus
#SBATCH --ntasks=1
#SBATCH --partition=longjobs
#SBATCH --mem=10G
#SBATCH --chdir=/scratch/aistrand/Bird_Phenology/Data/Processed/arrival_IAR_hm_2022-05-13_5000
#SBATCH --output=Antrostomus_vociferus-iar-hm_%J.out
#SBATCH --error=Antrostomus_vociferus-iar-hm_%J.err
#SBATCH --time=7-00:00:00

#echos name of node
echo `hostname`

module load R/4.0.2-foss-2020a

scientific_name=$1
ITER=$2
RUN_DATE=$3

Rscript /home/aistrand/Bird_Phenology/Scripts/4-arr-IAR-hm/4-arr-IAR-hm_Copy_OSCER_3.R $scientific_name $ITER $RUN_DATE

#displays amount of memory used
sstat --format="AveCPU,AvePages,AveRSS,MaxRSS,AveVMSize,MaxVMSize" $SLURM_JOBID.batch
