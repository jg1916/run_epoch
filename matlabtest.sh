#!/bin/bash
#PBS -N 2D_pulseprop19
#PBS -l walltime=02:00:00
#PBS -l select=4:ncpus=20:mem=3200mb
#PBS -q pqplasma
#PBS -e /export111/work/jg1916/laserpulse_Propagation/error_matalb.txt
#PBS -o /export111/work/jg1916/laserpulse_Propagation/output_matalb.txt

# these are the names of the depositories
# First is the name of the job, which is laying in the GIT depository as the format <namdir>.deck, second the GIT depository
namdir=2D_pulseprop19
gitdep=$HOME/run_epoch

# the job is run in the WORK depository
cd $WORK/epoch_work/

# copies the matlab function
cp $gitdep/plot_result.m $namdir/
cd $namdir/

# runs matlab
module load matlab
echo plot_result | matlab

# copies the input deck, output of matlab, log files and matlab function into the home directory
cp plot_result.m $gitdep/$namdir/
rsync -r output/* $gitdep/$namdir/
