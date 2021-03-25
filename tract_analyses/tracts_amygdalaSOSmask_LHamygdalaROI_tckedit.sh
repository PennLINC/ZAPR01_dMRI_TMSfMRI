#!/bin/bash

#Identify causal pathway streamlines connecting the Amygdala TMS Sites of Stimulation Study Mask to the LH amygdala

ZAP=/storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI
mkdir -p $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/tractography

/storage/3Tissue/bin/tckedit $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FOD_Template_Tractography.tck -include $ZAP/sites_of_stim/Amygdala-SitesofStimulation-StudyMask-inFODTemplate.nii.gz -include $ZAP/templates/ROIs/HarvardOxford-sub-maxprob-thr25-1mm-LHamygdala-inFODTemplate.nii.gz -ends_only $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/tractography/AmygdalaSOS-LHAmygdalaROI25-tracts.tck


