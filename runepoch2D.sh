#!/bin/bash
#PBS -N 2D_pulsepro43
#PBS -l walltime=02:00:00
#PBS -l select=1:ncpus=20:mem=3200mb
#PBS -q pqplasma
#PBS -e /export111/work/jg1916/epoch_work/error.txt
#PBS -o /export111/work/jg1916/epoch_work/output.txt

# these are the names of the depositories
# First is the name of the job, which is laying in the GIT depository as the format <namdir>.deck, second the GIT depository
namdir=2D_pulseprop43
gitdep=$HOME/run_epoch

# the job is run in the WORK depository
cd $WORK/epoch_work/

# copies the input deck and makes the structure for EPOCH
mkdir $namdir
rm $namdir/*.sdf
cp $gitdep/$namdir.deck $namdir/input.deck

# run EPOCH
module load intel-suite
module load mpi
echo $namdir | mpirun $gitdep/bin/epoch2d > epochlog.txt

# copies the matlab function
cp $gitdep/plot_result.m $namdir/
cd $namdir/

# runs matlab
module load matlab
echo plot_result | matlab

# copies the input deck, output of matlab, log files and matlab function into the home directory
mkdir $gitdep/$namdir
cp input.deck $gitdep/$namdir/
cp deck.status $gitdep/$namdir/
cp plot_result.m $gitdep/$namdir/
rsync -r output/* $gitdep/$namdir/
cd ..
cp error.txt $gitdep/$namdir/
cp epochlog.txt $gitdep/$namdir/
cp output.txt $gitdep/$namdir/

