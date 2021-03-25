#!/bin/bash

#Compute FC and FDC metrics 
#https://mrtrix.readthedocs.io/en/latest/fixel_based_analysis/st_fibre_density_cross-section.html , Steps 18 and 19

ZAP=/storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI

cd $ZAP/qsiprep_0.6.3
for SUBJ in sub* ; do

#FC
/storage/3Tissue/bin/warp2metric $ZAP/mrtrix_fixelanalysis/subject_data/$SUBJ/${SUBJ}-subFOD2PopulationTemplateFOD_warp.mif -fc $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FixelMask $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FixelMask/FC ${SUBJ}-FC.mif

done

#logFC
mkdir $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FixelMask/logFC
cp $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FixelMask/FC/index.mif $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FixelMask/logFC
cp $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FixelMask/FC/directions.mif $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FixelMask/logFC

cd $ZAP/qsiprep_0.6.3
for SUBJ in sub* ; do

/storage/3Tissue/bin/mrcalc $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FixelMask/FC/${SUBJ}-FC.mif -log $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FixelMask/logFC/${SUBJ}-logFC.mif

done

#FDC
mkdir $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FixelMask/FDC
cp $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FixelMask/FC/index.mif $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FixelMask/FDC
cp $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FixelMask/FC/directions.mif $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FixelMask/FDC

cd $ZAP/qsiprep_0.6.3
for SUBJ in sub* ; do

/storage/3Tissue/bin/mrcalc $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FixelMask/FD/${SUBJ}-FD.mif $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FixelMask/FC/${SUBJ}-FC.mif -mult $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FixelMask/FDC/${SUBJ}-FDC.mif

done
