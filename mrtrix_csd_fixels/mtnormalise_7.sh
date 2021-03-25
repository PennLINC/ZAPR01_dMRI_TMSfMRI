#!/bin/bash

##Perform global intensity normalization and bias field correction on FOD images and GM/CSF compartments
#https://3tissue.github.io/doc/single-subject.html

ZAP=/storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI

cd $ZAP/qsiprep_0.6.3
for SUBJ in sub* ; do

/storage/3Tissue/bin/mtnormalise $ZAP/mrtrix_fixelanalysis/subject_data/$SUBJ/${SUBJ}-WM-FOD.mif $ZAP/mrtrix_fixelanalysis/subject_data/$SUBJ/${SUBJ}-WM-FOD-norm.mif $ZAP/mrtrix_fixelanalysis/subject_data/$SUBJ/${SUBJ}-GM-CSD.mif $ZAP/mrtrix_fixelanalysis/subject_data/$SUBJ/${SUBJ}-GM-CSD-norm.mif  $ZAP/mrtrix_fixelanalysis/subject_data/$SUBJ/${SUBJ}-CSF-CSD.mif  $ZAP/mrtrix_fixelanalysis/subject_data/$SUBJ/${SUBJ}-CSF-CSD-norm.mif -mask $ZAP/mrtrix_fixelanalysis/subject_data/$SUBJ/${SUBJ}-acq-DTIb1000mb2dir64-preproc_dwi-brainmask-dilated.mif 

rm $ZAP/mrtrix_fixelanalysis/subject_data/$SUBJ/${SUBJ}-WM-FOD.mif $ZAP/mrtrix_fixelanalysis/subject_data/$SUBJ/${SUBJ}-GM-CSD.mif $ZAP/mrtrix_fixelanalysis/subject_data/$SUBJ/${SUBJ}-CSF-CSD.mif 

done
