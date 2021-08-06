#!/bin/bash

#calculate overlap between left prefrontal tract endpoints and brodmann map 

ZAP=/storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI

3dresample -master /usr/local/fsl-5.0.11/data/standard/MNI152_T1_2mm_brain.nii.gz -inset $ZAP/templates/Brodmann/Brodmann_ICBM152.nii.gz -prefix $ZAP/templates/Brodmann/Brodmann_ICBM152-MNI-2mm.nii.gz 

3dROIstats -mask $ZAP/templates/Brodmann/Brodmann_ICBM152-MNI-2mm.nii.gz -nzvoxels $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/voxels/AmygdalaSOS-LHAmygdalaROI25-tracts-endpoints-vlPFC-inMNIspace.nii.gz  >> $ZAP/output_measures/tract_endpoints_brodmann/Brodmann_areas.csv
