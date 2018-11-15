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


print("Resample the images and compute volumes ( using registration in ANTsR):")
circ2r = resampleImage( circ2, 1.5 )
circ1r = resampleImage( circ, 0.5 )
myreg = antsRegistration( circ1r, circ2r, 'SyNOnly',
  synMetric = 'meansquares',
  regIterations = c( 100,100, 10 )    )
antsrjac = createJacobianDeterminantImage( circ1r, myreg$fwdtransforms[1] )
print( paste("Volume by jacobian", prod( antsGetSpacing( circ1r ) ) * sum( antsrjac[circ1r==1] ) ))
print( paste("Volume by counting voxels", prod( antsGetSpacing( circ2r ) )*sum(circ2r==1)))

print("In conclusion, the sum of the jacobian within the object in the template space -- multiplied by the product of the image spacing -- approximates the volume of the object within the moving image.  Assuming you have only applied the SyN transformation by itself.")
