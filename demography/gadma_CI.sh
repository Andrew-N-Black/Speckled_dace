#!/bin/sh -l
#SBATCH -A fnrdewoody
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -t 150:00:00
#SBATCH --job-name=ci_3popNomix
#SBATCH -e %x
#SBATCH -o %x

##########################################################################
###                          Samarth Mathur, PhD                     	###
###                        The Ohio State University                 	###
###                                                                     ###
###########################################################################
###########################################################################
###                     gadma_CI.sh              						###
###########################################################################

cd $SLURM_SUBMIT_DIR
module load use.own
module load conda-env/gadma-py3.8.5
#module load bioinfo
#module load vcftools

# see : https://gadma.readthedocs.io/en/latest/user_manual/confidence_intervals.html


# Step1: Bootstrap SFS from a random subset of 50,000 markers (Total = 53,125)
#cd /scratch/bell/mathur20/foskettDace/vcf/boot/

#for i in {1..100}
#do
	#shuf -n 50000 /scratch/bell/mathur20/foskettDace/sites/unrel.mac3.all.sites > /scratch/bell/mathur20/foskettDace/sites/unrel.mac3.rand${i}.sites

	#cd /scratch/bell/mathur20/foskettDace/vcf/boot/

	#vcftools --vcf /scratch/bell/mathur20/foskettDace/vcf/unrel.mac3.recode.vcf \
	#--recode --recode-INFO-all \
	#--positions /scratch/bell/mathur20/foskettDace/sites/unrel.mac3.rand${i}.sites \
	#--out unrel.mac3.boot${i}

	#for pop in CC_DC  FS_CC  FS_DC
	#do
	#	cd /scratch/bell/mathur20/foskettDace/gadma/2pop/${pop}/boot
	#	mkdir run$i
	#	~/easySFS/easySFS.py \
	#	-p /scratch/bell/mathur20/foskettDace/lists/2pop_${pop}.txt \
	#	-a --proj 40,20 -f \
	#	-i /scratch/bell/mathur20/foskettDace/vcf/boot/unrel.mac3.boot${i}.recode.vcf \
	#	-o run$i/sfs \
	#	--prefix 2pop_${pop}
	#done
#done


# Step2: Run local search on bootstrapped data 
# The first script gadma-run_ls_on_boot_data runs local search from known optimum for initial AFS

#for pop in CC_DC  FS_CC  FS_DC
#do
	#cd /scratch/bell/mathur20/foskettDace/gadma/2pop/FS_DC/boot/

	#gadma-run_ls_on_boot_data \
	#-b sfs/ \
	#-d /scratch/bell/mathur20/foskettDace/gadma/2pop/FS_DC/models/m1/best_aic_model_dadi_code.py \
	#-o step1/ \
	#--opt log 
#done

#Step2: Get Confidence Intervals from table

#cd /scratch/bell/mathur20/foskettDace/gadma/2pop/FS_DC/boot/step1/

#gadma-get_confidence_intervals --log \
#result_table.csv



cd /scratch/bell/mathur20/foskettDace/gadma/3pop/noMix/boot
#for i in {1..100}
#do
	#mkdir runs/run$i
	#~/easySFS/easySFS.py \
	#-p /scratch/bell/mathur20/foskettDace/lists/3pop_noMix.txt \
	#-a --proj 20,40,40 -f \
	#-i /scratch/bell/mathur20/foskettDace/vcf/boot/unrel.mac3.boot${i}.recode.vcf \
	#-o runs/run$i/sfs \
	#--prefix 3pop_noMix

	#cp runs/run$i/sfs/dadi/Deep_Creek-Coleman_Creek-Foskett_Spring.sfs sfs/Deep_Creek-Coleman_Creek-Foskett_Spring.run$i.sfs

#done

gadma-run_ls_on_boot_data \
-b sfs/ \
-d /scratch/bell/mathur20/foskettDace/gadma/3pop/noMix/models/m1/best_logLL_model_dadi_code.py \
-o step1/ \
--opt log