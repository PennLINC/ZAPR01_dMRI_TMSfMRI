#!/bin/bash

#Match subject fixels in template space to ZAPR01 Template Fixels
#https://mrtrix.readthedocs.io/en/latest/fixel_based_analysis/st_fibre_density_cross-section.html , Step 17

ZAP=/storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI

cd $ZAP/qsiprep_0.6.3
for SUBJ in sub* ; do

/storage/3Tissue/bin/fixelcorrespondence $ZAP/mrtrix_fixelanalysis/subject_data/$SUBJ/${SUBJ}-Fixels/${SUBJ}-FD.mif $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FixelMask $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FixelMask/FD ${SUBJ}-FD.mif -force

done
