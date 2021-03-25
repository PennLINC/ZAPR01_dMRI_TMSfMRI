#!/usr/bin/env python
"""Heuristic for mapping Oathes ZAPR01 scans into BIDS"""
import os


def create_key(template, outtype=('nii.gz',), annotation_classes=None):
    if template is None or not template:
        raise ValueError('Template must be a valid format string')
    return template, outtype, annotation_classes


# **********************************************************************************
# Baseline session

## Localizers
anat_scout = create_key(
    'sub-{subject}/{session}/anat/sub-{subject}_{session}_run-0{item:01d}_scout')
fmap_se_AP = create_key(
    'sub-{subject}/{session}/fmap/sub-{subject}_{session}_acq-spinecho_dir-AP_epi')    
fmap_se_PA = create_key(
    'sub-{subject}/{session}/fmap/sub-{subject}_{session}_acq-spinecho_dir-PA_epi')    

## Functional scans
### Resting state
rest_AP_sbref = create_key(
    'sub-{subject}/{session}/func/sub-{subject}_{session}_task-rest_acq-TR2s_dir-AP_sbref')
rest_AP = create_key(
    'sub-{subject}/{session}/func/sub-{subject}_{session}_task-rest_acq-TR2s_dir-AP_bold')
rest_PA_sbref = create_key(
    'sub-{subject}/{session}/func/sub-{subject}_{session}_task-rest_acq-TR2s_dir-PA_sbref')
rest_PA = create_key(
    'sub-{subject}/{session}/func/sub-{subject}_{session}_task-rest_acq-TR2s_dir-PA_bold')
### nback, single run
nback_02 = create_key(
    'sub-{subject}/{session}/func/sub-{subject}_{session}_task-nback02_run-0{item:01d}_bold')


## Anatomical scans
t1w = create_key(
    'sub-{subject}/{session}/anat/sub-{subject}_{session}_acq-MPR_T1w')

## B0 fmaps
fmap_phPA_baseline = create_key(
    'sub-{subject}/{session}/fmap/sub-{subject}_{session}_phasediff')
fmap_magPA_baseline = create_key(
    'sub-{subject}/{session}/fmap/sub-{subject}_{session}_magnitude')

## DTI scan
dti = create_key(
    'sub-{subject}/{session}/dwi/sub-{subject}_{session}_acq-DTIb1000mb2dir64_dwi')

## ASL Scans
mean_perf = create_key(
    'sub-{subject}/{session}/asl/sub-{subject}_{session}_acq-spiralv20pf68accel1d_CBF')
raw_asl = create_key(
    'sub-{subject}/{session}/asl/sub-{subject}_{session}_acq-spiralv20pf68accel1d_asl')
m0 = create_key(
    'sub-{subject}/{session}/asl/sub-{subject}_{session}_acq-spiralv20pf68accel1d_MZeroScan')
    

#TMSfMRI session 

## ROI: IFG

## Localizer
anat_scout_IFG = create_key(
    'sub-{subject}/{session}/anat/sub-{subject}_{session}_run-0{item:01d}_scout')

## Functional scans 
preIFG_rest = create_key(
    'sub-{subject}/{session}/func/sub-{subject}_{session}_task-rest_acq-PreIFG_run-0{item:01d}_bold')
preIFG_sp80 = create_key(
    'sub-{subject}/{session}/func/sub-{subject}_{session}_task-SP80_acq-PreIFG_run-0{item:01d}_bold')
preIFG_sp100 = create_key(
    'sub-{subject}/{session}/func/sub-{subject}_{session}_task-SP100_acq-PreIFG_run-0{item:01d}_bold')
preIFG_sp120 = create_key(
    'sub-{subject}/{session}/func/sub-{subject}_{session}_task-SP120_acq-PreIFG_run-0{item:01d}_bold')
IFG_iTBS = create_key(
    'sub-{subject}/{session}/func/sub-{subject}_{session}_task-iTBS_acq-IFG_run-0{item:01d}_bold')
postIFG_sp120 = create_key(
    'sub-{subject}/{session}/func/sub-{subject}_{session}_task-SP120_acq-PostIFG_run-0{item:01d}_bold')
postIFG_rest = create_key(
    'sub-{subject}/{session}/func/sub-{subject}_{session}_task-rest_acq-PostIFG_run-0{item:01d}_bold')

## B0 fmaps
fmap_phPA_IFG = create_key(
    'sub-{subject}/{session}/fmap/sub-{subject}_{session}_acq-IFG_phasediff')
fmap_magPA_IFG = create_key(
    'sub-{subject}/{session}/fmap/sub-{subject}_{session}_acq-IFG_magnitude')

## ROI: sgACC

## Localizer
anat_scout_sgACC = create_key(
    'sub-{subject}/{session}/anat/sub-{subject}_{session}_run-0{item:01d}_scout')

## Functional scans 
presgACC_rest = create_key(
    'sub-{subject}/{session}/func/sub-{subject}_{session}_task-rest_acq-PresgACC_run-0{item:01d}_bold')
presgACC_sp80 = create_key(
    'sub-{subject}/{session}/func/sub-{subject}_{session}_task-SP80_acq-PresgACC_run-0{item:01d}_bold')
presgACC_sp100 = create_key(
    'sub-{subject}/{session}/func/sub-{subject}_{session}_task-SP100_acq-PresgACC_run-0{item:01d}_bold')
presgACC_sp120 = create_key(
    'sub-{subject}/{session}/func/sub-{subject}_{session}_task-SP120_acq-PresgACC_run-0{item:01d}_bold')
sgACC_iTBS = create_key(
    'sub-{subject}/{session}/func/sub-{subject}_{session}_task-iTBS_acq-sgACC_run-0{item:01d}_bold')
postsgACC_sp120 = create_key(
    'sub-{subject}/{session}/func/sub-{subject}_{session}_task-SP120_acq-PostsgACC_run-0{item:01d}_bold')
postsgACC_rest = create_key(
    'sub-{subject}/{session}/func/sub-{subject}_{session}_task-rest_acq-PostsgACC_run-0{item:01d}_bold')

## B0 fmaps
fmap_phPA_sgACC = create_key(
    'sub-{subject}/{session}/fmap/sub-{subject}_{session}_acq-sgACC_phasediff')
fmap_magPA_sgACC = create_key(
    'sub-{subject}/{session}/fmap/sub-{subject}_{session}_acq-sgACC_magnitude')

# DSI session

## Localizer
anat_scout_DSI = create_key(
    'sub-{subject}/{session}/anat/sub-{subject}_{session}_run-0{item:01d}_scout')

## Anatomical scans
t2w = create_key(
    'sub-{subject}/{session}/anat/sub-{subject}_{session}_T2w')

## DSI
dsi_493dir = create_key(
    'sub-{subject}/{session}/dwi/sub-{subject}_{session}_acq-b5000mb3dir493_dwi')
dsi_72dir = create_key(
    'sub-{subject}/{session}/dwi/sub-{subject}_{session}_acq-b5000mb3dir72_dwi')



# **********************************************************************************

def infotodict(seqinfo):
    """Heuristic evaluator for determining which runs belong where
    allowed template fields - follow python string module:
    item: index within category
    subject: participant id
    seqitem: run number during scanning
    subindex: sub index within group
    """

    last_run = len(seqinfo)

    info = {

    #Baseline Session
    anat_scout: [],
    fmap_se_AP: [],
    fmap_se_PA: [],
    rest_AP_sbref: [],
    rest_AP: [],
    rest_PA_sbref: [],
    rest_PA: [],
    nback_02: [],
    t1w: [],
    fmap_magPA_baseline: [],
    fmap_phPA_baseline: [],
    dti: [],
    mean_perf: [],
    raw_asl: [],
    m0: [],

    #TMS Session: IFG
    anat_scout_IFG: [],
    preIFG_rest: [],
    preIFG_sp80: [],
    preIFG_sp100: [],
    preIFG_sp120: [],
    IFG_iTBS: [],
    postIFG_sp120: [],
    postIFG_rest: [],
    fmap_magPA_IFG: [],
    fmap_phPA_IFG: [],

    #TMS Session: sgACC
    anat_scout_sgACC: [],
    presgACC_rest: [],
    presgACC_sp80: [],
    presgACC_sp100: [],
    presgACC_sp120: [],
    sgACC_iTBS: [],
    postsgACC_sp120: [],
    postsgACC_rest: [],
    fmap_magPA_sgACC: [],
    fmap_phPA_sgACC: [],

    #DSI Session
    anat_scout_DSI: [],
    t2w: [],
    dsi_493dir: [],
    dsi_72dir: []

    }

    for s in seqinfo:


    # Baseline session

        #if "Localizer" in s.protocol_name:
        if ("SpinEchoFieldMap_AP" in s.protocol_name) or ("fmap_acq-topup_dir-AP_epi" in s.protocol_name) or ("fmap_acq-spinecho_dir-AP_epi" in s.protocol_name):
            info[fmap_se_AP].append(s.series_id)
        if ("SpinEchoFieldMap_PA" in s.protocol_name) or ("fmap_acq-topup_dir-PA_epi" in s.protocol_name) or ("fmap_acq-spinecho_dir-PA_epi" in s.protocol_name):
            info[fmap_se_PA].append(s.series_id)
        if ("rfMRI_REST_AP" in s.protocol_name) or ("func_task-rest_acq-TR2s_dir-AP_bold" in s.protocol_name) or ("func_task-rest_dir-AP_bold" in s.protocol_name):
            info[rest_AP].append(s.series_id)
        if ("rfMRI_REST_PA" in s.protocol_name) or ("func_task-rest_acq-TR2s_dir-PA_bold" in s.protocol_name) or ("func_task-rest_dir-PA_bold" in s.protocol_name):
            info[rest_PA].append(s.series_id)
        if ("T1w_MPR" in s.protocol_name) or ("anat_acq-mpr_T1w" in s.protocol_name):
            info[t1w].append(s.series_id)
        if ("BOLD_02_nback_348" in s.protocol_name) or ("func_task-nback02_run-01_bold" in s.protocol_name):
            info[nback_02].append(s.series_id)
        if ("DTI_64dir_MB2" in s.protocol_name) or ("dwi_acq-multiband2dir64_dwi" in s.protocol_name):
            info[dti].append(s.series_id) 
        #if s.series_description.endswith('_M0'):
            #info[m0].append(s.series_id) #Removed conversion of MZero to nifti. With current versions of 
            #dcm2niix, the M0 will not convert correctly (one slice is deleted, resulting in errors). Error
            #is reproduced across different studies using this M0 protocol- not fixed for now. MZero not 
            #used in processing so no conversion to nifti needed.
        if s.series_description.endswith('_ASL'):
            info[raw_asl].append(s.series_id)
        if s.series_description.endswith('_MeanPerf'):
            info[mean_perf].append(s.series_id) 
        if ((s.protocol_name.startswith('B0map')) and ('IFG' not in s.dcm_dir_name) and ('sgACC' not in s.dcm_dir_name) and ('FP' not in s.dcm_dir_name)) or ("fmap_acq-magphase_b0" in s.protocol_name) or ("fmap_acq-magphase_dir-PA_b0" in s.protocol_name):
            if "P" in s.image_type:
                info[fmap_phPA_baseline].append(s.series_id)
            elif "M" in s.image_type:
                info[fmap_magPA_baseline].append(s.series_id)

    # TMS session

        if "IFG_Rest_PreIFG" in s.dcm_dir_name:
            info[preIFG_rest].append(s.series_id)
        if "IFG_sp80_PreIFG" in s.dcm_dir_name:
            info[preIFG_sp80].append(s.series_id)
        if "IFG_sp100_PreIFG" in s.dcm_dir_name:
            info[preIFG_sp100].append(s.series_id)
        if "IFG_sp120_PreIFG" in s.dcm_dir_name:
            info[preIFG_sp120].append(s.series_id)
        if "IFG_TBS_IFG" in s.dcm_dir_name:
            info[IFG_iTBS].append(s.series_id)
        if "IFG_sp120_PostIFG" in s.dcm_dir_name:
            info[postIFG_sp120].append(s.series_id)
        if "IFG_Rest_PostIFG" in s.dcm_dir_name:
            info[postIFG_rest].append(s.series_id)
        if "IFG_B0Maps" in s.dcm_dir_name:
            if "P" in s.image_type:
                info[fmap_phPA_IFG].append(s.series_id)
            elif "M" in s.image_type:
                info[fmap_magPA_IFG].append(s.series_id)

        if "sgACC_Rest_PreSgACC" in s.dcm_dir_name:
            info[presgACC_rest].append(s.series_id)
        if "sgACC_sp80_PreSgACC" in s.dcm_dir_name:
            info[presgACC_sp80].append(s.series_id)
        if "sgACC_sp100_PreSgACC" in s.dcm_dir_name:
            info[presgACC_sp100].append(s.series_id)
        if "sgACC_sp120_PreSgACC" in s.dcm_dir_name:
            info[presgACC_sp120].append(s.series_id)
        if "sgACC_TBS_sgACC" in s.dcm_dir_name:
            info[sgACC_iTBS].append(s.series_id)
        if "sgACC_sp120_PostSgACC" in s.dcm_dir_name:
            info[postsgACC_sp120].append(s.series_id)
        if "sgACC_Rest_PostSgACC" in s.dcm_dir_name:
            info[postsgACC_rest].append(s.series_id)
        if "sgACC_B0Maps" in s.dcm_dir_name:
            if "P" in s.image_type:
                info[fmap_phPA_sgACC].append(s.series_id)
            elif "M" in s.image_type:
                info[fmap_magPA_sgACC].append(s.series_id)

    # DSI session

        if "t2w_space_0.9mm" in s.protocol_name:
            info[t2w].append(s.series_id)
        if "DSI_493dir_b5000" in s.protocol_name:
            info[dsi_493dir].append(s.series_id)
        if "DSI_64dir_b5000" in s.protocol_name:
            info[dsi_72dir].append(s.series_id)

    return info

#IntendedFor section does not work for heudiconv, only heudiconv-fw
IntendedFor = {

    fmap_phPA_baseline: [
        '{session}/dwi/sub-{subject}_{session}_acq-DTIb1000mb2dir64_dwi.nii.gz',
        '{session}/func/sub-{subject}_{session}_task-nback02_run-0{item:01d}_bold.nii.gz'],

    fmap_magPA_baseline: [
        '{session}/dwi/sub-{subject}_{session}_acq-DTIb1000mb2dir64_dwi.nii.gz',
        '{session}/func/sub-{subject}_{session}_task-nback02_run-0{item:01d}_bold.nii.gz'],
   

    fmap_se_PA: [
        '{session}/func/sub-{subject}_{session}_task-rest_acq-TR2s_dir-AP_bold.nii.gz',
        '{session}/func/sub-{subject}_{session}_task-rest_acq-TR2s_dir-PA_bold.nii.gz'],

    fmap_se_AP: [
        '{session}/func/sub-{subject}_{session}_task-rest_acq-TR2s_dir-AP_bold.nii.gz',
        '{session}/func/sub-{subject}_{session}_task-rest_acq-TR2s_dir-PA_bold.nii.gz'],

    m0: [
        '{session}/asl/sub-{subject}_{session}_acq-spiralv20pf68accel1d_asl.nii.gz'],

    fmap_magPA_IFG: [
        '{session}/func/sub-{subject}_{session}_task-rest_acq-PreIFG_run-0{item:01d}_bold.nii.gz',
        '{session}/func/sub-{subject}_{session}_task-SP80_acq-PreIFG_run-0{item:01d}_bold.nii.gz',
        '{session}/func/sub-{subject}_{session}_task-SP100_acq-PreIFG_run-0{item:01d}_bold.nii.gz',
        '{session}/func/sub-{subject}_{session}_task-SP120_acq-PreIFG_run-0{item:01d}_bold.nii.gz',
        '{session}/func/sub-{subject}_{session}_task-iTBS_acq-IFG_run-0{item:01d}_bold.nii.gz',
        '{session}/func/sub-{subject}_{session}_task-SP120_acq-PostIFG_run-0{item:01d}_bold.nii.gz',
        '{session}/func/sub-{subject}_{session}_task-rest_acq-PostIFG_run-0{item:01d}_bold.nii.gz'],


    fmap_phPA_IFG: [
        '{session}/func/sub-{subject}_{session}_task-rest_acq-PreIFG_run-0{item:01d}_bold.nii.gz',
        '{session}/func/sub-{subject}_{session}_task-SP80_acq-PreIFG_run-0{item:01d}_bold.nii.gz',
        '{session}/func/sub-{subject}_{session}_task-SP100_acq-PreIFG_run-0{item:01d}_bold.nii.gz',
        '{session}/func/sub-{subject}_{session}_task-SP120_acq-PreIFG_run-0{item:01d}_bold.nii.gz',
        '{session}/func/sub-{subject}_{session}_task-iTBS_acq-IFG_run-0{item:01d}_bold.nii.gz',
        '{session}/func/sub-{subject}_{session}_task-SP120_acq-PostIFG_run-0{item:01d}_bold.nii.gz',
        '{session}/func/sub-{subject}_{session}_task-rest_acq-PostIFG_run-0{item:01d}_bold.nii.gz'],

    fmap_magPA_sgACC: [
        '{session}/func/sub-{subject}_{session}_task-rest_acq-PresgACC_run-0{item:01d}_bold.nii.gz',
        '{session}/func/sub-{subject}_{session}_task-SP80_acq-PresgACC_run-0{item:01d}_bold.nii.gz',
        '{session}/func/sub-{subject}_{session}_task-SP100_acq-PresgACC_run-0{item:01d}_bold.nii.gz',
        '{session}/func/sub-{subject}_{session}_task-SP120_acq-PresgACC_run-0{item:01d}_bold.nii.gz',
        '{session}/func/sub-{subject}_{session}_task-iTBS_acq-sgACC_run-0{item:01d}_bold.nii.gz',
        '{session}/func/sub-{subject}_{session}_task-SP120_acq-PostsgACC_run-0{item:01d}_bold.nii.gz',
        '{session}/func/sub-{subject}_{session}_task-rest_acq-PostsgACC_run-0{item:01d}_bold.nii.gz'],


    fmap_phPA_sgACC: [
        '{session}/func/sub-{subject}_{session}_task-rest_acq-PresgACC_run-0{item:01d}_bold.nii.gz',
        '{session}/func/sub-{subject}_{session}_task-SP80_acq-PresgACC_run-0{item:01d}_bold.nii.gz',
        '{session}/func/sub-{subject}_{session}_task-SP100_acq-PresgACC_run-0{item:01d}_bold.nii.gz',
        '{session}/func/sub-{subject}_{session}_task-SP120_acq-PresgACC_run-0{item:01d}_bold.nii.gz',
        '{session}/func/sub-{subject}_{session}_task-iTBS_acq-sgACC_run-0{item:01d}_bold.nii.gz',
        '{session}/func/sub-{subject}_{session}_task-SP120_acq-PostsgACC_run-0{item:01d}_bold.nii.gz',
        '{session}/func/sub-{subject}_{session}_task-rest_acq-PostsgACC_run-0{item:01d}_bold.nii.gz']
}
