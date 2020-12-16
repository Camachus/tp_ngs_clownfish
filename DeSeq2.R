#DE Analysis 

# Libraries:

library("tximport")
library("readr")
library(apeglm)
library("DESeq2",quietly= T)

#Location of the data: 

dir <- "/home/rstudio/data/mydatalocal/data/"

#Import the data:
samp.name <- c("SRR7591064","SRR7591065","SRR7591066","SRR7591067","SRR7591068","SRR7591068")
samp.type <- c("orange","white","orange","orange","white","white")
samples <- data.frame(run=samp.name, condition= samp.type)

files  <- file.path(dir,"data_salmon", samples$run, "quant.sf")
names(files)<- samples$run

#Data frame to know association gene transcript:
tx2gene <- read.table(file = paste(dir,"data_trinity/Trinity.fasta.gene_trans_map",sep=""),
                                 header = FALSE, sep = "\t",col.names = c("geneid","txname")) [,c(2,1)]

#txgene <- as.character(read.table(files[1],header = T,sep ="\t")$Name)
                      

txi <- tximport(files,type='salmon',tx2gene=tx2gene)

#DE analysis
ddsTxi <- DESeqDataSetFromTximport(txi,
                                   colData = samples, 
                                   design = ~ condition)
keep <- rowSums(counts(ddsTxi)) >= 10
dds <- ddsTxi [Keep,]
dds$condition <- revelel(dds$condition, ref = "white")
dds <- DESeq(dds)
