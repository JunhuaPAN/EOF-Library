#!/bin/bash

source /opt/openfoam5/etc/bashrc
export LD_LIBRARY_PATH=$FOAM_USER_LIBBIN:$LD_LIBRARY_PATH

ElmerGrid 2 2 mesh_Elmer -metis 2 -nooverwrite &> logElmerGrid.out
tail logElmerGrid.out

setFields &> logSetFields.out
tail logSetFields.out

decomposePar -force &> logDecomposePar.out
tail logDecomposePar.out

mpirun --allow-run-as-root -n 2 mhdInterFoam -parallel : -n 2 ElmerSolver_mpi &> logMhdInterFoam.out
tail -50 logMhdInterFoam.out
