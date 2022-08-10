

library(ggplot2)
cv <- read.csv("/Users/andrew/Library/CloudStorage/Box-Box/Foskett Dace Population Genetics/Working_Code/cv.txt", sep="")

ggplot(cv,aes(x=k,y=cv))+geom_point(size=6 )+geom_line(linetype='dashed')+theme_classic()+theme(axis.text=element_text(size=12),axis.title=element_text(size=14))+ylab("Cross Validation Error")+xlab("K")
ggsave("Fig_S4.svg")
#DONE
