#!/bin/bash

#Generate a fixel-fixel connectivity matrix, based on the whole brain tractography, to enable smoothing
#https://mrtrix.readthedocs.io/en/latest/fixel_based_analysis/st_fibre_density_cross-section.html, Step 22

ZAP=/storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI

/home/vsydnor/miniconda3/bin/fixelconnectivity $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FixelMask $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FOD_Template_Tractography.tck $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FixelMask/fixel_connectivity_matrix

