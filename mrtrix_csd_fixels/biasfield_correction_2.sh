#!/bin/bash

##Bias field correction (initial); executed to enhance performance of dwi2mask
#https://3tissue.github.io/doc/single-subject.html

ZAP=/storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI

cd $ZAP/qsiprep_0.6.3
for SUBJ in sub* ; do

/storage/3Tissue/bin/dwibiascorrect ants $ZAP/mrtrix_fixelanalysis/subject_data/$SUBJ/${SUBJ}-acq-DTIb1000mb2dir64-preproc_dwi.mif $ZAP/mrtrix_fixelanalysis/subject_data/$SUBJ/${SUBJ}-acq-DTIb1000mb2dir64-preproc_dwi-biascorrect.mif

done

