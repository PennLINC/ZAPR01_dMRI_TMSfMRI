#!/bin/bash

#Smooth fixel measures by connectivity matrix
#https://mrtrix.readthedocs.io/en/latest/fixel_based_analysis/st_fibre_density_cross-section.html, Step 23

ZAP=/storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI

/home/vsydnor/miniconda3/bin/fixelfilter $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FixelMask/FD smooth $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FixelMask/FD_smoothed -matrix $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FixelMask/fixel_connectivity_matrix
/home/vsydnor/miniconda3/bin/fixelfilter $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FixelMask/logFC smooth $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FixelMask/logFC_smoothed -matrix $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FixelMask/fixel_connectivity_matrix
/home/vsydnor/miniconda3/bin/fixelfilter $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FixelMask/FDC smooth $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FixelMask/FDC_smoothed -matrix $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FixelMask/fixel_connectivity_matrix

