#!/bin/sh -l
#SBATCH -A fnrpupfish
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -t 150:00:00
#SBATCH --job-name=gadma3pop_Nomix
#SBATCH -e %x
#SBATCH -o %x

##########################################################################
###                          Samarth Mathur, PhD                     	###
###                        The Ohio State University                 	###
###                                                                     ###
###########################################################################
###########################################################################
###                     gadma_3pop.sh              						###
###########################################################################

cd $SLURM_SUBMIT_DIR

module load use.own
module load conda-env/gadma-py3.8.5


# 3-pop model no mixed
# - Deep_Creek (20) - Coleman_Creek (44) - Foskett_Spring (45)


#Step1: To convert a VCF (.vcf) file into a SFS (.sfs) file

cd /scratch/bell/mathur20/foskettDace/gadma/3pop/noMix

#~/easySFS/easySFS.py \
#-p /scratch/bell/mathur20/foskettDace/lists/3pop_noMix.txt \
#-a --proj 20,40,40 -f \
#-i /scratch/bell/mathur20/foskettDace/vcf/unrel.mac3.recode.vcf \
#-o sfs/ \
#--prefix 3pop_noMix



 # CREATE PARAM FILE #

count=1
for i in 1 2 3
do
	for j in 1 2 3 
	do
		for k in 1 2 3
		do
		echo \
"#GADMA_Run1 $count
# MQU  3 Pop: DC, CC, FS
Output directory : /scratch/bell/mathur20/foskettDace/gadma/3pop/noMix/models/m$count
Input data : /scratch/bell/mathur20/foskettDace/gadma/3pop/noMix/sfs/dadi/Deep_Creek-Coleman_Creek-Foskett_Spring.sfs
Population labels : [Deep_Creek, Coleman_Creek, Foskett_Spring]
Projections : [20, 40, 40]
Sequence length: 29970989
Linked SNP's : False
Pts: [40, 50, 60]
Theta0: Null
Mutation rate: 6.6e-08
Time for generation : 2
Use moments or dadi : dadi
Multinom : True
Lower bounds : Null
Upper bounds : Null
Parameter identifiers: Null
Only sudden : False
Initial structure : [$i, $j, $k]
Final Structure: [$i, $j, $k]
Relative parameters : False
No migrations : false
Name of local optimization : optimize_log
Number of repeats : 20
Number of processes : 20
Draw models every N iteration : 100
Units of time in drawing : thousand years
Upper bound of first split: 50000
#Mean mutation strength : 0.2
#Const for mutation strength : 1.0
#Mean mutation rate : 0.2
#Const for mutation rate : 1.0
Epsilon : 0.001
Stop iteration : 1000" > params/gadma.run$count.params 
		count=$[$count+1]
done
done
done

# Create Job file
for i in `seq 1 1 27`
do
	#mkdir models/m$i
	echo "#!/bin/sh -l
#SBATCH -A fnrpupfish
#SBATCH -N 1
#SBATCH -n 5
#SBATCH -t 14-00:00:00
#SBATCH --job-name=gadma.run$i.3popnoMix
#SBATCH -e gadma.run$i.3popnoMix
#SBATCH -o gadma.run$i.3popnoMix
module load use.own
module load conda-env/gadma-py3.8.5
gadma -p /scratch/bell/mathur20/foskettDace/gadma/3pop/noMix/params/gadma.run$i.params" \
> jobs/gadma.run$i.job
done