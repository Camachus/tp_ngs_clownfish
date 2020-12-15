#!/bin/bash

# Set a working directory:
data="/home/rstudio/data/mydatalocal/data"
cd $data

#Create a folder to download spatitus:
mkdir -p cds_spartitus

# Pour telecharger 
wget -O  cds_spartitus/spartitus.fa.gz ftp://ftp.ensembl.org/pub/release-102/fasta/stegastes_partitus/cds/Stegastes_partitus.Stegastes_partitus-1.0.2.cds.all.fa.gz

  
