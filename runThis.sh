nm=CIRC
f=circ1.nii.gz
m=circ2.nii.gz
dim=2
antsRegistration -d $dim \
                        -m meansquares[  $f, $m , 1 , 32 ] \
                         -t syn[ .15, 3, 0.0 ] \
                         -c [100x100x100,1.e-7,20]  \
                        -s 2x1x0vox  \
                        -f 4x2x1 -l 1 -u 1 -z 1 \
                       -o [${nm},${nm}_diff.nii.gz,${nm}_inv.nii.gz]
ANTSJacobian 2 CIRC0Warp.nii.gz /tmp/circA 0 0 0
./rcalc.R
# compare to
CreateJacobianDeterminantImage 2 CIRC0Warp.nii.gz /tmp/circAjacobian.nii.gz 0 0
./rcalc.R
CreateJacobianDeterminantImage 2 CIRC0Warp.nii.gz /tmp/circAjacobian.nii.gz 0 1
./rcalc.R
