#!/bin/bash

#Quantify Evoked Response in Amygdala Nuclei

ZAP=/storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI

touch $ZAP/output_measures/TMSfMRI_evokedresponse/PreAmygdala_TMSfMRI_EvokedResponse_Juelich_AmygdalaNuclei.csv

while read line ; do
SUBJ=${line#*1}
3dROIstats -mask $ZAP/templates/ROIs/Juelich-LHamygdala-nuclei-maxprob-thr50-2mm.nii.gz -nobriklab -1DRformat $ZAP/TMSfMRI_ER_sigchangemaps/ZAPR01_${SUBJ}_sp120_PreIFG_sigchange_contrast1_TMSonStd.nii.gz >> $ZAP/output_measures/TMSfMRI_evokedresponse/Juelich_amygdala/$line-PreIFG-Juelichamygdala.csv
data=$(sed -n "2p" $ZAP/output_measures/TMSfMRI_evokedresponse/Juelich_amygdala/$line-PreIFG-Juelichamygdala.csv)
echo "$line	$data" >> $ZAP/output_measures/TMSfMRI_evokedresponse/PreAmygdala_TMSfMRI_EvokedResponse_Juelich_AmygdalaNuclei.csv

done < $ZAP/ZAPR01_DWI_TMSfMRI_FinalSample.txt
