# ChemWalker Snakemake workflow

This workflow allows the use of [ChemWalker](https://github.com/computational-chemical-biology/ChemWalker) on HPC. A slurm job example is provided as an example of parallel job.


## Installation

Install conda

```
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh

```
   
Create a dedicated conda environment and activate

```
git clone https://github.com/computational-chemical-biology/ChemWalker.git
cd ChemWalker
conda env create -f environment.yml
conda activate chemwalker 
pip install snakemake
```

Make sure to change the command line interface before installing ChemWalker

```
cp ../network_walk bin/
python setup install
```

## Run

Change the parameters on [config](config.yaml) to adapt the run for your data.

You can test the setup running a dry run with 


```
snakemake -n
```

If everything is ok with your installation you should see a list of jobs to run. You can processed doing

```
snakemake --cores all --keep-going
```
