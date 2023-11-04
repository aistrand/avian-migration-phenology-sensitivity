__author__ = 'Alva Strand'


import os
import sys
import time
import subprocess
from datetime import datetime


RUN_DATE = datetime.today().strftime('%Y-%m-%d')

ITER = '1500'

home_dir = '/home/aistrand/Bird_Phenology/'


path_to_folder = '/scratch/aistrand/Bird_Phenology/Data/Processed/arrival_GAM_{RUN_DATE}_{ITER}'.format(RUN_DATE=RUN_DATE, ITER=ITER)

os.makedirs(path_to_folder, exist_ok=True)
os.makedirs(path_to_folder + '/output_files', exist_ok=True)
os.makedirs(path_to_folder + '/error_log_files', exist_ok=True)

path_to_folder = home_dir + 'Scripts/2-arr-GAM/Processed/arrival_GAM_{RUN_DATE}_{ITER}'.format(RUN_DATE=RUN_DATE, ITER=ITER)

os.makedirs(path_to_folder, exist_ok=True)


def jobcount():

    """count the current cluster jobs"""
    return int(subprocess.check_output('squeue -u aistrand | wc', shell=1).split()[0])


def errmsg(msg):

    sys.stderr.write(msg + '\n')
    sys.stdout.flush()


def variable_list(filename):

    msg = 'Name of text file: ' + filename
    errmsg(msg)

    path_to_file = home_dir + 'Data/' + filename
    # path_to_file = '/Users/alvastrand/Bird_Phenology/Data/' + filename

    with open(path_to_file, 'r') as f:
        
        return [line.strip('\n') for line in f.readlines()]


def update_sbatch_script(scientific_name, cell, year):

    date_iter = RUN_DATE + '_' + ITER
    name_cell_year = scientific_name + '_' + cell + '_' + year

    path_to_file = home_dir + 'Scripts/2-arr-GAM/2-run_R_script.sh'
    # path_to_file = '/Users/alvastrand/Downloads/2-run_R_script.sh'
    path_to_new_file = home_dir + 'Scripts/2-arr-GAM/Processed/arrival_GAM_{RUN_DATE}_{ITER}/2-run_R_script_{RUN_DATE}_{ITER}.sh'.format(RUN_DATE=RUN_DATE, ITER=ITER)

    with open(path_to_file, 'r') as f:

        string = f.read()
        string = string.replace('REPLACE_THIS_NAME_CELL_YEAR', name_cell_year).replace('REPLACE_THIS_DATE_ITER', date_iter)

    with open(path_to_new_file, 'w') as w:

        w.write(string)

    return path_to_new_file


def submit_job(variable_list_element):

    species, scientific_name, cells, years = variable_list_element.split(',')

    script_name = update_sbatch_script(scientific_name, cells, years)

    command = 'sbatch {script_name} {RUN_DATE} {ITER} {species} {scientific_name} {cells} {years}'
    command = command.format(script_name=script_name, RUN_DATE=RUN_DATE, ITER=ITER, species=species, scientific_name=scientific_name, cells=cells, years=years)

    subprocess.call(command, shell=True)


def main():

    # Name of text file
    filename = sys.argv[1]

    list_of_variables = variable_list(filename)
    # print(len(list_of_variables))

    i = 0

    while i < len(list_of_variables):

        element = list_of_variables[i]
        job_count = jobcount()

        if job_count > 1400: #

            msg = 'There are {} jobs. Pausing for 1 min.'.format(job_count) #
            errmsg(msg)

            time.sleep(60)

        else:

            submit_job(element)

            i += 1


if __name__ == '__main__':

    main()