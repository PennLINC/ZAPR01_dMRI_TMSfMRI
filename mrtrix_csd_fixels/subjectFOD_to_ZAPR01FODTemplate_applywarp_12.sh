#!/bin/bash

#Register subject WM FOD images to the ZAPR01 FOD Template (no FOD reorientation), using precomputed warp from Step 11 
#https://mrtrix.readthedocs.io/en/latest/fixel_based_analysis/st_fibre_density_cross-section.html , Step 14

ZAP=/storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI

cd $ZAP/qsiprep_0.6.3
for SUBJ in sub* ; do

/storage/3Tissue/bin/mrtransform $ZAP/mrtrix_fixelanalysis/subject_data/$SUBJ/${SUBJ}-WM-FOD-norm.mif -warp $ZAP/mrtrix_fixelanalysis/subject_data/$SUBJ/${SUBJ}-subFOD2PopulationTemplateFOD_warp.mif -reorient_fod no $ZAP/mrtrix_fixelanalysis/subject_data/$SUBJ/${SUBJ}-WM-FOD-norm-inFODTemplate-noreorient.mif

done


