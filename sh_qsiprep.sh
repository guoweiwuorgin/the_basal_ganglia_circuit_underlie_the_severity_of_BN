for file in `cat subname.txt`
do
 sbatch -p q_Node_bj -c 10 -e ${file}_error.txt -o ${file}_out.txt ind_qsiprep.sh $file
done
