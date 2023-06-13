#This script generates an individual PCA from GBS allele freq data

#load library
library(adegenet)

#Read plink file (recoded with plink, see plink.sh)
dace<-read.PLINK("filtered.raw")
#Run PCA
pca1<-glPca(dace,nf=2,parallel = TRUE,n.cores = 4)

#Bind
s<-pca1$scores
p<-as.data.frame(dace$pop)
X<-cbind(s,p)

#Plot
ggplot(data=X, aes(y=PC2, x=PC1))+geom_point(size=7,color="black",aes(shape=dace$pop,fill=dace$pop))+ theme_classic() + xlab("PC1 (9.4%)") +ylab("PC2 (3.6%)")+geom_hline(yintercept=0,linetype="dashed")+geom_vline(xintercept =0,linetype="dashed")+scale_fill_manual("Population", values=c("grey30","grey40","grey60","grey80","grey100"))+scale_shape_manual("Population", values=c(23,22,21,24,25))


#Percent variance for manual annotation to plot
head(pca1$eig)
#[1] 15.531970  6.034579  3.162138  1.612524  1.478360  1.416109

15.531970/sum(pca1$eig)*100
#9.392614

6.034579/sum(pca1$eig)*100
#3.649278

ggsave("Fig_3.svg")
