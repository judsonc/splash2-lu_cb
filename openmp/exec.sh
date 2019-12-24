#!/bin/bash
#SBATCH --exclusive
#SBATCH --time=0-0:10
#SBATCH --hint=compute_bound
#SBATCH --job-name=lu_opemp
#SBATCH --output=slurm-8192-4.txt

./lu -n8192 -p4 -b16 -t