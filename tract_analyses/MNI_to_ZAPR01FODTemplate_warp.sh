#!/bin/bash

#Generate an MNI to ZAPR01 FOD Template warp, based on registration of the HCP FA Template to a study-specific FA Template generated in FOD Template space

ZAP=/storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI

#CREATE A STUDY-SPECIFIC FA TEMPLATE

cd $ZAP/qsiprep_0.6.3
for SUBJ in sub* ; do

#generate subject DTI
/storage/3Tissue/bin/dwi2tensor $ZAP/mrtrix_fixelanalysis/subject_data/${SUBJ}/${SUBJ}-acq-DTIb1000mb2dir64-preproc_dwi-biascorrect.mif $ZAP/mrtrix_fixelanalysis/subject_data/${SUBJ}/${SUBJ}-acq-DTIb1000mb2dir64-preproc_dwi-tensormap.mif

#generate subject FA map 
/storage/3Tissue/bin/tensor2metric $ZAP/mrtrix_fixelanalysis/subject_data/${SUBJ}/${SUBJ}-acq-DTIb1000mb2dir64-preproc_dwi-tensormap.mif -fa $ZAP/mrtrix_fixelanalysis/subject_data/${SUBJ}/${SUBJ}-acq-DTIb1000mb2dir64-preproc_dwi-FAmap.mif -mask $ZAP/mrtrix_fixelanalysis/subject_data/${SUBJ}/${SUBJ}-acq-DTIb1000mb2dir64-preproc_dwi-brainmask-dilated.mif  

#warp subject FA map to the ZAPR01 FOD Template
/storage/3Tissue/bin/mrtransform $ZAP/mrtrix_fixelanalysis/subject_data/${SUBJ}/${SUBJ}-acq-DTIb1000mb2dir64-preproc_dwi-FAmap.mif -warp $ZAP/mrtrix_fixelanalysis/subject_data/$SUBJ/${SUBJ}-subFOD2PopulationTemplateFOD_warp.mif -interp cubic $ZAP/mrtrix_fixelanalysis/subject_data/${SUBJ}/${SUBJ}-acq-DTIb1000mb2dir64-preproc_dwi-FAmap-inFODTemplate.mif

done

#merge subject FA maps into one file
/storage/3Tissue/bin/mrcat $ZAP/mrtrix_fixelanalysis/subject_data/*/*dwi-FAmap-inFODTemplate.mif $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FA_Template_Series.mif 

#create a mean ZAPR01 FA Template
/storage/3Tissue/bin/mrmath $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FA_Template_Series.mif mean $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FA_Template.mif -axis 3 #take the mean of the 4D series to generate a mean FA map
/storage/3Tissue/bin/mrconvert $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FA_Template.mif $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FA_Template.nii.gz #convert FA mif to nifti to work with ANTS

#create a mask for the FA Template
/storage/3Tissue/bin/mrconvert $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FOD_Template.mif -coord 3 0 -axes 0,1,2 $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FOD_Template_l0.mif
/storage/3Tissue/bin/mrconvert  $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FOD_Template_l0.mif  $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FOD_Template_l0.nii.gz 
fslmaths $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FOD_Template_l0.nii.gz -thr 0.001 $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FOD_Template_l0.nii.gz
fslmaths $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FOD_Template_l0.nii.gz -bin $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FA_Template-mask.nii.gz
rm $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FOD_Template_l0.nii.gz
fslmaths $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FA_Template-mask.nii.gz -ero $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FA_Template-mask.nii.gz
fslmaths $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FA_Template-mask.nii.gz -ero $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FA_Template-mask.nii.gz
fslmaths $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FA_Template-mask.nii.gz -ero $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FA_Template-mask.nii.gz

fslmaths $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FA_Template.nii.gz -mul $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FA_Template-mask.nii.gz $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FA_Template.nii.gz


#REGISTER HCP FA TEMPLATE TO ZAPR01 FA TEMPLATE

#upsample HCP FA Template to ZAPR01 FA Template resolution
ResampleImage 3 /usr/local/fsl/data/standard/FSL_HCP1065_FA_1mm.nii.gz $ZAP/templates/FSL_HCP1065_FA_1.3mm.nii.gz 1.3X1.3X1.3 0 4

#register HCP Template to ZAPR01 Template
antsRegistrationSyN.sh -d 3 -m $ZAP/templates/FSL_HCP1065_FA_1.3mm.nii.gz -f $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FA_Template.nii.gz  -o $ZAP/templates/FSL_HCP1065_FA_1.3mm-inFODTemplate

