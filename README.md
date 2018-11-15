# jacobianTests
very basic test of jacobian
should get a value around 2.14

the rcalc.R compares the following values:

* the ratio of volumes

* the estimated volumes

with both jacobian and direct use of segmentations along with image spacing.


From the ants pdf documentation at [https://github.com/stnava/ANTsDoc](https://github.com/stnava/ANTsDoc):

Figure 7: Digital invertibility presents some limitations. Here, we see that invertibility is not exact but is gained only by interpolation. Thus, in three-dimensional scenarios in particular, there are fundamental limits to the degree of invertibility that may be achieved. The second and third voxels – from left – in image A undergo an expansion by a factor of 2. That is, under the mapping, 2 voxels are mapped to 4. This gives the definition of the Jacobian – computed by ANTsJacobian – which is a unitless measure defined by the ratio of volumes. Thus, J (x) = V (phi(x))/V (x) where V represents the volume operation and x, here, may be a small object. Thus, if phi – the mapping – causes expansion, then J (x) > 1.  In this example phi( x ) is the warp defined in the fixed image space e.g.  myOutputWarp.nii.gz

See also Figure 21 and 22.

# to run the jacobianTests

from within the repo do:

```
bash runThis.sh
```
