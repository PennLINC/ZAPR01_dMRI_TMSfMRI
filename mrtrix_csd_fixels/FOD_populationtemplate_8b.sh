#!/bin/bash

#Create a study-specific FOD Template from all FOD-norm images and corresponding brain masks
#https://mrtrix.readthedocs.io/en/latest/fixel_based_analysis/st_fibre_density_cross-section.html, Step 10

ZAP=/storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI

/storage/3Tissue/bin/population_template $ZAP/mrtrix_fixelanalysis/population_template/FOD_inputs -mask_dir $ZAP/mrtrix_fixelanalysis/population_template/mask_inputs $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FOD_Template.mif -voxel_size 1.3


