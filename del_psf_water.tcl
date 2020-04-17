mol new ionized.psf type psf first 0 last -1 step 1 waitfor all
mol addfile ionized.pdb type pdb first 0 last -1 step 1 waitfor all

set badwater [atomselect top "water and name OH2"]
set badion [atomselect top "ion"]
set badprotein [atomselect top "protein and name CA"]

#############################
package require psfgen



readpsf ionized.psf
coordpdb ionized.pdb

foreach segid [$badwater get segid] resid [$badwater get resid] {
    delatom $segid $resid
}

foreach segid [$badion get segid] resid [$badion get resid] {
    delatom $segid $resid
}

writepsf complex_no_water.psf


############################
resetpsf
psfcontext reset

readpsf ionized.psf
coordpdb ionized.pdb

foreach segid [$badwater get segid] resid [$badwater get resid] {
    delatom $segid $resid
}

foreach segid [$badion get segid] resid [$badion get resid] {
    delatom $segid $resid
}

foreach segid [$badwater get segid] resid [$badwater get resid] {
    delatom $segid $resid
}

writepsf drug_no_water.psf


############################
resetpsf
psfcontext reset

readpsf ionized.psf
coordpdb ionized.pdb

foreach segid [$badwater get segid] resid [$badwater get resid] {
    delatom $segid $resid
}

foreach segid [$badion get segid] resid [$badion get resid] {
    delatom $segid $resid
}

delatom X 1

writepsf protein_no_water.psf

exit;

