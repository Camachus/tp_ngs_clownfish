#!/bin/bash

# Set a working directory:
data="/home/rstudio/data/mydatalocal/data"
cd $data
mkdir -p blast_db
mkdir -p out_blast
db=$data/blast_db/db

#build reference database 
makeblastdb -in $data/cds_spartitus/spartitus_coding_format.fa -dbtype nucl -out $db 

#blast fasta against the ref db
blastn -db $db -query $data/data_transcoder/Trinity.fasta.transdecoder.rename.cds -evalue 1e-5 -outfmt 6 -out $data/out_blast


