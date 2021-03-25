#!/bin/bash

#Create a study-specific FOD Template from all FOD-norm images and corresponding brain masks
#https://mrtrix.readthedocs.io/en/latest/fixel_based_analysis/st_fibre_density_cross-section.html, Step 10

ZAP=/storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI

mkdir -p $ZAP/mrtrix_fixelanalysis/population_template/FOD_inputs
mkdir $ZAP/mrtrix_fixelanalysis/population_template/mask_inputs

cd $ZAP/qsiprep_0.6.3
for SUBJ in sub* ; do

cd $ZAP/mrtrix_fixelanalysis/population_template/FOD_inputs
ln -s ../../subject_data/$SUBJ/${SUBJ}-WM-FOD-norm.mif $ZAP/mrtrix_fixelanalysis/population_template/FOD_inputs
cd $ZAP/mrtrix_fixelanalysis/population_template/mask_inputs
ln -s ../../subject_data/$SUBJ/${SUBJ}-acq-DTIb1000mb2dir64-preproc_dwi-brainmask-dilated.mif $ZAP/mrtrix_fixelanalysis/population_template/mask_inputs

done
 
