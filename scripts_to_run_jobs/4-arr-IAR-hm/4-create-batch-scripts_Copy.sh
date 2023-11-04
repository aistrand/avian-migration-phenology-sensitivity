#!/bin/bash

#
RUN_DATE="2022-05-13"

#
ITER="5000"

while read line
do
  scientific_name="${line%\"}"
  scientific_name="${scientific_name#\"}"
  echo "#!/bin/bash

#SBATCH --job-name=hm-${RUN_DATE}-${scientific_name}
#SBATCH --ntasks=1
#SBATCH --partition=longjobs
#SBATCH --mem=10G
#SBATCH --chdir=/scratch/aistrand/Bird_Phenology/Data/Processed/arrival_IAR_hm_${RUN_DATE}_${ITER}
#SBATCH --output=${scientific_name}-iar-hm_%J.out
#SBATCH --error=${scientific_name}-iar-hm_%J.err
#SBATCH --time=7-00:00:00

#echos name of node
echo \`hostname\`

module load R/4.0.2-foss-2020a

scientific_name=\$1
ITER=\$2
RUN_DATE=\$3

Rscript /home/aistrand/Bird_Phenology/Scripts/4-arr-IAR-hm/4-arr-IAR-hm_Copy_OSCER_3.R \$scientific_name \$ITER \$RUN_DATE

#displays amount of memory used
sstat --format=\"AveCPU,AvePages,AveRSS,MaxRSS,AveVMSize,MaxVMSize\" \$SLURM_JOBID.batch" > "species/4-${scientific_name}_Copy.sh"
done < /Volumes/TOSHIBA\ EXT/Data/IAR_species_list_Hirundo_rustica_Antrostomus_carolinensis.txt