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
module load vcftools

# Get Stats on raw VCF file

#cd /scratch/bell/mathur20/foskettDace/vcfstats/

#for i in depth site-depth site-mean-depth geno-depth site-pi het relatedness2 missing-indv missing-site
#do
#	vcftools --vcf /scratch/bell/mathur20/foskettDace/vcf/populations.snps.vcf \
#	--$i \
#	--out allind.raw
#done


# Filter VCF
# Site filtering:
# Retained loci were required to have a minimum allele depth of 5× (-m 5), 
# be present in ≥80% of every population sample (--min-samples-per-pop 0.80) 
# for all five populations (--min-populations 5), 
# and have a minimum minor allele count of 3 (--mac 3)
#
# Individual filtering:
# Remove bad individuals 
# BLS20-103, BLS20-208, BLS20-009, BLS20-019, BLS20-026, BLS20-041
# BLS20-098, BLS20-110, BLS20-120, BLS20-206

cd /scratch/bell/mathur20/foskettDace/vcf/
vcftools --vcf populations.snps.vcf \
--recode --recode-INFO-all \
--mac 3 \
--remove-indv BLS20-103 \
--remove-indv BLS20-208 \
--remove-indv BLS20-009 \
--remove-indv BLS20-019 \
--remove-indv BLS20-026 \
--remove-indv BLS20-041 \
--remove-indv BLS20-098 \
--remove-indv BLS20-110 \
--remove-indv BLS20-120 \
--remove-indv BLS20-206 \
--out unrel.mac3   #  kept 180 out of 190 Individuals; 53125 out of a possible 130082 Sites