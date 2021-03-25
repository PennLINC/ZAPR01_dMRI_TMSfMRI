#!/bin/bash

#Register subject FOD images to the ZAPR01 Population Template, save warp
#https://mrtrix.readthedocs.io/en/latest/fixel_based_analysis/st_fibre_density_cross-section.html , Step 11

ZAP=/storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI

cd $ZAP/qsiprep_0.6.3
for SUBJ in sub* ; do

/storage/3Tissue/bin/mrregister $ZAP/mrtrix_fixelanalysis/subject_data/$SUBJ/${SUBJ}-WM-FOD-norm.mif -mask1 $ZAP/mrtrix_fixelanalysis/subject_data/$SUBJ/${SUBJ}-acq-DTIb1000mb2dir64-preproc_dwi-brainmask-dilated.mif $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FOD_Template.mif -nl_warp $ZAP/mrtrix_fixelanalysis/subject_data/$SUBJ/${SUBJ}-subFOD2PopulationTemplateFOD_warp.mif $ZAP/mrtrix_fixelanalysis/subject_data/$SUBJ/${SUBJ}-PopulationTemplateFOD2subFOD_warp.mif

done  
