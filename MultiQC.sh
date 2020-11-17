# Create a working directory:
data="/home/rstudio/data/mydatalocal/data"
mkdir -p $data
cd $data

#Create afile to stock output of multiqc:
mkdir -p sra_data_multiqc



multiqc /home/rstudio/data/mydatalocal/tp_ngs_clownfish/sra_data_quality/*.zip -o $data/sra_data_multiqc

