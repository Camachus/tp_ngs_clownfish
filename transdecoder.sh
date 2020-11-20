#!/bin/bash

# Set a working directory:
data="/home/rstudio/data/mydatalocal/data"
mkdir -p $data
cd $data


mkdir -p data_transcod
# Step 1: extract the long open reading frames
TransDecoder.LongOrfs -t $data/sra_data_Trinity/Trinity.fasta -m ???
# Step 2: (facultative) identify ORFs with homology to known proteins via blast or pfam searches.
# Step 3: predict the likely coding regions
TransDecoder.Predict -t $data/sra_data_Trinity/Trinity.fasta [ homology options ] --output_dir $data/data_transcod