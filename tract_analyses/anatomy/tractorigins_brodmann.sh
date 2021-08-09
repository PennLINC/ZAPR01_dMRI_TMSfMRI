#!/bin/bash

#calculate overlap between left prefrontal tract endpoints and brodmann map 

ZAP=/storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI

3dresample -master /usr/local/fsl-5.0.11/data/standard/MNI152_T1_2mm_brain.nii.gz -inset $ZAP/templates/Brodmann/Brodmann_ICBM152.nii.gz -prefix $ZAP/templates/Brodmann/Brodmann_ICBM152-MNI-2mm.nii.gz 

antsApplyTransforms -d 3 -i $ZAP/templates/Brodmann/Brodmann_ICBM152-MNI-2mm.nii.gz -r $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FOD_Template_l0.nii.gz -o $ZAP/templates/Brodmann/Brodmann_ICBM152-inFODTemplate.nii.gz -n NearestNeighbor -t $ZAP/templates/FSL_HCP1065_FA_1.3mm-inFODTemplate1Warp.nii.gz -t $ZAP/templates/FSL_HCP1065_FA_1.3mm-inFODTemplate0GenericAffine.mat

3dROIstats -mask $ZAP/templates/Brodmann/Brodmann_ICBM152-inFODTemplate.nii.gz -nzvoxels $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/voxels/AmygdalaSOS-LHAmygdalaROI25-tracts-endpoints-vlPFC.nii.gz >>  $ZAP/output_measures/tract_endpoints_brodmann/Brodmann_areas.csv

