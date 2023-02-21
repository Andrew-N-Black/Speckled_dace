###########################################################################
###                           Samarth Mathur, PhD                       ###
###                       The Ohio State University                     ###
###                                                                     ###
###########################################################################
###########################################################################
###                   d3_stat.R        		                              ###
###########################################################################

# Calculate D3 statistic from pairwise genetic distances of 3-pop data
# See: doi:10.1093/molbev/msz178

setwd("/Users/mathur.112/Documents/Other_Research/Foskett_Dace/Results/abbaBaba/")
geneDist <- read.table("genDist.txt",header = T)
inds <- colnames(geneDist[-1])

# Convert pairwise distance matrix into dataframe
genD <- NULL
for (i in 1:length(inds))
{
  for (j in 1:length(inds))
  {
    df <- data.frame(Ind1=inds[i],Ind2=inds[j])
    genD <- rbind(genD,df)
  }
}

gD <- NULL

for (i in 1:length(inds))
{
  j <- i+1
  a <- as.matrix(geneDist[i,2:181])
  gD <- c(gD,a)
}

genD <- cbind(genD,gD)

# Add population data

pops <- read.table("180unrel.poplist.txt",header = T)
colnames(pops)[1] <- "Ind1"
df.genD <- inner_join(genD,pops,by="Ind1")
colnames(pops)[1] <- "Ind2"
df.genD <- inner_join(df.genD,pops,by="Ind2")
colnames(df.genD)[4:5] <- c("Pop1","Pop2")

# mean population pairwise Distance calculations
popnames <- unique(pops$Pop)
meanPopdists <- NULL
count1 <- 0
count2 <- 0
for (pop1 in popnames)
{
  count1 <- count1+1
  count2 <- 0
  for (pop2 in popnames)
  {
    count2 <- count2+1
    if (count2 > count1)
    {
      if (pop1 != pop2)
      {
        df1 <- df.genD[which(df.genD$Pop1==pop1 & df.genD$Pop2==pop2),]
        df2 <- data.frame(Pop1=pop1, Pop2=pop2,meanGd=mean(df1$gD),sdGd=sd(df1$gD))
        meanPopdists <- rbind(meanPopdists,df2)
      }
    }
  }
}

meanPopdists
##### D3 calculations for 3-pop pairs #######
# D(A,B,C) = (dbc - dac)/(dbc + dac)

# 1. Foskette-Coleman-Deep
# get dac and dbc
df.ac <- df.genD[which(df.genD$Pop1=="Deep_Creek" & df.genD$Pop2=="Foskett_Spring"),]
df.bc <- df.genD[which(df.genD$Pop1=="Coleman_Creek" & df.genD$Pop2=="Deep_Creek"),]

gD.ac <- df.ac$gD # N = 900
gD.bc <- df.bc$gD # N = 880

# Get D3 from 850 pairwise comparisons
dac <- sample(gD.ac,850)
dbc <- sample(gD.bc,850)
d3.1 <- (dbc - dac)/(dbc + dac)
CI_z(d3.1, ci = 0.95)

# 2. Foskette-Deep-Coleman
# get dac and dbc
df.ac <- df.genD[which(df.genD$Pop1=="Foskett_Spring" & df.genD$Pop2=="Coleman_Creek"),]
df.bc <- df.genD[which(df.genD$Pop1=="Coleman_Creek" & df.genD$Pop2=="Deep_Creek"),]

gD.ac <- df.ac$gD # N = 1980
gD.bc <- df.bc$gD # N = 880

# Get D3 from 850 pairwise comparisons
dac <- sample(gD.ac,850)
dbc <- sample(gD.bc,850)
d3.2 <- (dbc - dac)/(dbc + dac)
CI_z(d3.2, ci = 0.95)

# 3. Coleman-Foskette-Deep
# get dac and dbc
df.ac <- df.genD[which(df.genD$Pop1=="Coleman_Creek" & df.genD$Pop2=="Deep_Creek"),]
df.bc <- df.genD[which(df.genD$Pop1=="Deep_Creek" & df.genD$Pop2=="Foskett_Spring"),]

gD.ac <- df.ac$gD # N = 880
gD.bc <- df.bc$gD # N = 900

# Get D3 from 850 pairwise comparisons
dac <- sample(gD.ac,850)
dbc <- sample(gD.bc,850)
d3.3 <- (dbc - dac)/(dbc + dac)
CI_z(d3.3, ci = 0.95)


# 4. Foskette-Coleman-Twentymile
# get dac and dbc
df.ac <- df.genD[which(df.genD$Pop1=="Twentymile_Creek" & df.genD$Pop2=="Foskett_Spring"),]
df.bc <- df.genD[which(df.genD$Pop1=="Coleman_Creek" & df.genD$Pop2=="Twentymile_Creek"),]

gD.ac <- df.ac$gD # N = 1170
gD.bc <- df.bc$gD # N = 1144

# Get D3 from 1000 pairwise comparisons
dac <- sample(gD.ac,1000)
dbc <- sample(gD.bc,1000)
d3.4 <- (dbc - dac)/(dbc + dac)
CI_z(d3.4, ci = 0.95)

# 5. Foskette-Twentymile-Coleman
# get dac and dbc
df.ac <- df.genD[which(df.genD$Pop1=="Coleman_Creek" & df.genD$Pop2=="Foskett_Spring"),]
df.bc <- df.genD[which(df.genD$Pop1=="Coleman_Creek" & df.genD$Pop2=="Twentymile_Creek"),]

gD.ac <- df.ac$gD # N = 1980
gD.bc <- df.bc$gD # N = 1144

# Get D3 from 1000 pairwise comparisons
dac <- sample(gD.ac,1000)
dbc <- sample(gD.bc,1000)
d3.2 <- (dbc - dac)/(dbc + dac)
CI_z(d3.1, ci = 0.95)

# 6. Coleman-Foskette-Twentymile
# get dac and dbc
df.ac <- df.genD[which(df.genD$Pop1=="Coleman_Creek" & df.genD$Pop2=="Twentymile_Creek"),]
df.bc <- df.genD[which(df.genD$Pop1=="Twentymile_Creek" & df.genD$Pop2=="Foskett_Spring"),]

gD.ac <- df.ac$gD # N = 880
gD.bc <- df.bc$gD # N = 900

# Get D3 from 800 pairwise comparisons
dac <- sample(gD.ac,850)
dbc <- sample(gD.bc,850)
d3.3 <- (dbc - dac)/(dbc + dac)
CI_z(d3.3, ci = 0.95)

###############################################


# Function to get CI based on Z-tranformation of the geneDist data
CI_z <- function (x, ci = 0.95)
{
  `%>%` <- magrittr::`%>%`
  standard_deviation <- sd(x)
  sample_size <- length(x)
  Margin_Error <- abs(qnorm((1-ci)/2))* standard_deviation/sqrt(sample_size)
  df_out <- data.frame( sample_size=length(x), Mean=mean(x), sd=sd(x),
                        Margin_Error=Margin_Error,
                        'CI lower limit'=(mean(x) - Margin_Error),
                        'CI Upper limit'=(mean(x) + Margin_Error)) %>%
    tidyr::pivot_longer(names_to = "Measurements", values_to ="values", 1:6 )
  return(df_out)
}
