#!/bin/bash
#SBATCH --time=3-00:00
#SBATCH --cpus-per-task=48
#SBATCH --mem-per-cpu=4000M
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
neper -T -dim 2 -domain "square(1024,1024)" -n from_morpho -morpho "lamellar(w=11.76,v=(0,1,0))" -statcell mode -statseed x,y -o lam
lamqty=`wc -l lam.stseed | awk '{print $1}'`
neper -T -dim 2 -id 1 -domain "square(1024,1024)" -n $lamqty -morpho "diameq:0.41*lognormal(98.4,27.36,from=45)+0.59*lognormal(98.4,27.36,from=45)" -tesrsize "2048:2048" -statcell mode -for vtk,tess,tesr -morphooptidof y -morphooptigrid "diameq:regular(-1,150,1100)" -morphooptiini "coo:file(lam.stseed)" -o 2DScale1
awk '{if ($1==1) {print NR,"diameq:lognormal(2.66,1.65),1-sphericity:lognormal(0.1,0.03)"} else {print NR,"diameq:lognormal(2.06,1.42),1-sphericity:lognormal(0.1,0.03)"}}' 2DScale1.stcell > scale2-morpho
neper -T -dim 2 -id 1::1 -domain "square(1024,1024)" -n $lamqty::from_morpho -morphooptiini "coo:file(2DScale1.tess),weight:file(2DScale1.tess)" -morpho "::file(scale2-morpho)" -morphooptistop "::eps=1e-4" -tesrsize 4096:4096 -o scale2 -tesrformat "binary32" -format raw,tess,tesr,vtk -statface nfaces_samedomain
