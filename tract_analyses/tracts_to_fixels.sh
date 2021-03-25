#!/bin/bash

#Map tractography streamlines back to fixels

ZAP=/storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI
mkdir $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/fixels

/storage/3Tissue/bin/tck2fixel $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/tractography/AmygdalaSOS-LHAmygdalaROI25-tracts.tck $ZAP/mrtrix_fixelanalysis/population_template/ZAPR01_FixelMask $ZAP/mrtrix_fixelanalysis/siteofstim_subcortical_tracts/fixels/AmygdalaSOS-LHAmygdalaROI25-fixels AmygdalaSOS-LHAmygdalaROI25-TDI.mif
