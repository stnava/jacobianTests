nm=CIRC
echo "#### start with 2D with neg header"
for x in 0 1 2 ; do
  f=circ1.nii.gz
  m=circ2.nii.gz
  dim=2
  if [[ $x -gt 0 ]] ; then dim=3; fi
  if [[ $x == 1 ]] ; then
    echo "#### now 3D with identity header"
    f=sphere1Rad11.nii.gz
    m=sphere1Rad13.nii.gz
  fi
  if [[ $x == 2 ]] ; then
    echo "#### now 3D with neg header"
    f=sphere1negheaderRad11.nii.gz
    m=sphere1negheaderRad13.nii.gz
  fi
  echo $f
  # demons metric is very "aggressive" in terms of matching level sets
  antsRegistration -d $dim \
                          -m demons[  $f, $m ] \
                           -t syn[ 0.10, 3, 0.0 ] \
                           -c [100x100x100,1.e-8,20]  \
                          -s 2x1x0vox  \
                          -f 4x2x1 -l 1 -u 1 -z 1 \
                         -o [${nm},${nm}_diff.nii.gz,${nm}_inv.nii.gz]
#  ANTSJacobian $dim CIRC0Warp.nii.gz /tmp/circA 0 0 0
#  ./rcalc.R $f $m
  # compare to
  CreateJacobianDeterminantImage $dim CIRC0Warp.nii.gz /tmp/circAjacobian.nii.gz 0 0
  ./rcalc.R $f $m finiteDiff 0
  CreateJacobianDeterminantImage $dim CIRC0Warp.nii.gz /tmp/circAjacobian.nii.gz 0 1
  ./rcalc.R $f $m geometric  0
  CreateJacobianDeterminantImage $dim CIRC0InverseWarp.nii.gz /tmp/circAjacobian.nii.gz 0 0
  ./rcalc.R $f $m finiteDiff 1
  CreateJacobianDeterminantImage $dim CIRC0InverseWarp.nii.gz /tmp/circAjacobian.nii.gz 0 1
  ./rcalc.R $f $m geometric  1
done
