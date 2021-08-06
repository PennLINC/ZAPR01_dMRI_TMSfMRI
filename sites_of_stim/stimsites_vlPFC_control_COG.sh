#!/bin/bash

#Script to identify center of gravity TMS stimulation site for vlPFC and control sites

ZAP=/storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI

#vlPFC TMS sites center of gravity
#fslstats Amygdala-SitesofStimulation-StudyMask-MNI-2mm.nii.gz  -C : 68.811006 80.116279 43.196856 
fslmaths /usr/local/fsl/data/standard/MNI152_T1_2mm_brain.nii.gz -mul 0 -add 1 -roi 68.811006 1 80.116279 1 43.196856 1 0 1 $ZAP/sites_of_stim/Amygdala-SitesofStimulation-GroupCOG-MNI-2mm.nii.gz
 
fslmaths $ZAP/sites_of_stim/Amygdala-SitesofStimulation-GroupCOG-MNI-2mm.nii.gz -dilM -kernel sphere 6.5 -fmean -bin $ZAP/sites_of_stim/Amygdala-SitesofStimulation-GroupCOG-MNI-2mm.nii.gz

#control TMS sites center of gravity
#fslstats sgACC-SitesofStimulation-StudyMask-MNI-2mm.nii.gz -C : 61.747186 80.606936 55.230910 
fslmaths /usr/local/fsl/data/standard/MNI152_T1_2mm_brain.nii.gz -mul 0 -add 1 -roi 61.747186 1 80.606936 1 55.230910 1 0 1 $ZAP/sites_of_stim/sgACC-SitesofStimulation-GroupCOG-MNI-2mm.nii.gz 

fslmaths $ZAP/sites_of_stim/sgACC-SitesofStimulation-GroupCOG-MNI-2mm.nii.gz -dilM -kernel sphere 6.5 -fmean -bin $ZAP/sites_of_stim/sgACC-SitesofStimulation-GroupCOG-MNI-2mm.nii.gz
