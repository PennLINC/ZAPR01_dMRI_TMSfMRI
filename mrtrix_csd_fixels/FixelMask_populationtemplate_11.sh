#!/bin/bash

#Create a study-specific Fixel Analysis Mask
#https://mrtrix.readthedocs.io/en/latest/fixel_based_analysis/st_fibre_density_cross-section.html, Step 13

ZAP=/storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI

/storage/3Tissue/bin/fod2fixel -mask $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FOD_Template-mask.mif -fmls_peak_value 0.10 $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FOD_Template.mif  $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FixelMask
