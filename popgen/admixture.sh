#this script runs the program admixture and outputs membership probabilities and K associated CV error
#Programs used
#admixture v 1.30

#run for loop for K1-8 on plink file
for i in 1 2 3 4 5 6 7 8; do ./admixture  --cv ./data/filtered.ped $i | tee log${i}.out; done

#Check error rate for each model, select the lowest
grep -h CV log?.out

#CV error (K=1): 0.38616
#CV error (K=2): 0.35144
#CV error (K=3): 0.34230
#CV error (K=4): 0.34769
#CV error (K=5): 0.35219
#CV error (K=6): 0.35952
#CV error (K=7): 0.36828
#CV error (K=8): 0.37709

#Plot above using admixture.R
#DONE
