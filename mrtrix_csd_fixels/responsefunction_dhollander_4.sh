#!/bin/bash

##Estimate WM, GM, and CSF response functions for each subject with mrtrix3Tissue's dwi2response dhollander algorithm (single-shell 3-tissue response function estimation) 
#https://3tissue.github.io/doc/single-subject.html

ZAP=/storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI

mkdir /storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI/mrtrix_fixelanalysis/response_functions

cd $ZAP/qsiprep_0.6.3
for SUBJ in sub* ; do

/storage/3Tissue/bin/dwi2response dhollander $ZAP/mrtrix_fixelanalysis/subject_data/$SUBJ/${SUBJ}-acq-DTIb1000mb2dir64-preproc_dwi-biascorrect.mif $ZAP/mrtrix_fixelanalysis/response_functions/${SUBJ}-WM-response.txt $ZAP/mrtrix_fixelanalysis/response_functions/${SUBJ}-GM-response.txt $ZAP/mrtrix_fixelanalysis/response_functions/${SUBJ}-CSF-response.txt -voxels $ZAP/mrtrix_fixelanalysis/subject_data/$SUBJ/${SUBJ}-responsefunction-voxels.mif

done
