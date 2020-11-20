#!/bin/bash

# Set a working directory:
data="/home/rstudio/data/mydatalocal/data"
mkdir -p $data
cd $data



#Create a folder to store salmon analysis:
mkdir -p data_salmon
cd data_salmon

#We use salmon for Transcript expression quantification
#Index de Transcriptome
salmon index -k 29 -t $data/data_trinity/Trinity.fasta -i $data/data_trinity/transcript_index

#Quantification

fastq=$(ls $data/sra_data/*.fastq)
for fastq_file in $fastq
do
#Rename the SRR without .fastq

Newname=$(basename -s .fastq $fastq_file)
salmon quant -l SR --gcBias --validateMappings -p 16 \
-i $data/data_trinity/transcript_index -o $data/data_salmon/$Newname -r $fastq_file

#$fastaq_file: output write in sfolder name as the teated fastsq


#launch script with      nohup ./salmon.sh >& nohup.salmon &



