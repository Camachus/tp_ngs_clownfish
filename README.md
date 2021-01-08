# TP NGS Clowwnfish

_**Redmed of Miguel Camacho**_

_Actinoterygian_ fishes present different patterns of pigmentation. These patterns of adult pigmentation are important for ecology, development and genetics. 

_Actinoterygian_ fishes present 8 cell types of pigmentation compared  to mammals, that have only one. Two of these pigmentation cells are iridophore that refers to a reflective tissue and leucophore for white tissue.

Here, authors asked whether the white bars of the coral reef fish _**Amphiprion ocellaris**_, known as the clown fish, are composed of iridophores or with leucophores or maybe both. To answer this question, we used the transcriptomic analysis  through this TP NGS. 
 
 ![finding-nemo](Pictures/finding-nemo.jpg)

## Project      
Analysis of the _A. ocellaris_ fish skin transcriptome to find gene candidates involved in the presence of iridophores in white skin.

The Reference paper: Salis, P, Lorin, T, Lewis, V, et al. Developmental and comparative transcriptomic identification of iridophore contribution to white barring in clownfish. _Pigment Cell Melanoma Res._ 2019; 32: 391– 402. https://doi.org/10.1111/pcmr.12766

## Data-set 
Samples were taken from 3 individuals: each one with orange and white tissue (in total 6 samples).
The RNA-Senquencing method was carried out with the Illumina technology Signle-End (50 reads)

## Objective
 To determine the presence of the gen saiyan, a candidate gene involved in the presence of iridophores in white strips. 

---
## Analyses steps
### I. Download the reads for the study
  
  * **Downloading the RNA-seq files**. The script _`RNAseq_data.sh`_ describes the procedure used to get the fastaq files (by using their SSR accessions) from the NCBI database. We created the directory sra_data to store these fastaq files. 
  
 ![fastaq](Pictures/fastaq.jpg)

  * **Control of quality of the fastaq files**. We applied the FASTQC function to the reads. Script _`Control_quality.sh`_  describes the steps we did. We create an HTML file for each read with the quality of sequences. We obtained different statistics to measure and check the quality of fastaq files. One of the most important was **Per base sequence quality**. 
 
 ![per_base_sequece](Pictures/per_base_sequence.png)
 
   * **Multiple control of quality of the fastaq files**.  Using the MULTIQC function, we evaluated to quality of the assemble of all reads. See the script _`MultiQC.sh`_. After the running of MULTIQC function, we saw that the quality was acceptable so we did not need to clean the data. 

		![Multiqc](Pictures/Multiqc.jpg)
 
 ### II. Data assembly
 **Assembly of the reads**.  To assembly the sequences, we used the trinity function, which is detailed in this web site: https://github.com/trinityrnaseq/trinityrnaseq/wiki/Running-Trinity. Trinity used three modules (Ichworm, Chrysalis and Butterfly) to assemble the fastaq files into linear sequences. The script _`Trinity.sh`_ decribes how reads were assembled into a Fasta file.  Trinity also **groups** isoforms and separate paralogs.
 	Because the Trinity function could take long time, we used the `nohup` command to run the script. 
 
 
 ### III. Quantifying the expression of the transcripts 
After data assembly, we focused to quantify the transcript expression. For this, we used the tool Salmon, which analyzed whether a transcript was more express in our output of Trinity. By following indications from this web site: https://salmon.readthedocs.io/en/latest/salmon.html](https://salmon.readthedocs.io/en/latest/salmon.html), we created the script _`Salmon.sh`_. More the gene presented reads, the more this gene was expressed. 

 ![Salmon](Pictures/Salmon.jpg)
 The first column showed the name of the transcript. The second column, its length. The fourth column indicates the transcripts per million (TPM), which means the total number of reads normalized by the overall length.
 
 ### IV. Data annotation
 
 * **Comparation our data with a genome of reference** We downloaded the genome of _Stegastes partitus_ which presents a similar genome compared to the clownfish in the script _`escribir_el_nombre`._  The script _`Rename_transcript`_  renamed the _S. partitus_ sequences by using the command `awk`. The command `gunzip` was apply to unzid the downloaded genome. 

* **Analyses of the proteomic data of our transcripts** We use the transcoder tool to found the conserved coding regions. Again, following the steps from this web site:  https://github.com/TransDecoder/TransDecoder/wiki, we made the script `transcoder.sh`. 
   Before the blast, we rename the Transdecoder's output with the following code: 
	`awk '{print $1}' Trinity.fasta.transdecoder cds > rename.cds`
	
* **Evaluation of homologies between transcripts of _A. ocellaris_ and their references _S. partitus_.** 

   See the script _`blast.sh`_. 
   ![blast](Pictures/blast.jpg)
   
   The blast tool helps us to compare our data (clown fish) with the reference data. The first column refers to the name of trinity transcripts and second ones to the references transcripts. The important data is carry by the column 9th show the blast e-value which means to the number of expected hits of similar quality (score). A smaller e-value indicates a better match whereas the bit score showed in the last column indicates the bit-score. The higher the bit-score, the better the sequence similarity. 
  
   
   The command `cut -f1 blast |sort |uniq |wc -l` allows to see how many hit the blast found.
 
 ###  V. Statistical analysis. 
 
Because we had a few samples transcripts, we could not analyzed by using the classical statistics. So we use the tool DeSeq2, from the R package, to measure the differential expression between the orange and the white tissue with multiple tests. In the script `DeSeq2.R`, we used the transcript information from salmon to analyze them. In fact, DeSeq2 corrects the the p-value in a padj by taking an an approximate value of false positive. 

The "white" condition was used as a reference for further analysis. 
Here is the table showing the 10 genes most diferentially expressed between the white and orange tissues. 

![DeSeq2](Pictures/DeSeq2.jpg)
 
_BaseMean_: Refers to the signal intensity (A high basemean means a high gene expression).
_Log2Foldchange_: Indicates the ratio of orange/white tissue of gene expression. A Log2folchange=0 means at similar gene expression either in white or orange tissue. If the ratio Lof2folchange is >0 refers that a gene expression is bigger in orange tissue compared to the white tissue; and if the ratio is <0, it means the inverse. 
_lfcSE_: Correspond to an standar variation of the log2Foldchange.
_p-value_: Refers to the p-value of the test.
_padj_ = It its the p-value adjusted with the False Discovery Rate (FDR).

* The **Maplot** graph showing the log2FoldChange of transcripts as a function of log10(baseMean).

![Maplot](Pictures/Maplot.png)

The Maplot was created with the _ lfcShrink_ function. The red box refers to the the genes overexpressed in the orage tissue whereas the blue box indicates the genes overexpressed in the white tissue. 

* The **Volcano plot** showed the results with the adjusted p-value and the log2FC. The genes which present a low padj are those ones with an important difference of expression between the white/orange tissues.

![Volcano](Pictures/Volcano_plot.jpg)

* Principal Component Analysis (PCA). A PCA helped us to visualize separation of samples according to their tissue color. 

![PCA](Pictures/PCA.png)

* Manual annotation of top differentially expressed genes

Then we aimed to find the real IDs of the 10 most differentially expressed genes to be able to compare our results with the article. 

With used the Trinity identifiers (that we blasted with the reference genome) to find the gene names by using the command `grep`. However, there was an error in the script `parse.awk` (to rename the reference specie genes), a mismatch was generated in the table of Trinity ID and the gene names. This is why we used the Ensembl ID in the Ensembl database to find the gene names. 

![Manual_annotation](Pictures/Manual_annotation.jpg)

(Figure from: Vinciane Piveteau)


Conclusion

We tried to recapitulate the transcriptomic method used in the article to find the genes expressed in the white tissue. Compare to the paper's 10 most differentially expressed genes, we found 7 of the 10 most differentially expressed genes being _saiyan_ and interesting gene responsable for the white pigmentation 
We also found iridophores marker genes like _saiyan, apoD1a_ and _gpnmb_. This allowed us to confirm the microcospic analysis findings. So the white skin in _A. ocellaris_ presents iridophores. 

It is important to mention that the our results are not identical to the article. This could be due because in some scripts we used different functions like `lfcShrink` instead of the authors' function `results`. Futhermore, the script lines may differ or the update software. 

Acknowledgments

I want to thank Corentin Dechaud for his patience during the TP, specially with me. I want to thanks my group (Marthe, Vinciane and Paul), I really enjoyed to work together in the clown fish project. Finally, I thank Professor Marie Semon for her enthusiasm and the good course organization. 






