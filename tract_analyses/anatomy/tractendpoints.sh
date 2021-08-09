#!/bin/bash

#Script to identify left prefrontal cortical voxels containing vlPFC-amygdala pathway endpoints

ZAP=/storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI

#map streamline endpoints to voxels, generating an endpoint TDI
tckmap $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/tractography/AmygdalaSOS-LHAmygdalaROI25-tracts.tck -template $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FOD_Template.mif -ends_only $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/voxels/AmygdalaSOS-LHAmygdalaROI25-tracts-endpoints.nii.gz

#binarize the endpoint TDI to create an endpoint voxel map
fslmaths $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/voxels/AmygdalaSOS-LHAmygdalaROI25-tracts-endpoints.nii.gz -bin $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/voxels/AmygdalaSOS-LHAmygdalaROI25-tracts-endpoints.nii.gz

#identify vlPFC endpoints only (remove amygdala endpoints)
fslmaths $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/voxels/AmygdalaSOS-LHAmygdalaROI25-tracts-endpoints.nii.gz -sub $ZAP/templates/ROIs/HarvardOxford-sub-maxprob-thr25-1mm-LHamygdala-inFODTemplate.nii.gz  $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/voxels/AmygdalaSOS-LHAmygdalaROI25-tracts-endpoints-vlPFC.nii.gz
fslmaths $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/voxels/AmygdalaSOS-LHAmygdalaROI25-tracts-endpoints-vlPFC.nii.gz -thr 0 $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/voxels/AmygdalaSOS-LHAmygdalaROI25-tracts-endpoints-vlPFC.nii.gz
fslmaths $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/voxels/AmygdalaSOS-LHAmygdalaROI25-tracts-endpoints-vlPFC.nii.gz -dilM $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/voxels/AmygdalaSOS-LHAmygdalaROI25-tracts-endpoints-vlPFC.nii.gz

