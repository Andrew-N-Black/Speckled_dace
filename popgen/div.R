#Diversity metrics calculated for five dace populations

#programs used
#diveRsity v1.9.90
library(diveRsity)
#Run diversity calculation
diver<-diffCalc(infile="/Users/andrew/Library/CloudStorage/Box-Box/Foskett Dace Population Genetics/Working_Code/populations.snps.genepop",outfile = "/Users/andrew/div/dace",fst=TRUE,pairwise=TRUE,boots=100,para=TRUE,bs_locus=TRUE,bs_pairwise=TRUE)
#DONE
