#!/bin/bash

#Visualize any streamlines connecting the sgACC TMS Sites of Stimulation Study Mask to the LH sgACC
#Note, 0 streamlines were extracted

ZAP=/storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI

antsApplyTransforms -d 3 -i $ZAP/templates/ROIs/ListonSG.nii.gz -r $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FOD_Template_l0.nii.gz -o $ZAP/templates/ROIs/ListonSG-inFODTemplate.nii.gz -n NearestNeighbor -t $ZAP/templates/FSL_HCP1065_FA_1.3mm-inFODTemplate1Warp.nii.gz -t $ZAP/templates/FSL_HCP1065_FA_1.3mm-inFODTemplate0GenericAffine.mat

/storage/3Tissue/bin/tckedit $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FOD_Template_Tractography.tck -include $ZAP/sites_of_stim/sgACC-SitesofStimulation-StudyMask-inFODTemplate.nii.gz -include $ZAP/templates/ROIs/ListonSG-inFODTemplate.nii.gz -ends_only $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/tractography/sgACCSOS-LHsgACC-tracts.tck



