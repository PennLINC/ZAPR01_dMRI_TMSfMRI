import nibabel as nib
import numpy as np
import math as math
import os
import csv

#Calcuate cortical distance between the amygdala-targeting site of stimulation and the control site of stimulation (sites localized in MNI T1 2mm brain)

def three_d_dist(p1,p2):
	return math.sqrt((p2[0] - p1[0]) ** 2 + (p2[1] - p1[1]) ** 2 + (p2[2] - p1[2]) ** 2)

def distance(nifti,roi,coord):
	nifti = nib.load(nifti)
	nifti_data = nifti.get_fdata()
	nifti.dataobj
	r = three_d_dist(np.mean(np.argwhere(nifti_data==roi),axis=0),coord)
	return r

basepath = "/storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI/sites_of_stim"

header = ["Case","SOSDistance"]
with open("/storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI/output_measures/distance/SitesofStim-Distance.csv",'a') as outfile:
	writer = csv.writer(outfile)
	writer.writerow(header)
outfile.close()

for filename in sorted(os.listdir(basepath)):
	if filename.endswith("_siteofstim_BLA.csv"):
		case = filename[:-19]
		coords = open(basepath + "/" + filename, 'r').read().replace('\n','')
		coord = list(map(int,coords.split(','))) #MNI X,Y,Z voxel coordinates of the amygdala-targeting SOS
		roi = 1
		nifti = (basepath + "/" + case + "_siteofstim_ROI_sgACC.nii.gz") #control SOS ROI
		dist = distance(nifti,roi,coord)
		distdata=[case,(dist*2)] #dist expressed in voxels, multiply by 2 as voxels are each 2mm
		with open("/storage/vsydnor/ZAPR01_WhiteMatter_TMSfMRI/output_measures/distance/SitesofStim-Distance.csv",'a') as outfile:
			writer = csv.writer(outfile)
			writer.writerow(distdata)
outfile.close()


