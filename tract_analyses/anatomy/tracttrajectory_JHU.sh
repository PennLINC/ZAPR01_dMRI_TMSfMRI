#!/bin/bash

#Map vlPFC-amygdala pathway to JHU tracts

ZAP=/storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI

3dROIstats -mask /usr/local/fsl/data/atlases/JHU/JHU-ICBM-tracts-maxprob-thr0-1mm.nii.gz -nobriklab -nomeanout -nzvozels -1DRformat $ZAP//mrtrix_fixelanalysis/siteofstim_subcortical_tracts/voxels/AmygdalaSOS-LHAmygdalaROI25-tractvoxels-bin-inMNIspace.nii.gz >> $ZAP/output_measures/tract_trajectory_JHU/pathway_JHUtracts_overlap.csv
