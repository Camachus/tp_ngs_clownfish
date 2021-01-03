#DE Analysis 

# Libraries:

library("tximport")
library("readr")
library(apeglm)
library("DESeq2",quietly= T)

#Location of the data: 

dir <- "/home/rstudio/data/mydatalocal/data/data_salmon"

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

#Scritp adadpted from Marthe Priouret due to my absence on the last day of the TP

# commande DESeq
resultsNames(dds)
resLFC <- lfcShrink(dds, coef="condition_orange_vs_white", type="apeglm")
# resLFC <- results(dds) : The function result makes the same work of lfcShrink but do not adjust the distortion related to small counts
# head(resLFC) to show the table
library(ggplot2)
# MAPLOT
ggplot(data = as.data.frame(resLFC),mapping = aes(x=log10(baseMean),
                                                  y = log2FoldChange,
                                                  color=padj<0.05,
                                                  size=padj<0.05,
                                                  shape=padj<0.05,
                                                  alpha=padj<0.05,
                                                  fill=padj<0.05))+
  geom_point() + 
  scale_color_manual(values=c("#999999","#cc8167"))+
  scale_size_manual(values=c(0.1,1))+
  scale_alpha_manual(values=c(0.5,1))+
  scale_shape_manual(values=c(21,21))+
  scale_fill_manual(values=c("#999999","#05100e"))+
  theme_bw()+theme(legend.position='none')
# dim(resLFC[is.na(resLFC$padj),]) pour savoir combien on basemean=na
# colour.de to select other colors

# VOLCANOPLOT
ggplot(data = as.data.frame(resLFC),mapping = aes(x = log2FoldChange,
                                                  y = -log10(padj),
                                                  color=padj<0.05,
                                                  shape=padj<0.05,
                                                  fill=padj<0.05))+
  
  geom_point() + 
  scale_color_manual(values=c("#999999","#cc8167"))+
  scale_size_manual(values=c(0.1,1))+
  scale_alpha_manual(values=c(0.5,1))+
  scale_shape_manual(values=c(21,21))+
  scale_fill_manual(values=c("#999999","#05100e"))+
  theme_bw()+theme(legend.position='none')

# List of the of the 10 most expressed genes
resLFC[is.na(resLFC$padj),"padj"] <- 1
top_DE_genes <- resLFC[resLFC$padj<1e-2 & abs(resLFC$log2FoldChange)>2,]
print (top_DE_genes[0:10,])

top_DE_genes_order <- top_DE_genes[order(top_DE_genes$padj),]

# We put in order the array top_DE_genes that we store in a new array top_DE_genes_order
print (top_DE_genes_order[0:10,])

# Last graph : ACP
rld <- rlog(dds, blind=FALSE)
plotPCA(rld, intgroup=c("condition"))
