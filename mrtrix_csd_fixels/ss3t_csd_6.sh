#!/bin/bash

##Perform 3-tissue constrained spherical deconvolution with ss3t_csd_beta1 to estimate WM FOD and GM and CSF images for each subject
#https://3tissue.github.io/doc/single-subject.html

ZAP=/storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI

cd $ZAP/qsiprep_0.6.3
for SUBJ in sub* ; do

if ! [ -e $ZAP/mrtrix_fixelanalysis/subject_data/$SUBJ/${SUBJ}-WM-FOD.mif ]
then

/storage/3Tissue/bin/ss3t_csd_beta1 $ZAP/mrtrix_fixelanalysis/subject_data/$SUBJ/${SUBJ}-acq-DTIb1000mb2dir64-preproc_dwi-biascorrect.mif $ZAP/mrtrix_fixelanalysis/response_functions/ZAPR01-WM-responsefunction.txt $ZAP/mrtrix_fixelanalysis/subject_data/$SUBJ/${SUBJ}-WM-FOD.mif $ZAP/mrtrix_fixelanalysis/response_functions/ZAPR01-GM-responsefunction.txt $ZAP/mrtrix_fixelanalysis/subject_data/$SUBJ/${SUBJ}-GM-CSD.mif $ZAP/mrtrix_fixelanalysis/response_functions/ZAPR01-CSF-responsefunction.txt $ZAP/mrtrix_fixelanalysis/subject_data/$SUBJ/${SUBJ}-CSF-CSD.mif -mask $ZAP/mrtrix_fixelanalysis/subject_data/$SUBJ/${SUBJ}-acq-DTIb1000mb2dir64-preproc_dwi-brainmask-dilated.mif

fi

done
