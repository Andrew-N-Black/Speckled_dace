#Diversity metrics calculated for five dace populations

#programs used
diveRsity v1.9.90
library(diveRsity)
#Run diversity calculation
diver<-diffCalc(infile="/Users/andrew/dace_rerun/populations.snps.singlesnp.gen",outfile = "~/div",fst=TRUE,pairwise=TRUE,boots=1000,para=TRUE,bs_locus=TRUE,bs_pairwise=TRUE)
#DONE
