#!/bin/bash
wget ftp://ftp.ncbi.nlm.nih.gov/hapmap/phase_3/hapmap3_reformatted/YRI.hmap.gz
wget ftp://gsapubftp-anonymous@ftp.broadinstitute.org/bundle/b36/dbsnp_138.b36.vcf.gz
gunzip *.gz
sed 's/chr23/X/g' YRI.hmap > YRI_modified.hmap
sed 's/chr26/MT/g' YRI_modified.hmap > YRI_modified_1.hmap
awk '{gsub(/chr/,""); print}' YRI_modified_1.hmap > YRI_modified_2.hmap
module load GATK/3.3-0-Java-1.7.0_80
java -jar $EBROOTGATK/GenomeAnalysisTK.jar -R human_b36_both.fasta  -T VariantsToVCF  -o YRI.vcf  --variant:RawHapMap YRI_modified_2.hmap  --dbsnp dbsnp_138.b36.vcf
