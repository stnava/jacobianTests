#!/usr/bin/env Rscript
library(ANTsR)
j=antsImageRead("/tmp/circAjacobian.nii.gz")
circ = antsImageRead( "circ1.nii.gz" )
circ2 = antsImageRead( "circ2.nii.gz" )
print(( sum( j[ circ == 1 ] / sum( circ == 1 ) ) ) )
print( sum(  sum( circ2 == 1 )/ sum( circ == 1 ) ) )

