#Create a working directory for your Control analysis

mkdir -p sra_data_quality



# For each SRR accession, do a control quality of eahc file in sra_data folder :
``
sra_data="/home/rstudio/data/mydatalocal/data/sra_data"
fastq=$sra_data/*.fastq


for var_a in $fastq
do


fastqc -o sra_data_quality -t 16 $var_a
done

