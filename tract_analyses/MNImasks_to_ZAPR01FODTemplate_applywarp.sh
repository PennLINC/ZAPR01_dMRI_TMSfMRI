#!/bin/bash

#Register MNI space masks of interest (study-specific TMS sites of stimulation masks and left hemisphere amygdala ROI masks) to the ZAPR01 FOD Template. Performed to enable extraction of tractography streamlines that connect the site of stimulation masks to the subcortical tarets

ZAP=/storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI

mkdir $ZAP/templates/ROIs

#Amygdala ROI
fslmaths /usr/local/fsl-5.0.11/data/atlases/HarvardOxford/HarvardOxford-sub-maxprob-thr25-1mm.nii.gz -thr 10 -uthr 10 $ZAP/templates/ROIs/HarvardOxford-sub-maxprob-thr25-1mm-LHamygdala.nii.gz
antsApplyTransforms -d 3 -i $ZAP/templates/ROIs/HarvardOxford-sub-maxprob-thr25-1mm-LHamygdala.nii.gz -r $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FOD_Template_l0.nii.gz -o $ZAP/templates/ROIs/HarvardOxford-sub-maxprob-thr25-1mm-LHamygdala-inFODTemplate.nii.gz -n NearestNeighbor -t $ZAP/templates/FSL_HCP1065_FA_1.3mm-inFODTemplate1Warp.nii.gz -t $ZAP/templates/FSL_HCP1065_FA_1.3mm-inFODTemplate0GenericAffine.mat
fslmaths /usr/local/fsl-5.0.11/data/atlases/HarvardOxford/HarvardOxford-sub-maxprob-thr50-1mm.nii.gz -thr 10 -uthr 10 $ZAP/templates/ROIs/HarvardOxford-sub-maxprob-thr50-1mm-LHamygdala.nii.gz
antsApplyTransforms -d 3 -i $ZAP/templates/ROIs/HarvardOxford-sub-maxprob-thr50-1mm-LHamygdala.nii.gz -r $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FOD_Template_l0.nii.gz -o $ZAP/templates/ROIs/HarvardOxford-sub-maxprob-thr50-1mm-LHamygdala-inFODTemplate.nii.gz -n NearestNeighbor -t $ZAP/templates/FSL_HCP1065_FA_1.3mm-inFODTemplate1Warp.nii.gz -t $ZAP/templates/FSL_HCP1065_FA_1.3mm-inFODTemplate0GenericAffine.mat

#Amygdala TMS Sites of Stimulation Study Mask
antsApplyTransforms -d 3 -i $ZAP/sites_of_stim/Amygdala-SitesofStimulation-StudyMask-MNI-2mm.nii.gz -r $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FOD_Template_l0.nii.gz -o $ZAP/sites_of_stim/Amygdala-SitesofStimulation-StudyMask-inFODTemplate.nii.gz -n NearestNeighbor -t $ZAP/templates/FSL_HCP1065_FA_1.3mm-inFODTemplate1Warp.nii.gz -t $ZAP/templates/FSL_HCP1065_FA_1.3mm-inFODTemplate0GenericAffine.mat

#sgACC TMS Sites of Stimulation Study Mask

antsApplyTransforms -d 3 -i $ZAP/sites_of_stim/sgACC-SitesofStimulation-StudyMask-MNI-2mm.nii.gz -r $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FOD_Template_l0.nii.gz -o $ZAP/sites_of_stim/sgACC-SitesofStimulation-StudyMask-inFODTemplate.nii.gz -n NearestNeighbor -t $ZAP/templates/FSL_HCP1065_FA_1.3mm-inFODTemplate1Warp.nii.gz -t $ZAP/templates/FSL_HCP1065_FA_1.3mm-inFODTemplate0GenericAffine.mat








