#!/bin/bash

#Map tractography streamlines to voxels for visualization

ZAP=/storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI
mkdir $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/voxels

#map streamlines to voxels with TDI contrast
/storage/3Tissue/bin/tckmap $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/tractography/AmygdalaSOS-LHAmygdalaROI25-tracts.tck -template $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FOD_Template.mif -contrast tdi $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/voxels/AmygdalaSOS-LHAmygdalaROI25-tractvoxels-tdi.nii.gz

#binarize the TDI to get a tract voxel map
fslmaths $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/voxels/AmygdalaSOS-LHAmygdalaROI25-tractvoxels-tdi.nii.gz -bin $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/voxels/AmygdalaSOS-LHAmygdalaROI25-tractvoxels-bin.nii.gz

#transform tract voxel maps to MNI space 
antsApplyTransforms -d 3 -i $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/voxels/AmygdalaSOS-LHAmygdalaROI25-tractvoxels-bin.nii.gz -r /usr/local/fsl/data/standard/MNI152_T1_1mm_brain.nii.gz -o $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/voxels/AmygdalaSOS-LHAmygdalaROI25-tractvoxels-bin-inMNIspace.nii.gz -n NearestNeighbor -t [$ZAP/templates/FSL_HCP1065_FA_1.3mm-inFODTemplate0GenericAffine.mat,1] -t $ZAP/templates/FSL_HCP1065_FA_1.3mm-inFODTemplateInverseWarped.nii.gz 

