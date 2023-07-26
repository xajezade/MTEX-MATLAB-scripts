#!/bin/bash
#SBATCH --time=3-00:00
#SBATCH --cpus-per-task=32
#SBATCH --mem-per-cpu=4000M
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
neper -T -n from_morpho::from_morpho -dim 2 -domain "square(2048,2048)" -morpho "square(8)::diameq:lognormal(2.66,1.132),1-sphericity:lognormal(0.145,0.03)" -morphooptistop "::eps=0.001,val=0.001" -morphooptialgo "::praxis" -o 2DBigRandom  -format tess,ori -statface nfaces_samedomain
