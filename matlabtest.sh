#!/bin/bash
#PBS -N 2D_pulseprop
#PBS -l walltime=00:15:00
#PBS -l select=4:ncpus=16:mem=3200mb
#PBS -q pqplasma
#PBS -e /export111/work/jg1916/laserpulse_Propagation/error_matalb.txt
#PBS -o /export111/work/jg1916/laserpulse_Propagation/output_matalb.txt

module load intel-suite
module load mpi

namdir=2D_pulseprop12

cd $WORK/laserpulse_Propagation/

mkdir $namdir
cp $namdir.deck $namdir/input.deck

cp plot_result.m $namdir/
cd $namdir/
module load matlab
echo plot_result | matlab
