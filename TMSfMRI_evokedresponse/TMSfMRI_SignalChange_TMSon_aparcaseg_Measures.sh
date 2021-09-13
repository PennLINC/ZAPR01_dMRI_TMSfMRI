#!/bin/bash

ZAP=/storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI
touch $ZAP/output_measures/TMSfMRI_evokedresponse/PreAmygdala_TMSfMRI_EvokedResponse_FreeSurfer-LeftAmygdala.csv

while read line ; do
SUBJ=${line#*1}

antsApplyTransforms -d 3 -i $ZAP/qsiprep_0.6.3/$line/anat/${line}_desc-aparcaseg_dseg.nii.gz -r /usr/local/fsl-5.0.11/data/standard/MNI152_T1_2mm_brain.nii.gz -n NearestNeighbor -o $ZAP/qsiprep_0.6.3/$line/anat/${line}_desc-aparcaseg_dseg-inMNI2mm.nii.gz -t $ZAP/qsiprep_0.6.3/$line/anat/${line}_from-T1w_to-MNI152NLin2009cAsym_mode-image_xfm.h5 

fslmaths $ZAP/qsiprep_0.6.3/$line/anat/${line}_desc-aparcaseg_dseg-inMNI2mm.nii.gz -thr 18 -uthr 18 $ZAP/qsiprep_0.6.3/$line/anat/${line}_desc-aparcaseg_dseg-LHamygdala-inMNI2mm.nii.gz

3dROIstats -mask $ZAP/qsiprep_0.6.3/$line/anat/${line}_desc-aparcaseg_dseg-LHamygdala-inMNI2mm.nii.gz -nobriklab -1DRformat $ZAP/TMSfMRI_ER_sigchangemaps/ZAPR01_${SUBJ}_sp120_PreIFG_sigchange_contrast1_TMSonStd.nii.gz >> $ZAP/output_measures/TMSfMRI_evokedresponse/freesurfer_aparcaseg/$line-PreIFG-Freesurfer-LHamygdala.csv
data=$(sed -n "2p" $ZAP/output_measures/TMSfMRI_evokedresponse/freesurfer_aparcaseg/$line-PreIFG-Freesurfer-LHamygdala.csv)
echo "$line	$data" >> $ZAP/output_measures/TMSfMRI_evokedresponse/PreAmygdala_TMSfMRI_EvokedResponse_FreeSurfer-LeftAmygdala.csv

done < $ZAP/ZAPR01_DWI_TMSfMRI_FinalSample.txt
