#!/bin/bash

foamCleanTutorials
rm -rf 0 > /dev/null 2>&1
cp -r 0_org 0 > /dev/null 2>&1

fluent3DMeshToFoam ./mesh/ascii.cas | tee log.fluenttofoam

#checkMesh | tee log.cm

decomposePar
mpirun -np 4 renumberMesh -parallel -overwrite | tee log.renumber
mpirun -np 4 potentialFoam -noFunctionObjects -parallel | tee log.potential
mpirun -np 4 simpleFoam -parallel | tee log.solver 
