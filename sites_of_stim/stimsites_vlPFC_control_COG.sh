#!/bin/bash

#Script to identify center of gravity TMS stimulation site for vlPFC and control sites

ZAP=/storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI

#vlPFC TMS sites center of gravity
#fslstats Amygdala-SitesofStimulation-StudyMask-weighted-MNI-2mm.nii.gz  -C : 69.600000 79.888889 42.177778  
fslmaths /usr/local/fsl/data/standard/MNI152_T1_2mm_brain.nii.gz -mul 0 -add 1 -roi 69.600000 1 79.888889 1 42.177778 1 0 1 $ZAP/sites_of_stim/Amygdala-SitesofStimulation-GroupCOG-MNI-2mm.nii.gz 
 
fslmaths $ZAP/sites_of_stim/Amygdala-SitesofStimulation-GroupCOG-MNI-2mm.nii.gz -dilM -kernel sphere 6.5 -fmean -bin $ZAP/sites_of_stim/Amygdala-SitesofStimulation-GroupCOG-MNI-2mm.nii.gz

#control TMS sites center of gravity
#fslstats sgACC-SitesofStimulation-StudyMask-weighted-MNI-2mm.nii.gz -C : 61.111111 80.066667 56.977778 
fslmaths /usr/local/fsl/data/standard/MNI152_T1_2mm_brain.nii.gz -mul 0 -add 1 -roi 61.111111 1 80.066667 1 56.977778 1 0 1 $ZAP/sites_of_stim/sgACC-SitesofStimulation-GroupCOG-MNI-2mm.nii.gz 

fslmaths $ZAP/sites_of_stim/sgACC-SitesofStimulation-GroupCOG-MNI-2mm.nii.gz -dilM -kernel sphere 6.5 -fmean -bin $ZAP/sites_of_stim/sgACC-SitesofStimulation-GroupCOG-MNI-2mm.nii.gz
