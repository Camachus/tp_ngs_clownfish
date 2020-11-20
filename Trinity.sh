# Set a working directory:
data="/home/rstudio/data/mydatalocal/data"
mkdir -p $data
cd $data

#Create afile to stock output of multiqc:
mkdir -p data_trinity



FASTQ=$(ls $data/sra_data/*.fastq |paste -s -d, -)

Trinity --seqType fq --max_memory 50G --SS_lib_type R --CPU 14 --single $FASTQ \
--normalize_by_read_set --output $data/data_trinity
