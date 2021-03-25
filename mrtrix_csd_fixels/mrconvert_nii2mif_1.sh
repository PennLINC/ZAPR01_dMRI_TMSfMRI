#!/bin/bash

##Convert qsiprep preprocessed nii + grad table to mif for mrtrix pipeline

ZAP=/storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI

cd $ZAP/qsiprep_0.6.3
for SUBJ in sub* ; do

mkdir $ZAP/mrtrix_fixelanalysis/subject_data/$SUBJ

/storage/3Tissue/bin/mrconvert -grad $SUBJ/ses-Baseline/dwi/${SUBJ}_ses-Baseline_acq-DTIb1000mb2dir64_space-T1w_desc-preproc_dwi.b $SUBJ/ses-Baseline/dwi/${SUBJ}_ses-Baseline_acq-DTIb1000mb2dir64_space-T1w_desc-preproc_dwi.nii.gz $ZAP/mrtrix_fixelanalysis/subject_data/$SUBJ/${SUBJ}-acq-DTIb1000mb2dir64-preproc_dwi.mif

done  

