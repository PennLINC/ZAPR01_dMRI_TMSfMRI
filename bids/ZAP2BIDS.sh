#!/bin/bash

# ------------------------------ HELP ------------------------------ #

if [ "$1" == "--help" ] || [ "$1" == "-h" ] || [ $# == 0 ]
then

RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'
PINK='\033[01;35m'
	
	echo -e "
---------------------------------
	
	Description: Script to convert ZAPR01 Data (Legacy and Newly Acquired) to BIDS using heudiconv with singularity

	${BLUE}[Template call]${NC}
		sh ZAP2BIDS.sh [user] [heuristic file path + filename]

	${BLUE}[Example call]${NC}
		sh ZAP2BIDS.sh vsydnor /data/jux/oathes_group/projects/vsydnor/scripts/ZAP2BIDS/ZAPR01_legacyandnew_heuristic.py

	${RED}[Arguments]${NC} 
		user: chead username
		heuristic: full path to the python heuristic file 

	${PINK}[More Help:]${NC}
	For heudiconv-specific details, see https://heudiconv.readthedocs.io/en/latest/usage.html

	BIDS specifications for MRI data: https://bids-specification.readthedocs.io/en/latest/04-modality-specific-files/01-magnetic-resonance-imaging-data.html
$case
	BIDS Validator: http://bids-standard.github.io/bids-validator/

	JSON Validator: https://jsonlint.com/

----------------------------------
		"
	exit 0
fi


########################################## DEFINE SCRIPT VARIABLES #######################################################

#Define command-line user input variables
user=$1 #cluster username
heuristic=$2 #study-specific heudiconv heuristic

#Specify heudiconv version
heudiconvversion=/data/jag/cnds/applications/heudiconv/heudiconv-0.5.4.simg #heudiconv singularity image to use

#Define dicom, BIDS output, and heudiconv log file paths
Dicompath=/data/jag/cnds/TNI_ZapR01/SubjectsData #path to where subject folders with dicoms exist

BIDSpath=/data/jux/oathes_group/studies/TNI_ZAPR01/MRI/BIDS #path to output BIDS root directory
if ! [ -d $BIDSpath ]
then
mkdir $BIDSpath #create BIDS root directory if it does not already exist
cd $BIDSpath
touch .bidsignore #create a .bidsignore file and autofill
echo "*asl*" >> .bidsignore #ignore asl/ directories and files, as these are not currently supported by BIDS
echo "*Baseline-BIDS-summary*csv*" >> .bidsignore #ignore Baseline log file
echo "*TMSfMRI-BIDS-summary*csv*" >> .bidsignore #ignore TMSfMRI log file
echo "*DSI-BIDS-summary*csv*" >> .bidsignore #ignore DSI log file
fi

Logspath=/data/jux/oathes_group/projects/vsydnor/ZAPR01/heudiconv_logs #path to where logs with heudiconv command output will be written for each subject (stdout and stderr from running heudiconv). Check these to ensure heudiconv ran correctly, or to identify a dcm2niix conversion issues.  
if ! [ -d $Logspath ]
then
mkdir $Logspath #create log directory if it does not already exist
fi

##########################################################################################################################




################################################ RUN HEUDICONV ###########################################################


for i in $(ls /data/jag/cnds/TNI_ZapR01/SubjectsData); do #script will automatically run on ZAPR01* cases in this directory that do not already have a subject folder in the $BIDSpath (i.e., the BIDS root directory)
if [[ $i == ZAPR01* ]] ; then #only run on ZAPR01* subjects, not on TNI* subjects
case=$i
caseid=${i#*_}

if ! [ -d $BIDSpath/sub-ZAPR01$caseid ] ; then
echo "Converting $case to BIDS"

	#ORGANIZE INPUT SUBJECT FOLDERS TO BE BIDS CONVERSION COMPATIBLE 	

	#Move Baseline localizer dicoms into /Localizers/Dicom
	mkdir $Dicompath/$case/Baseline/Localizers/Dicom
	mv $Dicompath/$case/Baseline/Localizers/*dcm $Dicompath/$case/Baseline/Localizers/Dicom	
	
	#Rename TMS_fMRI directory to TMSfMRI for BIDS <session> compatibility
	mv $Dicompath/$case/TMS_fMRI $Dicompath/$case/TMSfMRI

	#Rename TMSfMRI session subject directory by appropriate TMS target ROI + sequence information to allow for correct scan identification in heuristic
	for ROI in IFG sgACC ; do 
	cd $Dicompath/$case/TMSfMRI/$ROI
	
		for dir in * ; do
		mv $dir/Dicom $dir/Dicom_${ROI}_${dir}
		done
	done

	#RUN HEUDICONV WITH SINGULARITY TO CONVERT BASELINE, TMSFMRI, AND DSI SESSIONS TO BIDS 

	#Baseline session	
	if [ -d $Dicompath/$case/Baseline ]
	then
	echo "Processing Baseline session for $case"
	/share/apps/singularity/2.5.1/bin/singularity run -B /data:/home/${user}/data -e $heudiconvversion -d /home/${user}${Dicompath}/{subject}/{session}/*/Dicom/*dcm -s $case -ss Baseline -f /home/${user}$heuristic -c dcm2niix -b -o /home/${user}$BIDSpath &> $Logspath/${case}-heudiconv-Baseline-log.txt 
	else
	echo "$case missing Baseline session"
	fi

	#TMSfMRI session
	if [ -d $Dicompath/$case/TMSfMRI ] 
	then
	echo "Processing TMSfMRI session for $case"
	/share/apps/singularity/2.5.1/bin/singularity run -B /data:/home/${user}/data -e $heudiconvversion -d /home/${user}${Dicompath}/{subject}/{session}/*/*/Dicom*/*dcm -s $case -ss TMSfMRI -f /home/${user}$heuristic -c dcm2niix -b -o /home/${user}$BIDSpath &> $Logspath/${case}-heudiconv-TMSfMRI-log.txt
	else
	echo "$case missing TMSfMRI session"
	fi

	#DSI session
	if [ -d $Dicompath/$case/DSI ]
	then
	echo "Processing DSI session for $case"
	/share/apps/singularity/2.5.1/bin/singularity run -B /data:/home/${user}/data -e $heudiconvversion -d /home/${user}${Dicompath}/{subject}/{session}/*/Dicom/*dcm -s $case -ss DSI -f /home/${user}$heuristic -c dcm2niix -b -o /home/${user}$BIDSpath &> $Logspath/${case}-heudiconv-DSI-log.txt
	else
	echo "$case missing DSI session"
	fi


##########################################################################################################################




################################ ADD INTENDED FOR SPECIFICATIONS TO FIELD MAPS ############################################

#Heudiconv run through singularity currently does not allow for heuristic-based addition of IntendedFor fields to fieldmap jsons. These must be added to fieldmap jsons with the code below in order for fmriprep and qsiprep to recognize the existence of available fieldmaps and use them for pre-processing.


chmod -R 771 $BIDSpath #make sure json files are writeable

#BASELINE SESSION: Add IntendedFor fields to spin echo fmaps and phasediff/mag fmaps

#add baseline resting AP nifti as "IntededFor" for baseline spin echo PA fmap
if [ -e $BIDSpath/sub-ZAPR01${caseid}/ses-Baseline/func/*ses-Baseline_task-rest_acq-TR2s_dir-AP_bold.nii.gz ] ; then #check whether the resting AP scan exists
intendedfor="\"IntendedFor\": \"ses-Baseline/func/sub-ZAPR01${caseid}_ses-Baseline_task-rest_acq-TR2s_dir-AP_bold.nii.gz\"," #define IntendedFor
sed -i "1 a \ \ $intendedfor" $BIDSpath/sub-ZAPR01${caseid}/ses-Baseline/fmap/sub-ZAPR01${caseid}_ses-Baseline_acq-spinecho_dir-PA_epi.json #append IntendedFor to spin echo PA json
fi

#add baseline resting PA nifti as "IntendedFor" for baseline spin echo AP fmap
if [ -e $BIDSpath/sub-ZAPR01${caseid}/ses-Baseline/func/*ses-Baseline_task-rest_acq-TR2s_dir-PA_bold.nii.gz ] ; then #check whether the resting PA scan exists
intendedfor="\"IntendedFor\": \"ses-Baseline/func/sub-ZAPR01${caseid}_ses-Baseline_task-rest_acq-TR2s_dir-PA_bold.nii.gz\"," #define IntendedFor
sed -i "1 a \ \ $intendedfor" $BIDSpath/sub-ZAPR01${caseid}/ses-Baseline/fmap/sub-ZAPR01${caseid}_ses-Baseline_acq-spinecho_dir-AP_epi.json #append IntendedFor to spin echo AP json
fi

#add nback and DTI niftis as "IntendedFor" for baseline B0 maps (phase diff, magnitude1, magnitude2), if both nback and DTI were acquired
if [ -e $BIDSpath/sub-ZAPR01${caseid}/ses-Baseline/func/sub-ZAPR01${caseid}_ses-Baseline_task-nback02_run-01_bold.nii.gz ] && [ -e $BIDSpath/sub-ZAPR01${caseid}/ses-Baseline/dwi/sub-ZAPR01${caseid}_ses-Baseline_acq-DTIb1000mb2dir64_dwi.nii.gz ] ; then #check whether nback and DTI both exist
intendedfor="\"IntendedFor\": [\"ses-Baseline/func/sub-ZAPR01${caseid}_ses-Baseline_task-nback02_run-01_bold.nii.gz\",\"ses-Baseline/dwi/sub-ZAPR01${caseid}_ses-Baseline_acq-DTIb1000mb2dir64_dwi.nii.gz\"]," #define IntendedFor 
sed -i "1 a \ \ $intendedfor" $BIDSpath/sub-ZAPR01${caseid}/ses-Baseline/fmap/sub-ZAPR01${caseid}_ses-Baseline_magnitude1.json #append IntendedFor to B0 jsons
sed -i "1 a \ \ $intendedfor" $BIDSpath/sub-ZAPR01${caseid}/ses-Baseline/fmap/sub-ZAPR01${caseid}_ses-Baseline_magnitude2.json
sed -i "1 a \ \ $intendedfor" $BIDSpath/sub-ZAPR01${caseid}/ses-Baseline/fmap/sub-ZAPR01${caseid}_ses-Baseline_phasediff.json

#add nback nifti as "IntededFor" for baseline B0 maps (phase diff, magnitude1, magnitude2) if only nback acquired
elif [ -e $BIDSpath/sub-ZAPR01${caseid}/ses-Baseline/func/sub-ZAPR01${caseid}_ses-Baseline_task-nback02_run-01_bold.nii.gz ] ;then #check if nback exists
intendedfor="\"IntendedFor\": \"ses-Baseline/func/sub-ZAPR01${caseid}_ses-Baseline_task-nback02_run-01_bold.nii.gz\"," #define IntendedFor
sed -i "1 a \ \ $intendedfor" $BIDSpath/sub-ZAPR01${caseid}/ses-Baseline/fmap/sub-ZAPR01${caseid}_ses-Baseline_magnitude1.json #append IntendedFor to B0 jsons
sed -i "1 a \ \ $intendedfor" $BIDSpath/sub-ZAPR01${caseid}/ses-Baseline/fmap/sub-ZAPR01${caseid}_ses-Baseline_magnitude2.json
sed -i "1 a \ \ $intendedfor" $BIDSpath/sub-ZAPR01${caseid}/ses-Baseline/fmap/sub-ZAPR01${caseid}_ses-Baseline_phasediff.json

#add DTI nifti as "IntededFor" for baseline B0 maps (phase diff, magnitude1, magnitude2) if only DTI acquired
else  [ -e $BIDSpath/sub-ZAPR01${caseid}/ses-Baseline/dwi/sub-ZAPR01${caseid}_ses-Baseline_acq-DTIb1000mb2dir64_dwi.nii.gz ] #check if DTI exists
intendedfor="\"IntendedFor\": \"ses-Baseline/dwi/sub-ZAPR01${caseid}_ses-Baseline_acq-DTIb1000mb2dir64_dwi.nii.gz\"," #define IntendedFor 
sed -i "1 a \ \ $intendedfor" $BIDSpath/sub-ZAPR01${caseid}/ses-Baseline/fmap/sub-ZAPR01${caseid}_ses-Baseline_magnitude1.json #append IntendedFor to B0 jsons
sed -i "1 a \ \ $intendedfor" $BIDSpath/sub-ZAPR01${caseid}/ses-Baseline/fmap/sub-ZAPR01${caseid}_ses-Baseline_magnitude2.json
sed -i "1 a \ \ $intendedfor" $BIDSpath/sub-ZAPR01${caseid}/ses-Baseline/fmap/sub-ZAPR01${caseid}_ses-Baseline_phasediff.json
fi


#TMSfMRI SESSION: Add IntendedFor fields phasediff/mag fmaps for IFG and sgACC ROIs

intendedforIFG="\"IntendedFor\": [\"ses-TMSfMRI/func/sub-ZAPR01${caseid}_ses-TMSfMRI_task-iTBS_acq-IFG_run-01_bold.nii.gz\",\"ses-TMSfMRI/func/sub-ZAPR01${caseid}_ses-TMSfMRI_task-rest_acq-PostIFG_run-01_bold.nii.gz\", \"ses-TMSfMRI/func/sub-ZAPR01${caseid}_ses-TMSfMRI_task-rest_acq-PreIFG_run-01_bold.nii.gz\",\"ses-TMSfMRI/func/sub-ZAPR01${caseid}_ses-TMSfMRI_task-SP120_acq-PostIFG_run-01_bold.nii.gz\",\"ses-TMSfMRI/func/sub-ZAPR01${caseid}_ses-TMSfMRI_task-SP120_acq-PreIFG_run-01_bold.nii.gz\"]," #define IntendedFor
sed -i "1 a \ \ $intendedforIFG" $BIDSpath/sub-ZAPR01${caseid}/ses-TMSfMRI/fmap/sub-ZAPR01${caseid}_ses-TMSfMRI_acq-IFG_magnitude1.json #append IntendedFor to B0 jsons
sed -i "1 a \ \ $intendedforIFG" $BIDSpath/sub-ZAPR01${caseid}/ses-TMSfMRI/fmap/sub-ZAPR01${caseid}_ses-TMSfMRI_acq-IFG_magnitude2.json
sed -i "1 a \ \ $intendedforIFG" $BIDSpath/sub-ZAPR01${caseid}/ses-TMSfMRI/fmap/sub-ZAPR01${caseid}_ses-TMSfMRI_acq-IFG_phasediff.json

intendedforsgACC="\"IntendedFor\": [\"ses-TMSfMRI/func/sub-ZAPR01${caseid}_ses-TMSfMRI_task-iTBS_acq-sgACC_run-01_bold.nii.gz\",\"ses-TMSfMRI/func/sub-ZAPR01${caseid}_ses-TMSfMRI_task-rest_acq-PostsgACC_run-01_bold.nii.gz\", \"ses-TMSfMRI/func/sub-ZAPR01${caseid}_ses-TMSfMRI_task-rest_acq-PresgACC_run-01_bold.nii.gz\",\"ses-TMSfMRI/func/sub-ZAPR01${caseid}_ses-TMSfMRI_task-SP120_acq-PostsgACC_run-01_bold.nii.gz\",\"ses-TMSfMRI/func/sub-ZAPR01${caseid}_ses-TMSfMRI_task-SP120_acq-PresgACC_run-01_bold.nii.gz\"]," #define IntendedFor
sed -i "1 a \ \ $intendedforsgACC" $BIDSpath/sub-ZAPR01${caseid}/ses-TMSfMRI/fmap/sub-ZAPR01${caseid}_ses-TMSfMRI_acq-sgACC_magnitude1.json #append IntendedFor to b0 jsons
sed -i "1 a \ \ $intendedforsgACC" $BIDSpath/sub-ZAPR01${caseid}/ses-TMSfMRI/fmap/sub-ZAPR01${caseid}_ses-TMSfMRI_acq-sgACC_magnitude2.json
sed -i "1 a \ \ $intendedforsgACC" $BIDSpath/sub-ZAPR01${caseid}/ses-TMSfMRI/fmap/sub-ZAPR01${caseid}_ses-TMSfMRI_acq-sgACC_phasediff.json


else
echo "$case already exists in BIDS output directory! Will not attempt to re-process."
fi

fi
done
###########################################################################################################################




###################################### CHECK FOR BIDS CONVERSION OUTPUTS  ##################################################

#Check whether output BIDS formatted niftis exist for Baseline, TMSfMRI and DSI sessions and create log csv files.
#Separate logs will be created for Baseline, TMSfMRI and DSI sessions. Log headers indicate subject and scan type expected from BIDS conversion. Each line of the file has file conversion information for a specific subject - "0" indicates a scan was not found, "1" indicates scan was found.

timestamp=$(date +%m%d%y) #timestamp to append to output log csv files

echo "Case,T1w,RestAP,RestPA,Nback,DTI64,ASL,CBF,FmapPh,FmapM1,FmapM2,SpinEchoAP,SpinEchoPA" > $BIDSpath/Baseline-BIDS-summary-${timestamp}.csv #create log header

echo "Case,preIFGrest,preIFGsp80,preIFGsp100,preIFGsp120,IFGiTBS,postIFGsp120,postIFGrest,preSgACCrest,preSgACCsp80,preSgACCsp100,preSgACCsp120,SgACCiTBS,postSgACCsp120,postSgACCrest,IFGFmapPh,IFGFmapM1,IFGFmapM2,SgACCFmapPh,SgACCFmapM1,SgACCFmapM2" > $BIDSpath/TMSfMRI-BIDS-summary-${timestamp}.csv #create log header

echo "Case,DSI72,DSI493,T2w" > $BIDSpath/DSI-BIDS-summary-${timestamp}.csv #create log header

for i in $BIDSpath/sub-ZAPR01*
do
case=${i##*/}

	#BASELINE LOG	

	#T1 check
	if [ -e $BIDSpath/$case/ses-Baseline/anat/*acq-MPR_T1w.nii.gz ]
	then
	T1w_rep="1" ; else T1w_rep="0"
	fi

	#resting AP check
	if [ -e $BIDSpath/$case/ses-Baseline/func/*task-rest_acq-TR2s_dir-AP_bold.nii.gz ]
	then
	restAP_rep="1" ; else restAP_rep="0"
	fi

	#resting PA check
	if [ -e $BIDSpath/$case/ses-Baseline/func/*task-rest_acq-TR2s_dir-PA_bold.nii.gz ]
	then
	restPA_rep="1" ; else restPA_rep="0"
	fi
		
	#nback check
	if [ -e $BIDSpath/$case/ses-Baseline/func/*task-nback02_run-01_bold.nii.gz ]
	then
	Nback_rep="1" ; else Nback_rep="0"
	fi

	#DTI check
	if [ -e $BIDSpath/$case/ses-Baseline/dwi/*acq-DTIb1000mb2dir64_dwi.nii.gz ]
	then
	DTI_rep="1" ; else DTI_rep="0"
	fi

	#ASL check
	if [ -e $BIDSpath/$case/ses-Baseline/asl/*acq-spiralv20pf68accel1d_asl.nii.gz ]
	then
	ASL_rep="1" ; else ASL_rep="0"
	fi

	#CBF map check
	if [ -e $BIDSpath/$case/ses-Baseline/asl/*acq-spiralv20pf68accel1d_CBF.nii.gz ]
	then
	CBF_rep="1" ; else CBF_rep="0"
	fi

	#phasediff fmap check
	if [ -e $BIDSpath/$case/ses-Baseline/fmap/*_phasediff.nii.gz ]
	then
	FmapPh_rep="1" ; else FmapPh_rep="0"
	fi

	#magnitude1 fmap check
	if [ -e $BIDSpath/$case/ses-Baseline/fmap/*_magnitude1.nii.gz ]
        then
        FmapM1_rep="1" ; else FmapM1_rep="0"
        fi

	#magnitude2 fmap check
	if [ -e $BIDSpath/$case/ses-Baseline/fmap/*_magnitude2.nii.gz ]
        then
        FmapM2_rep="1" ; else FmapM2_rep="0"
        fi

	#spin echo fmap AP check
	if [ -e $BIDSpath/$case/ses-Baseline/fmap/*acq-spinecho_dir-AP_epi.nii.gz ]
        then
        FmapSEAP_rep="1" ; else FmapSEAP_rep="0"
        fi

	#spin echo fmap PA check
        if [ -e $BIDSpath/$case/ses-Baseline/fmap/*acq-spinecho_dir-PA_epi.nii.gz ]
        then
        FmapSEPA_rep="1" ; else FmapSEPA_rep="0"
        fi

	isub_summary="${case},$T1w_rep,$restAP_rep,$restPA_rep,$Nback_rep,$DTI_rep,$ASL_rep,$CBF_rep,$FmapPh_rep,$FmapM1_rep,$FmapM2_rep,$FmapSEAP_rep,$FmapSEPA_rep"

	echo $isub_summary >> $BIDSpath/Baseline-BIDS-summary-${timestamp}.csv

	#TMSfMRI LOG
	
	#PreIFG resting check
	if [ -e $BIDSpath/$case/ses-TMSfMRI/func/*task-rest_acq-PreIFG_run-01_bold.nii.gz ]
	then
	preIFGrest_rep="1" ; else preIFGrest_rep="0"
	fi

	#PreIFG sp80 check
	if [ -e $BIDSpath/$case/ses-TMSfMRI/func/*task-SP80_acq-PreIFG_run-01_bold.nii.gz ]
        then
        preIFGsp80_rep="1" ; else preIFGsp80_rep="0"
        fi

	#PreIFG sp100 check
	if [ -e $BIDSpath/$case/ses-TMSfMRI/func/*task-SP100_acq-PreIFG_run-01_bold.nii.gz ]
        then
        preIFGsp100_rep="1" ; else preIFGsp100_rep="0"
        fi

	#PreIFG sp120 check
	if [ -e $BIDSpath/$case/ses-TMSfMRI/func/*task-SP120_acq-PreIFG_run-01_bold.nii.gz ]
        then
        preIFGsp120_rep="1" ; else preIFGsp120_rep="0"
        fi

	#IFG iTBS check
	if [ -e $BIDSpath/$case/ses-TMSfMRI/func/*task-iTBS_acq-IFG_run-01_bold.nii.gz  ]
        then
        IFGiTBS_rep="1" ; else IFGiTBS_rep="0"
        fi
	
	#PostIFG sp120 check
	if [ -e $BIDSpath/$case/ses-TMSfMRI/func/*task-SP120_acq-PostIFG_run-01_bold.nii.gz ]
        then
        postIFGsp120_rep="1" ; else postIFGsp120_rep="0"
        fi

	#PostIFG resting check
	if [ -e $BIDSpath/$case/ses-TMSfMRI/func/*task-rest_acq-PostIFG_run-01_bold.nii.gz ]
	then 
	postIFGrest_rep="1" ; else postIFGrest_rep="0" 
	fi

	#PresgACC resting check
	if [ -e $BIDSpath/$case/ses-TMSfMRI/func/*task-rest_acq-PresgACC_run-01_bold.nii.gz ]
        then
        presgACCrest_rep="1" ; else presgACCrest_rep="0"
        fi

	#PresgACC sp80 check
	if [ -e $BIDSpath/$case/ses-TMSfMRI/func/*task-SP80_acq-PresgACC_run-01_bold.nii.gz ]
        then
        presgACCsp80_rep="1" ; else presgACCsp80_rep="0"
        fi

	#PresgACC sp100 check
	if [ -e $BIDSpath/$case/ses-TMSfMRI/func/*task-SP100_acq-PresgACC_run-01_bold.nii.gz ]
        then
        presgACCsp100_rep="1" ; else presgACCsp100_rep="0"
        fi

	#PresgACC sp120 check
	if [ -e $BIDSpath/$case/ses-TMSfMRI/func/*task-SP120_acq-PresgACC_run-01_bold.nii.gz ]
        then
        presgACCsp120_rep="1" ; else presgACCsp120_rep="0"
        fi

	#sgACC iTBS check
	if [ -e $BIDSpath/$case/ses-TMSfMRI/func/*task-iTBS_acq-sgACC_run-01_bold.nii.gz ]
	then 
	iTBS_sgACC_rep="1" ; else iTBS_sgACC_rep="0" 
	fi

	#PostsgACC sp120 check
	if [ -e $BIDSpath/$case/ses-TMSfMRI/func/*task-SP120_acq-PostsgACC_run-01_bold.nii.gz ]
	then 
	postsgACCsp120_rep="1" ; else postsgACCsp120_rep="0" 
	fi

	#PostsgACC resting check
	if [ -e $BIDSpath/$case/ses-TMSfMRI/func/*task-rest_acq-PostsgACC_run-01_bold.nii.gz ]
	then 
	postsgACCrest_rep="1" ; else postsgACCrest_rep="0" 
	fi

	#IFG phasediff fmap check
	if [ -e $BIDSpath/$case/ses-TMSfMRI/fmap/*acq-IFG_phasediff.nii.gz ] 
	then 
	ph_IFG_rep="1" ; else	ph_IFG_rep="0" 
	fi

	#IFG magnitude1 fmap check
	if [ -e $BIDSpath/$case/ses-TMSfMRI/fmap/*acq-IFG_magnitude1.nii.gz ] 
	then 
	mag1_IFG_rep="1" ; else mag1_IFG_rep="0" 
	fi

	#IFG magnitude2 fmap check
	if [ -e $BIDSpath/$case/ses-TMSfMRI/fmap/*acq-IFG_magnitude2.nii.gz ] 
	then 
	mag2_IFG_rep="1" ; else mag2_IFG_rep="0" 
	fi

	#sgACC phasediff fmap check
	if [ -e $BIDSpath/$case/ses-TMSfMRI/fmap/*acq-sgACC_phasediff.nii.gz ]
	then 
	ph_sgACC_rep="1" ; else	ph_sgACC_rep="0" 
	fi

	#sgACC magnitude1 fmap check
	if [ -e $BIDSpath/$case/ses-TMSfMRI/fmap/*acq-sgACC_magnitude1.nii.gz ]
	then 
	mag1_sgACC_rep="1" ; else mag1_sgACC_rep="0" 
	fi

	#sgACC magnitude2 fmap check
	if [ -e $BIDSpath/$case/ses-TMSfMRI/fmap/*acq-sgACC_magnitude2.nii.gz ]
	then 
	mag2_sgACC_rep="1" ; else mag2_sgACC_rep="0" 
	fi

	isub_summary="$case,$preIFGrest_rep,$preIFGsp80_rep,$preIFGsp100_rep,$preIFGsp120_rep,$IFGiTBS_rep,$postIFGsp120_rep,$postIFGrest_rep,$presgACCrest_rep,$presgACCsp80_rep,$presgACCsp100_rep,$presgACCsp120_rep,$iTBS_sgACC_rep,$postsgACCsp120_rep,$postsgACCrest_rep,$ph_IFG_rep,$mag1_IFG_rep,$mag2_IFG_rep,$ph_sgACC_rep,$mag1_sgACC_rep,$mag2_sgACC_rep"
	echo $isub_summary >> $BIDSpath/TMSfMRI-BIDS-summary-${timestamp}.csv

	#DSI LOG

	if [ -d $BIDSpath/$case/ses-DSI ] #only check for files for subjects that have ses-DSI
	then
		#DSI 72dir check
		if [ -e $BIDSpath/$case/ses-DSI/dwi/*acq-b5000mb3dir72_dwi.nii.gz ]
		then
		DSI72_rep="1" ; else DSI72_rep="0"
		fi

		#DSI 493dir check
		if [ -e $BIDSpath/$case/ses-DSI/dwi/*acq-b5000mb3dir493_dwi.nii.gz ]
                then
                DSI493_rep="1" ; else DSI493_rep="0"
                fi

		#T2 check
		if [ -e $BIDSpath/$case/ses-DSI/anat/*_T2w.nii.gz ] 
		then 
		T2w_rep="1" ; else T2w_rep="0" 
		fi
	 	
		isub_summary="$case,$DSI72_rep,$DSI493_rep,$T2w_rep"
		echo $isub_summary >> $BIDSpath/DSI-BIDS-summary-${timestamp}.csv 
	fi
done

##########################################################################################################################

