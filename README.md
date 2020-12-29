# TP NGS Clowwnfish

_**Redmed Miguel Camacho**_

_Actinoterygian_ fishes present different patterns of pigmentation. These patterns of adult pigmentation are important for ecology, development and genetics. 

_Actinoterygian_ fishes present 8 cell types of pigmentation compared  to mammals, that have only one. Two of these pigmentation cells are iridophore that refers to a reflective tissue and leucophore for white tissue.

Here, authors asked whether the white bars of the coral reef fish _**Amphiprion ocellaris**_, known as the clown fish, are composed of iridophores or with leucophores or maybe both. To answer this question, we used the transcriptomic analysis  through this TP NGS. 
 
 ![finding-nemactinoterygian fisheso](finding-nemo.jpg)

## Project                                          16/11/200
Analysis of the _A. ocellaris_ fish skin transcriptome to find gene candidates involved in the presence of iridophores in white skin.

The Reference paper: Salis, P, Lorin, T, Lewis, V, et al. Developmental and comparative transcriptomic identification of iridophore contribution to white barring in clownfish. _Pigment Cell Melanoma Res._ 2019; 32: 391– 402. https://doi.org/10.1111/pcmr.12766

## Dataset 
Samples were taken from 3 individuals: each one with orange and white tissue (in total 6 samples).
The RNA-Senquencing method was carried out with the Illumina technology Signle-End (50 reads)

## Objective
 To determine the presence of the gen saiyan, a candidate gene involved in the presence of iridophores in white strips. 

## Analyses steps
### I. Download the reads for the study
  
  * **Downloading the  
_RNA_seq_scrip.sh_ 

Download the reads for the study. 

17/11/2020 
_Control_quality.sh_ : Create an HTML file for each file o reads with the quality of sequences

_MultiQC.sh_ : Create one HTML file wi

_Trinity.sh_ : Assemble the reads of sequencing



18/11/22

_Salmon.sh_ : quantify the expression of the transcripts. Il vaidre tel transcritp va etre plus exprime dans ce echantillon. plus le gene contient des read plus le gene sera exprime. 