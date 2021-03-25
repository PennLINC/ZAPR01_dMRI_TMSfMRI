#!/bin/bash

#Script to generate MNI space spherical ROIs from Brainsight X,Y,Z site of stim MNI voxel coordinates and study-specific combined Amygdala and sgACC TMS site of stim masks 

ZAP=/storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI
stimsites=$ZAP/sites_of_stim

cd $ZAP/qsiprep_0.6.3
for SUBJ in sub* ; do

#extract BLA and sgACC site of stimulation x,y,z coordinates for each subject
cat $stimsites/ZAPR01_SiteofStim_MNIcoordinates_BLA.csv | grep $SUBJ >> $stimsites/${SUBJ}_siteofstim_BLA_tmp.csv
cut -d "," -f 3-  $stimsites/${SUBJ}_siteofstim_BLA_tmp.csv >> $stimsites/${SUBJ}_siteofstim_BLA.csv
rm $stimsites/${SUBJ}_siteofstim_BLA_tmp.csv

cat $stimsites/ZAPR01_SiteofStim_MNIcoordinates_sgACC.csv | grep $SUBJ >> $stimsites/${SUBJ}_siteofstim_sgACC_tmp.csv
cut -d "," -f 3-  $stimsites/${SUBJ}_siteofstim_sgACC_tmp.csv >> $stimsites/${SUBJ}_siteofstim_sgACC.csv
rm $stimsites/${SUBJ}_siteofstim_sgACC_tmp.csv

#generate spherical ROIs from x,y,z coordinates
xcoord=$(awk -F, 'BEGIN {OFS=","} {print $1}' $stimsites/${SUBJ}_siteofstim_BLA.csv)
ycoord=$(awk -F, 'BEGIN {OFS=","} {print $2}' $stimsites/${SUBJ}_siteofstim_BLA.csv)
zcoord=$(awk -F, 'BEGIN {OFS=","} {print $3}' $stimsites/${SUBJ}_siteofstim_BLA.csv)
fslmaths /usr/local/fsl/data/standard/MNI152_T1_2mm_brain.nii.gz -mul 0 -add 1 -roi $xcoord 1 $ycoord 1 $zcoord 1 0 1 $stimsites/${SUBJ}_siteofstim_BLA_point.nii.gz -odt float
fslmaths $stimsites/${SUBJ}_siteofstim_BLA_point.nii.gz -dilM -kernel sphere 3 -fmean -bin $stimsites/${SUBJ}_siteofstim_ROI_BLA.nii.gz
rm $stimsites/${SUBJ}_siteofstim_BLA_point.nii.gz

xcoord=$(awk -F, 'BEGIN {OFS=","} {print $1}' $stimsites/${SUBJ}_siteofstim_sgACC.csv)
ycoord=$(awk -F, 'BEGIN {OFS=","} {print $2}' $stimsites/${SUBJ}_siteofstim_sgACC.csv)
zcoord=$(awk -F, 'BEGIN {OFS=","} {print $3}' $stimsites/${SUBJ}_siteofstim_sgACC.csv)

fslmaths /usr/local/fsl/data/standard/MNI152_T1_2mm_brain.nii.gz -mul 0 -add 1 -roi $xcoord 1 $ycoord 1 $zcoord 1 0 1 $stimsites/${SUBJ}_siteofstim_sgACC_point.nii.gz -odt float
fslmaths $stimsites/${SUBJ}_siteofstim_sgACC_point.nii.gz -dilM -kernel sphere 3 -fmean -bin $stimsites/${SUBJ}_siteofstim_ROI_sgACC.nii.gz
rm $stimsites/${SUBJ}_siteofstim_sgACC_point.nii.gz

done

#create study-specific combined site of stim masks
fslmaths /usr/local/fsl/data/standard/MNI152_T1_2mm_brain.nii.gz -mul 0 $stimsites/Amygdala-SitesofStimulation-StudyMask-MNI-2mm.nii.gz 
for SUBJ in sub* ; do
fslmaths $stimsites/Amygdala-SitesofStimulation-StudyMask-MNI-2mm.nii.gz -add $stimsites/${SUBJ}_siteofstim_ROI_BLA.nii.gz $stimsites/Amygdala-SitesofStimulation-StudyMask-MNI-2mm.nii.gz
done
fslmaths $stimsites/Amygdala-SitesofStimulation-StudyMask-MNI-2mm.nii.gz -bin $stimsites/Amygdala-SitesofStimulation-StudyMask-MNI-2mm.nii.gz

fslmaths /usr/local/fsl/data/standard/MNI152_T1_2mm_brain.nii.gz -mul 0 $stimsites/sgACC-SitesofStimulation-StudyMask-MNI-2mm.nii.gz
for SUBJ in sub* ; do
fslmaths $stimsites/sgACC-SitesofStimulation-StudyMask-MNI-2mm.nii.gz -add $stimsites/${SUBJ}_siteofstim_ROI_sgACC.nii.gz $stimsites/sgACC-SitesofStimulation-StudyMask-MNI-2mm.nii.gz
done
fslmaths $stimsites/sgACC-SitesofStimulation-StudyMask-MNI-2mm.nii.gz -bin $stimsites/sgACC-SitesofStimulation-StudyMask-MNI-2mm.nii.gz

