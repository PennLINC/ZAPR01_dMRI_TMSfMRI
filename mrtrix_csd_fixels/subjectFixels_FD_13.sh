#!/bin/bash

#Generate subject fixel masks from FOD images and reorient subject fixels to ZAPR01 Template Fixels
#https://mrtrix.readthedocs.io/en/latest/fixel_based_analysis/st_fibre_density_cross-section.html, Steps 15 and 16

ZAP=/storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI

cd $ZAP/qsiprep_0.6.3
for SUBJ in sub* ; do

/storage/3Tissue/bin/fod2fixel -mask $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FOD_Template-mask.mif $ZAP/mrtrix_fixelanalysis/subject_data/$SUBJ/${SUBJ}-WM-FOD-norm-inFODTemplate-noreorient.mif $ZAP/mrtrix_fixelanalysis/subject_data/$SUBJ/${SUBJ}-Fixels-inFODTemplate_noreorient -afd ${SUBJ}-FD.mif 

/storage/3Tissue/bin/fixelreorient $ZAP/mrtrix_fixelanalysis/subject_data/$SUBJ/${SUBJ}-Fixels-inFODTemplate_noreorient $ZAP/mrtrix_fixelanalysis/subject_data/$SUBJ/${SUBJ}-subFOD2PopulationTemplateFOD_warp.mif $ZAP/mrtrix_fixelanalysis/subject_data/$SUBJ/${SUBJ}-Fixels

rm -Rf $ZAP/mrtrix_fixelanalysis/subject_data/$SUBJ/${SUBJ}-Fixels-inFODTemplate_noreorient

done

