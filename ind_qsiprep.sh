#!/bin/bash
#User inputs:
bids_root_dir=/GPFS/cuizaixu_lab_temp/wuguowei/yuan/bids
bids_root_dir_output_wd4singularity=/GPFS/cuizaixu_lab_temp/wuguowei/yuan/WD
subj=$1
nthreads=8

#Run qsiprep
echo ""
echo "Running qsiprep on participant: sub-$subj"
echo ""

#Make qsiprep directory and participant directory in derivatives folder
if [ ! -d $bids_root_dir/derivatives/qsiprep ]; then
    mkdir $bids_root_dir/derivatives/qsiprep
fi

if [ ! -d $bids_root_dir/derivatives/qsiprep/sub-${subj} ]; then
    mkdir $bids_root_dir/derivatives/qsiprep/sub-${subj}
fi
if [ ! -d $bids_root_dir_output_wd4singularity/derivatives/qsiprep ]; then
    mkdir $bids_root_dir_output_wd4singularity/derivatives/qsiprep
fi

if [ ! -d $bids_root_dir_output_wd4singularity/derivatives/qsiprep/sub-${subj} ]; then
    mkdir $bids_root_dir_output_wd4singularity/derivatives/qsiprep/sub-${subj}
fi

#Run qsiprep_prep
unset PYTHONPATH; singularity run --cleanenv \
    -B $bids_root_dir:/data/ \
    -B $bids_root_dir/derivatives/qsiprep/sub-${subj}:/output/ \
    -B $bids_root_dir/derivatives/qsiprep:/prepResults/ \
    -B $bids_root_dir_output_wd4singularity/derivatives/qsiprep/sub-${subj}:/WD/ \
    -B /GPFS/cuizaixu_lab_temp/wuguowei/code:/freesurfer_license/ \
    /GPFS/cuizaixu_lab_permanent/wuguowei/app_packages/qsiprep.sif \
    /data /output \
    participant \
    --participant_label ${subj} \
    --unringing-method mrdegibbs \
    --output-resolution 2.0 \
    --recon_input /prepResults \
    --recon_spec mrtrix_singleshell_ss3t_noACT \
    -w /WD \
    --fs-license-file /freesurfer_license/license.txt \
    --verbose \
    --notrack \
    --nthreads $nthreads \
    --mem-mb 16000

