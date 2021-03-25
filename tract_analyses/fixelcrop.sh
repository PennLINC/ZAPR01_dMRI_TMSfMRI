#!/bin/bash

#Identify TMS SOS-subcortical tract-relevant fixels (at varying thresholds) from  whole-brain ZAPR01 Template Fixels 

ZAP=/storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI

for num in 2 4 5 6 8 10 12 ; do

#threshold the tck2fixel track density image at varying streamline thresholds. thresholding at 2-12 streamlines per fixel for inclusion in the mask
/storage/3Tissue/bin/mrthreshold $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/fixels/AmygdalaSOS-LHAmygdalaROI25-fixels/AmygdalaSOS-LHAmygdalaROI25-TDI.mif -abs $num $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/fixels/AmygdalaSOS-LHAmygdalaROI25-fixels/AmygdalaSOS-LHAmygdalaROI25-fixelmask-$num.mif

ln -s $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/fixels/AmygdalaSOS-LHAmygdalaROI25-fixels/AmygdalaSOS-LHAmygdalaROI25-fixelmask-$num.mif $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FixelMask/FD_smoothed
ln -s $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/fixels/AmygdalaSOS-LHAmygdalaROI25-fixels/AmygdalaSOS-LHAmygdalaROI25-fixelmask-$num.mif $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FixelMask/logFC_smoothed
ln -s $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/fixels/AmygdalaSOS-LHAmygdalaROI25-fixels/AmygdalaSOS-LHAmygdalaROI25-fixelmask-$num.mif $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FixelMask/FDC_smoothed

#crop ZAPR01 template whole-brain fixels based upon the fixel inclusion masks generated above, apply to all subject data in FD, logFC, and FDC folders
/storage/3Tissue/bin/fixelcrop $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FixelMask/FD_smoothed $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/fixels/AmygdalaSOS-LHAmygdalaROI25-fixels/AmygdalaSOS-LHAmygdalaROI25-fixelmask-$num.mif $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/fixels/AmygdalaSOS-LHAmygdalaROI25-fixels/FD_smoothed-$num
/storage/3Tissue/bin/fixelcrop $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FixelMask/logFC_smoothed $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/fixels/AmygdalaSOS-LHAmygdalaROI25-fixels/AmygdalaSOS-LHAmygdalaROI25-fixelmask-$num.mif $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/fixels/AmygdalaSOS-LHAmygdalaROI25-fixels/logFC_smoothed-$num
/storage/3Tissue/bin/fixelcrop $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FixelMask/FDC_smoothed $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/fixels/AmygdalaSOS-LHAmygdalaROI25-fixels/AmygdalaSOS-LHAmygdalaROI25-fixelmask-$num.mif $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/fixels/AmygdalaSOS-LHAmygdalaROI25-fixels/FDC_smoothed-$num

done
