#!/bin/bash

# Set a working directory:
data="/home/rstudio/data/mydatalocal/data"
cd $data


mkdir -p data_transcoder
# Step 1: extract the long open reading frames
TransDecoder.LongOrfs -t $data/data_trinity/Trinity.fasta --gene_trans_map $data/data_trinity/Trinity.fasta.gene_trans_map -m 100 -S -O data_transcoder

# Step 2: (facultative) identify ORFs with homology to known proteins via blast or pfam searches.

# Step 3: predict the likely coding regions
TransDecoder.Predict -t $data/data_trinity/Trinity.fasta --single_best_only --output_dir $data/data_transcoder