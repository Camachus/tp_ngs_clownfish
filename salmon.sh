#!/bin/bash

# Set a working directory:
data="/home/rstudio/data/mydatalocal/data"
mkdir -p $data
cd $data
#definition of sra_data
sra_data= "/home/rstudio/data/mydatalocal/data/sra_data/"
$data= "/home/rstudio/data/mydatalocal/data"
#Create a folder to store salmon analysis:
mkdir -p data_salmon
cd data_salmon

#We use salmon for Transcript expression quantification
#Index de Transcriptome
salmon index -k 30 -t $data/data_trinity/Trinity.fasta -i $data/transcript_index

#Quantification

fastq=$sra_data/*fastq
for fastq_file in $fastq
do
#Rename the SRR without .fastq

Newname=$(basename -s .fastq $fastq_file)
salmon quant --gcBias --validateMappings -l SR -p 16 \
-i $data/data_trinity/transcript_index -o $sra_data/data_salmon/$Newname -r $fastq_file

#$fastaq_file: output write in sfolder name as the teated fastsq






