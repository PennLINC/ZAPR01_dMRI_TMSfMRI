#!/bin/bash

ZAP=/data/jux/cnds/ZAPR01/ZAPR01_WhiteMatter_TMSfMRI
mkdir $ZAP/TMSfMRI_EvokedResponse_Measures
mkdir $ZAP/TMSfMRI_EvokedResponse_Measures/data
mkdir $ZAP/TMSfMRI_EvokedResponse_Measures/measures
mkdir $ZAP/TMSfMRI_EvokedResponse_Measures/measures/subject_measures

while read line ; do 
SUBJ=${line#*1}
ln -s /data/jux/oathes_group/studies/TNI_ZAPR01/MRI/processed/funct/xcp06/sp120/output/pre/ZAPR01_${SUBJ}_sp120_PreIFG/norm/ZAPR01_${SUBJ}_sp120_PreIFG_sigchange_contrast1_TMSonStd.nii.gz $ZAP/TMSfMRI_EvokedResponse_Measures/data
ln -s /data/jux/oathes_group/studies/TNI_ZAPR01/MRI/processed/funct/xcp06/sp120/output/pre/ZAPR01_${SUBJ}_sp120_PreSgACC*/norm/ZAPR01_${SUBJ}_sp120_PreSgACC*_sigchange_contrast1_TMSonStd.nii.gz $ZAP/TMSfMRI_EvokedResponse_Measures/data
done < $ZAP/ZAPR01_DWI_TMSfMRI_FinalSample.txt

while read line ; do
SUBJ=${line#*1}

#PreIFG (Amygdala site of stimulation)
##HO Subcortical
3dROIstats -mask /share/apps/fsl/5.0.8/data/atlases/HarvardOxford/HarvardOxford-sub-maxprob-thr25-2mm.nii.gz -nobriklab -1DRformat $ZAP/TMSfMRI_EvokedResponse_Measures/data/ZAPR01_${SUBJ}_sp120_PreIFG_sigchange_contrast1_TMSonStd.nii.gz >> $ZAP/TMSfMRI_EvokedResponse_Measures/measures/subject_measures/$SUBJ-PreIFG-HO25-Subcortical.csv
data=$(sed -n "2p" $ZAP/TMSfMRI_EvokedResponse_Measures/measures/subject_measures/$SUBJ-PreIFG-HO25-Subcortical.csv)
echo "sub-ZAPR01$SUBJ	$data" >> $ZAP/TMSfMRI_EvokedResponse_Measures/measures/PreAmygdala_TMSfMRI_EvokedResponse_HO25_Subcortical.csv

3dROIstats -mask /share/apps/fsl/5.0.8/data/atlases/HarvardOxford/HarvardOxford-sub-maxprob-thr50-2mm.nii.gz -nobriklab -1DRformat $ZAP/TMSfMRI_EvokedResponse_Measures/data/ZAPR01_${SUBJ}_sp120_PreIFG_sigchange_contrast1_TMSonStd.nii.gz >> $ZAP/TMSfMRI_EvokedResponse_Measures/measures/subject_measures/$SUBJ-PreIFG-HO50-Subcortical.csv
data=$(sed -n "2p" $ZAP/TMSfMRI_EvokedResponse_Measures/measures/subject_measures/$SUBJ-PreIFG-HO50-Subcortical.csv)
echo "sub-ZAPR01$SUBJ	$data" >> $ZAP/TMSfMRI_EvokedResponse_Measures/measures/PreAmygdala_TMSfMRI_EvokedResponse_HO50_Subcortical.csv

##sgACC 
3dROIstats -mask /data/jux/oathes_group/projects/romain/ROIs/ListonSG.nii.gz -nobriklab -1DRformat $ZAP/TMSfMRI_EvokedResponse_Measures/data/ZAPR01_${SUBJ}_sp120_PreIFG_sigchange_contrast1_TMSonStd.nii.gz >> $ZAP/TMSfMRI_EvokedResponse_Measures/measures/subject_measures/$SUBJ-PreIFG-sgACC.csv
data=$(sed -n "2p" $ZAP/TMSfMRI_EvokedResponse_Measures/measures/subject_measures/$SUBJ-PreIFG-sgACC.csv)
echo "sub-ZAPR01$SUBJ	$data" >> $ZAP/TMSfMRI_EvokedResponse_Measures/measures/PreAmygdala_TMSfMRI_EvokedResponse_sgACC.csv

#PreSgACC (sgACC site of stimulation)
##HO Subcortical
3dROIstats -mask /share/apps/fsl/5.0.8/data/atlases/HarvardOxford/HarvardOxford-sub-maxprob-thr25-2mm.nii.gz -nobriklab -1DRformat $ZAP/TMSfMRI_EvokedResponse_Measures/data/ZAPR01_${SUBJ}_sp120_PreSgACC*_sigchange_contrast1_TMSonStd.nii.gz >> $ZAP/TMSfMRI_EvokedResponse_Measures/measures/subject_measures/$SUBJ-PreSgACC-HO25-Subcortical.csv
data=$(sed -n "2p" $ZAP/TMSfMRI_EvokedResponse_Measures/measures/subject_measures/$SUBJ-PreSgACC-HO25-Subcortical.csv)
echo "sub-ZAPR01$SUBJ	$data" >> $ZAP/TMSfMRI_EvokedResponse_Measures/measures/PreSgACC_TMSfMRI_EvokedResponse_HO25_Subcortical.csv

3dROIstats -mask /share/apps/fsl/5.0.8/data/atlases/HarvardOxford/HarvardOxford-sub-maxprob-thr50-2mm.nii.gz -nobriklab -1DRformat $ZAP/TMSfMRI_EvokedResponse_Measures/data/ZAPR01_${SUBJ}_sp120_PreSgACC*_sigchange_contrast1_TMSonStd.nii.gz >> $ZAP/TMSfMRI_EvokedResponse_Measures/measures/subject_measures/$SUBJ-PreSgACC-HO50-Subcortical.csv
data=$(sed -n "2p" $ZAP/TMSfMRI_EvokedResponse_Measures/measures/subject_measures/$SUBJ-PreSgACC-HO50-Subcortical.csv)
echo "sub-ZAPR01$SUBJ	$data" >> $ZAP/TMSfMRI_EvokedResponse_Measures/measures/PreSgACC_TMSfMRI_EvokedResponse_HO50_Subcortical.csv

##sgACC
3dROIstats -mask /data/jux/oathes_group/projects/romain/ROIs/ListonSG.nii.gz -nobriklab -1DRformat $ZAP/TMSfMRI_EvokedResponse_Measures/data/ZAPR01_${SUBJ}_sp120_PreSgACC*_sigchange_contrast1_TMSonStd.nii.gz >> $ZAP/TMSfMRI_EvokedResponse_Measures/measures/subject_measures/$SUBJ-PreSgACC-sgACC.csv
data=$(sed -n "2p" $ZAP/TMSfMRI_EvokedResponse_Measures/measures/subject_measures/$SUBJ-PreSgACC-sgACC.csv)
echo "sub-ZAPR01$SUBJ	$data" >> $ZAP/TMSfMRI_EvokedResponse_Measures/measures/PreSgACC_TMSfMRI_EvokedResponse_sgACC.csv

done < $ZAP/ZAPR01_DWI_TMSfMRI_FinalSample.txt
