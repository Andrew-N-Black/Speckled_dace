#This script generates an individual PCA from GBS allele freq data

#load library
library(adegenet)

#Read plink file (recoded with plink, see plink.sh)
dace<-read.PLINK("populations.plink.raw")
#Run PCA
pca1<-glPca(dace,nf=2,parallel = TRUE,n.cores = 4)
#Plot
s.class(pca1$scores, pop(dace),clabel = 0, cpoint = 1.5,col=c("black","black","black","grey","grey"),pch=shape[dace@pop])
#Add eig
b<-add.scatter.eig(pca1$eig,2,1,2, posi = "bottomright")

#Percent variance for manual annotation to plot
head(pca1$eig)
[1] 14.966176  6.168516  3.001680  1.598602  1.557322  1.394309

14.966176/sum(pca1$eig)*100
[1] 9.15425

6.168516/sum(pca1$eig)*100
[1] 3.773051

svg("Fig_3.svg")
