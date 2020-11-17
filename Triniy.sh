# Set a working directory:
data="/home/rstudio/data/mydatalocal/data"
mkdir -p $data
cd $data

#Create afile to stock output of multiqc:
mkdir -p sra_data_trinity

# Make a list of SRR accessions:
SRR="SRR7591064
SRR7591065
SRR7591066
SRR7591067
SRR7591068
SRR7591069
"

FASTQ=$(ls $data/sra_data/*.fastq |paste -s -d, -)

Trinity --seqType fq --max_memory 50G -SS_lib_type R --CPU 14 --single $FASTQ \ #Espace \
--normalize_by_read_set --output $data/sra_data_trinity
