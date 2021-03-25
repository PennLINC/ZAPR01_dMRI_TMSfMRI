#!/bin/bash

#Visualize any streamlines connecting the sgACC TMS Sites of Stimulation Study Mask to the LH amygdala 
#Note, no tract was identified

ZAP=/storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI

/storage/3Tissue/bin/tckedit $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FOD_Template_Tractography.tck -include $ZAP/sites_of_stim/sgACC-SitesofStimulation-StudyMask-inFODTemplate.nii.gz -include $ZAP/templates/ROIs/HarvardOxford-sub-maxprob-thr25-1mm-LHamygdala-inFODTemplate.nii.gz -ends_only $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/tractography/sgACCSOS-LHAmygdalaROI25-tracts.tck



