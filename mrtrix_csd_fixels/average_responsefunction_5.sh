#!/bin/bash

##Calculate a study-specific set of 3-tissue response functions (average WM, GM, and CSF response functions from all subjects)

ZAP=/storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI

/storage/3Tissue/bin/responsemean $ZAP/mrtrix_fixelanalysis/response_functions/*WM-response.txt $ZAP/mrtrix_fixelanalysis/response_functions/ZAPR01-WM-responsefunction.txt
/storage/3Tissue/bin/responsemean $ZAP/mrtrix_fixelanalysis/response_functions/*GM-response.txt $ZAP/mrtrix_fixelanalysis/response_functions/ZAPR01-GM-responsefunction.txt
/storage/3Tissue/bin/responsemean $ZAP/mrtrix_fixelanalysis/response_functions/*CSF-response.txt $ZAP/mrtrix_fixelanalysis/response_functions/ZAPR01-CSF-responsefunction.txt  
