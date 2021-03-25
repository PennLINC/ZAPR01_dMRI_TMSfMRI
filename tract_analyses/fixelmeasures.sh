#!/bin/bash

ZAP=/storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI
mkdir -p $ZAP/output_measures/fixel_measures

touch $ZAP/output_measures/fixel_measures/AmygdalaSOS-LHAmygdalaROI25-FixelMeasures.csv
echo "Case, FD_mean_2, FD_mean_4, FD_mean_5, FD_mean_6, FD_mean_8, FD_mean_10, FD_mean_12, logFC_mean_2, logFC_mean_4, logFC_mean_5, logFC_mean_6, logFC_mean_8, logFC_mean_10, logFC_mean_12, FDC_mean_2, FDC_mean_4, FDC_mean_5, FDC_mean_6, FDC_mean_8, FDC_mean_10, FDC_mean_12" >> $ZAP/output_measures/fixel_measures/AmygdalaSOS-LHAmygdalaROI25-FixelMeasures.csv

cd $ZAP/qsiprep_0.6.3
for SUBJ in sub* ; do
echo $SUBJ

FD2=$(/storage/3Tissue/bin/mrstats $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/fixels/AmygdalaSOS-LHAmygdalaROI25-fixels/FD_smoothed-2/$SUBJ-FD.mif -output mean)
FD4=$(/storage/3Tissue/bin/mrstats $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/fixels/AmygdalaSOS-LHAmygdalaROI25-fixels/FD_smoothed-4/$SUBJ-FD.mif -output mean)
FD5=$(/storage/3Tissue/bin/mrstats $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/fixels/AmygdalaSOS-LHAmygdalaROI25-fixels/FD_smoothed-5/$SUBJ-FD.mif -output mean)
FD6=$(/storage/3Tissue/bin/mrstats $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/fixels/AmygdalaSOS-LHAmygdalaROI25-fixels/FD_smoothed-6/$SUBJ-FD.mif -output mean)
FD8=$(/storage/3Tissue/bin/mrstats $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/fixels/AmygdalaSOS-LHAmygdalaROI25-fixels/FD_smoothed-8/$SUBJ-FD.mif -output mean)
FD10=$(/storage/3Tissue/bin/mrstats $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/fixels/AmygdalaSOS-LHAmygdalaROI25-fixels/FD_smoothed-10/$SUBJ-FD.mif -output mean)
FD12=$(/storage/3Tissue/bin/mrstats $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/fixels/AmygdalaSOS-LHAmygdalaROI25-fixels/FD_smoothed-12/$SUBJ-FD.mif -output mean)

logFC2=$(/storage/3Tissue/bin/mrstats $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/fixels/AmygdalaSOS-LHAmygdalaROI25-fixels/logFC_smoothed-2/$SUBJ-logFC.mif -output mean)
logFC4=$(/storage/3Tissue/bin/mrstats $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/fixels/AmygdalaSOS-LHAmygdalaROI25-fixels/logFC_smoothed-4/$SUBJ-logFC.mif -output mean)
logFC5=$(/storage/3Tissue/bin/mrstats $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/fixels/AmygdalaSOS-LHAmygdalaROI25-fixels/logFC_smoothed-5/$SUBJ-logFC.mif -output mean)
logFC6=$(/storage/3Tissue/bin/mrstats $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/fixels/AmygdalaSOS-LHAmygdalaROI25-fixels/logFC_smoothed-6/$SUBJ-logFC.mif -output mean)
logFC8=$(/storage/3Tissue/bin/mrstats $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/fixels/AmygdalaSOS-LHAmygdalaROI25-fixels/logFC_smoothed-8/$SUBJ-logFC.mif -output mean)
logFC10=$(/storage/3Tissue/bin/mrstats $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/fixels/AmygdalaSOS-LHAmygdalaROI25-fixels/logFC_smoothed-10/$SUBJ-logFC.mif -output mean)
logFC12=$(/storage/3Tissue/bin/mrstats $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/fixels/AmygdalaSOS-LHAmygdalaROI25-fixels/logFC_smoothed-12/$SUBJ-logFC.mif -output mean)

FDC2=$(/storage/3Tissue/bin/mrstats $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/fixels/AmygdalaSOS-LHAmygdalaROI25-fixels/FDC_smoothed-2/$SUBJ-FDC.mif -output mean)
FDC4=$(/storage/3Tissue/bin/mrstats $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/fixels/AmygdalaSOS-LHAmygdalaROI25-fixels/FDC_smoothed-4/$SUBJ-FDC.mif -output mean)
FDC5=$(/storage/3Tissue/bin/mrstats $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/fixels/AmygdalaSOS-LHAmygdalaROI25-fixels/FDC_smoothed-5/$SUBJ-FDC.mif -output mean)
FDC6=$(/storage/3Tissue/bin/mrstats $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/fixels/AmygdalaSOS-LHAmygdalaROI25-fixels/FDC_smoothed-6/$SUBJ-FDC.mif -output mean)
FDC8=$(/storage/3Tissue/bin/mrstats $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/fixels/AmygdalaSOS-LHAmygdalaROI25-fixels/FDC_smoothed-8/$SUBJ-FDC.mif -output mean)
FDC10=$(/storage/3Tissue/bin/mrstats $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/fixels/AmygdalaSOS-LHAmygdalaROI25-fixels/FDC_smoothed-10/$SUBJ-FDC.mif -output mean)
FDC12=$(/storage/3Tissue/bin/mrstats $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/fixels/AmygdalaSOS-LHAmygdalaROI25-fixels/FDC_smoothed-12/$SUBJ-FDC.mif -output mean)

echo "$SUBJ, $FD2, $FD4, $FD5, $FD6, $FD8, $FD10, $FD12, $logFC2, $logFC4, $logFC5, $logFC6, $logFC8, $logFC10, $logFC12, $FDC2, $FDC4, $FDC5, $FDC6, $FDC8, $FDC10, $FDC12" >> $ZAP/output_measures/fixel_measures/AmygdalaSOS-LHAmygdalaROI25-FixelMeasures.csv

done
