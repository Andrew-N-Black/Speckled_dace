#This will plot Cross validation errors for each value of K and generate a membership probability plot for K2-4
#Programs used
#R version 4.2.0 (2022-04-22)
#Package ggplot2 version 3.3.6

cv <- read.csv("cv.txt", sep="")

ggplot(cv,aes(x=k,y=cv))+geom_point(size=6 )+geom_line(linetype='dashed')+theme_classic()+theme(axis.text=element_text(size=12),axis.title=element_text(size=14))+ylab("Cross Validation Error")+xlab("K")

#Create a infofile for admixture Rscript
awk '{ print $2 " " $1}' filtered.ped > info.txt
#head(info.txt)
#BLS20-001 Coleman_Creek
#BLS20-002 Coleman_Creek
#BLS20-003 Coleman_Creek
#BLS20-004 Coleman_Creek
#BLS20-005 Coleman_Creek
#BLS20-006 Coleman_Creek
#BLS20-007 Coleman_Creek
#BLS20-008 Coleman_Creek
#BLS20-009 Coleman_Creek


#Now run the following Rscript to generate a plot of K2-4. Rscript downloaded from: https://github.com/speciationgenomics/scripts
Rscript ./plotADMIXTURE.r --prefix filtered --infofile info.txt --maxK 4 --minK 2 --populations Foskett_Spring,Dace_Spring,Coleman_Creek,Deep_Creek,Twentymile_Creek
#DONE

