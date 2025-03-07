subname=$1
data_dir=/data4/workingFolder/wuguowei/control_bids
subdwi=${data_dir}/${subname}_space-T1w_desc-preproc_dwi.nii.gz
subbval=${data_dir}/${subname}_space-T1w_desc-preproc_dwi.bval
subbvec=${data_dir}/${subname}_space-T1w_desc-preproc_dwi.bvec
trk_nii=$2
trk_dir=/data4/workingFolder/wuguowei/trk_mask/control_group
##FA fitting
bet2 $subdwi ${data_dir}/${subname}_space-T1w_desc-preproc_dwi_mask.nii.gz -m 
mask_img=${data_dir}/${subname}_space-T1w_desc-preproc_dwi_mask.nii.gz
dtifit -k $subdwi -o ${trk_dir}/${subname}/${subname}_ -r $subbvec -b $subbval -m $mask_img 
for seed in `cat seed_L_roi.txt`
do
 for target in `cat L_target_roi.txt`
 do

   trk_nii_sub=${trk_dir}/${subname}/${subname}_${seed}_${target}.nii.gz
   #echo $trk_nii_sub   
   fslmaths $trk_nii_sub -thr 10 -bin ${trk_dir}/${subname}/${subname}_${seed}_${target}_mask.nii.gz
   fslmeants -i ${trk_dir}/${subname}/${subname}__FA.nii.gz -o ${trk_dir}/${subname}/${subname}_${seed}_${target}_FA.txt -m ${trk_dir}/${subname}/${subname}_${seed}_${target}_mask.nii.gz
   fslmeants -i ${trk_dir}/${subname}/${subname}__MD.nii.gz -o ${trk_dir}/${subname}/${subname}_${seed}_${target}_MD.txt -m ${trk_dir}/${subname}/${subname}_${seed}_${target}_mask.nii.gz
 done
done
echo "Left roi Done!"
for seed in `cat seed_R_roi.txt`
do
 for target in `cat R_target_roi.txt`
 do
   trk_nii_sub=${trk_dir}/${subname}/${subname}_${seed}_${target}.nii.gz
   #echo $trk_nii_sub
   fslmaths $trk_nii_sub -thr 10 -bin ${trk_dir}/${subname}/${subname}_${seed}_${target}_mask.nii.gz
   fslmeants -i ${trk_dir}/${subname}/${subname}__FA.nii.gz -o ${trk_dir}/${subname}/${subname}_${seed}_${target}_FA.txt -m ${trk_dir}/${subname}/${subname}_${seed}_${target}_mask.nii.gz
   fslmeants -i ${trk_dir}/${subname}/${subname}__MD.nii.gz -o ${trk_dir}/${subname}/${subname}_${seed}_${target}_MD.txt -m ${trk_dir}/${subname}/${subname}_${seed}_${target}_mask.nii.gz
 done
done
echo "Right roi Done!"


