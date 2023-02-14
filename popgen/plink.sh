#This script outlines file conversions used with the program plink:

#programs:
#PLINK v1.90b5.2 64-bit (9 Jan 2018) 

#1) Remove two individuals (BLS20-208 BLS20-103 for low genotyping rate) and recode for adegenet, admixture and king
plink --file populations.plink --allow-extra-chr --mind 0.3 --make-bed --out mind
plink --bfile mind --recode12 --out filtered --allow-extra-chr

#DONE
