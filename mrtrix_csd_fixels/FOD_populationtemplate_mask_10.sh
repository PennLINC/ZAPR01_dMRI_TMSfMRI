#!/bin/bash

#Warp subject brain masks to template space and create a ZAPR01 FOD Template Mask
#https://mrtrix.readthedocs.io/en/latest/fixel_based_analysis/st_fibre_density_cross-section.html, Step 12

ZAP=/storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI

cd $ZAP/qsiprep_0.6.3
for SUBJ in sub* ; do

/storage/3Tissue/bin/mrtransform $ZAP/mrtrix_fixelanalysis/subject_data/$SUBJ/${SUBJ}-acq-DTIb1000mb2dir64-preproc_dwi-brainmask-dilated.mif -warp $ZAP/mrtrix_fixelanalysis/subject_data/$SUBJ/${SUBJ}-subFOD2PopulationTemplateFOD_warp.mif -interp nearest -datatype bit $ZAP/mrtrix_fixelanalysis/subject_data/$SUBJ/${SUBJ}-acq-DTIb1000mb2dir64-preproc_dwi-brainmask-dilated-inFODTemplate.mif

done

/storage/3Tissue/bin/mrmath $ZAP/mrtrix_fixelanalysis/subject_data/*/*brainmask-dilated-inFODTemplate.mif min $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FOD_Template-mask.mif -datatype bit

