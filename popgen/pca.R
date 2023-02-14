#This script generates an individual PCA from GBS allele freq data

#load library
library(adegenet)

#Read plink file (recoded with plink, see plink.sh)
dace<-read.PLINK("filtered.raw")
#Run PCA
pca1<-glPca(dace,nf=2,parallel = TRUE,n.cores = 4)
#Plot
s.class(pca1$scores, pop(dace),clabel = 0, cpoint = 1.5,col=c("black","black","black","grey","grey"),pch=shape[dace@pop],grid=F)
#Add eig
b<-add.scatter.eig(pca1$eig,2,1,2, posi = "bottomright")

#Percent variance for manual annotation to plot
head(pca1$eig)
#[1] 15.531970  6.034579  3.162138  1.612524  1.478360  1.416109

15.531970/sum(pca1$eig)*100
#9.392614

6.034579/sum(pca1$eig)*100
#3.649278

ggsave("Fig_3.svg")
