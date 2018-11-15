#!/usr/bin/env Rscript
library(ANTsR)
j=antsImageRead("/tmp/circAjacobian.nii.gz")
circ = antsImageRead( "circ1.nii.gz" )
circ2 = antsImageRead( "circ2.nii.gz" )
print( paste("Ratio Jacobian: " , ( sum( j[ circ == 1 ] / sum( circ == 1 ) ) )  ))
print( paste("Ratio Voxel Counts: ", sum(  sum( circ2 == 1 )/ sum( circ == 1 ) ) ) )
print( paste("Volume by jacobian", prod( antsGetSpacing( circ ) ) * sum( j[circ==1] ) ))
print( paste("Volume by counting voxels", prod( antsGetSpacing( circ ) )*sum(circ2==1)))

print("Resample the images and do the same test ( using registration in ANTsR):")
circ2r = resampleImage( circ2, 1.5 )
circ1r = resampleImage( circ, 0.5 )
myreg = antsRegistration( circ1r, circ2r, 'SyNOnly',
  synMetric = 'meansquares',
  regIterations = c( 100,100, 10 )    )
antsrjac = createJacobianDeterminantImage( circ1r, myreg$fwdtransforms[1] )
print( paste("Volume by jacobian", prod( antsGetSpacing( circ1r ) ) * sum( antsrjac[circ1r==1] ) ))
print( paste("Volume by counting voxels", prod( antsGetSpacing( circ2r ) )*sum(circ2r==1)))

print("In conclusion, the sum of the jacobian within the object in the template space -- multiplied by the product of the image spacing -- approximates the volume of the object within the moving image.  Assuming you have only applied the SyN transformation by itself.")
