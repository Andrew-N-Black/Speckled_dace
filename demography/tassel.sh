#!/bin/sh -l
#SBATCH -A fnrpupfish
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -t 150:00:00
#SBATCH --job-name=vcfstats
#SBATCH -e %x
#SBATCH -o %x

##########################################################################
###                          Samarth Mathur, PhD                     	###
###                        The Ohio State University                 	###
###                                                                     ###
###########################################################################
###########################################################################
###                     vcfTools.sh              						###
###########################################################################


cd $SLURM_SUBMIT_DIR
module load bioinfo
module load TASSEL/5.2.44


cd /scratch/bell/mathur20/foskettDace/tassel

# Step1: Sort genotypes 

run_pipeline.pl -Xmx10G -SortGenotypeFilePlugin \
-inputFile /scratch/bell/mathur20/foskettDace/vcf/unrel.mac3.recode.vcf  \
-outputFile unrel.mac3.sorted.vcf -fileType VCF

# Step2: Create UPGMA/Neighbor joining trees

count1=1

run_pipeline.pl -Xmx60G -fork$count1 \
-vcf unrel.mac3.sorted.vcf \
-tree Neighbor -treeSaveDistance true \
-export unrel.mac3NJ${count1}

run_pipeline.pl -Xmx60G -fork$count1 \
-vcf unrel.mac3.sorted.vcf \
-tree Neighbor -treeSaveDistance true \
-export unrel.mac3NJ${count1} -exportType Text