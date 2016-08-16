#!/usr/bin/env Rscript
args<-commandArgs(TRUE)
library(ANTsR)
j=antsImageRead("/tmp/circAjacobian.nii.gz")
circ = antsImageRead( args[1] )
circ2 = antsImageRead( args[2])
if ( args[4] == 1 ) isinv = "Inverse" else isinv="Fwd"
print( paste( args[3], isinv ) )
doinv = args[4]
myjcalc = sum( j[ circ == 1 ] / sum( circ == 1 ) )
if ( doinv == 1 )
  myjcalc = sum( j[ circ2 == 1 ] / sum( circ2 == 1 ) )
print(paste("Jacobian-based ratio", myjcalc ) )
myscalc = sum(  sum( circ2 == 1 )/ sum( circ == 1 ) )
if ( doinv == 1 ) myscalc = 1.0 / myscalc
print(paste("Segmentation-based ratio", myscalc ) )
print( paste("%err", 100.0 * ( 1.0-myjcalc/myscalc ) ) )
