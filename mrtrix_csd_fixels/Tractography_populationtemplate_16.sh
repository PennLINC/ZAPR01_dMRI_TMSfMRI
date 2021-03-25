#!/bin/bash

#Perform whole brain tractography on the ZAPR01 FOD Template
#https://mrtrix.readthedocs.io/en/latest/fixel_based_analysis/st_fibre_density_cross-section.html, Step 20 

ZAP=/storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI

/storage/3Tissue/bin/tckgen -angle 22.5 -maxlen 250 -minlen 10 -power 1.0 /storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI/mrtrix_fixelanalysis/population_template/ZAPR01_FOD_Template.mif -seed_image /storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI/mrtrix_fixelanalysis/population_template/ZAPR01_FOD_Template-mask.mif -mask /storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI/mrtrix_fixelanalysis/population_template/ZAPR01_FOD_Template-mask.mif -select 2500000 -cutoff 0.10 /storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI/mrtrix_fixelanalysis/population_template/ZAPR01_FOD_Template_Tractography.tck

