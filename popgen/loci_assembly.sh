#This script was used to:
1) Demultiplex two lanes worth of reads. As the same barcodes were reused, this had to occur twice
2) Run the denovo_map wrapper to create catalog and identify loci among samples and run populations to output analysis file

#programs:
#stacks 2.52

#1: Demultiplex reads
#FIRST LANE
 process_radtags -1 ../raw/lane2-s005-index--GBS0272_S5_L002_R1_001.fastq.gz -2 ../raw/lane2-s005-index--GBS0272_S5_L002_R2_001.fastq.gz -o ./demultiplex_plate_1/ -b ./info/barcodes_1.txt -c --renz-1 pstI --renz-2 mspI --retain-header -y fastq -t 40
 
 #Outputing details to log: './demultiplex_plate_1/process_radtags.raw.log'

#757511450 total sequences
#80776084 barcode not found drops (10.7%)
#179908 low quality read drops (0.0%)
#20961950 RAD cutsite not found drops (2.8%)
#655593508 retained reads (86.5%)


#move to output directory
cd ./demultiplex_plate_1
#Delete unasigned / unpaired reads:
rm -f *rem*
# And copy demultiplexed files to a new directory, which will house both plates of samples:
cp *.fq ../demultiplexed

#SECOND LANE
process_radtags -1 ../raw/lane3 -2 ../raw/lane3-s002-index--GBS0290_S2_L003_R2_001.fastq.gz  -o ./demultiplex_plate_2/ -b ./info/barcodes_2.txt -c --renz-1 pstI --renz-2 mspI --retain-header -y fastq -t 40

#Outputing details to log: './demultiplex_plate_2/process_radtags.raw.log'

#679353120 total sequences
#99936322 barcode not found drops (14.7%)
#2870534 low quality read drops (0.4%)
#13823215 RAD cutsite not found drops (2.0%)
#562723049 retained reads (82.8%)

#move to output directory
cd ./demultiplex_plate_2
#Delete unasigned / unpaired reads:
rm -f *rem*
# And copy demultiplexed files to a new directory, which will house both plates of samples:
cp *.fq ../demultiplexed

#2) Wrapper script:

#Run denovo_map
denovo_map.pl -T 40 -o ./assembled --popmap ./info/popmap.txt --samples ./demultiplexed/ --paired  -X "populations:--write-single-snp"  -X "populations:--min-mac 3" --min-samples-per-pop 0.80  -X "populations:--fstats"  -X "populations:--plink" -X "populations:--genepop" --min-populations 5 -X "ustacks:-m 5" 

#DONE

