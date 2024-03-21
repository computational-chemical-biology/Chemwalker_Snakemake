#!/bin/bash  -v
#SBATCH --partition=SP2
#SBATCH --ntasks=5              # number of tasks / mpi processes
#SBATCH --cpus-per-task=20       # Number OpenMP Threads per process
#SBATCH -J chw 
#SBATCH --time=192:00:00         # Se voce nao especificar, o default é 8 horas. O limite é 480 horas

#OpenMP settings:
export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export OMP_PLACES=threads
export OMP_PROC_BIND=spread

echo $SLURM_JOB_ID              #ID of job allocation
echo $SLURM_SUBMIT_DIR          #Directory job where was submitted
echo $SLURM_JOB_NODELIST        #File containing allocated hostnames
echo $SLURM_NTASKS              #Total number of cores for job

#Carregar modulos necessarios ("module avail" listará o que está disponível para o compilador selecionado)


export PATH=/scratch/6293113/miniconda3/bin/:$PATH
source ~/.bashrc
cd /scratch/6293113/Chemwalker_workflow/
conda activate chemwalker
snakemake --cores all --keep-going
