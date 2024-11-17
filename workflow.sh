#!/bin/bash

# Creating a workflow file


INPUT=~/projects/final_task/luscinia_vars.vcf.gz

# First task - PHRED qualities with the header
< $INPUT zcat | grep -v '^##' | cut -f1-6 | grep -E 'chr[0-9]{1,2}\s|^#' | less -S  > ~/projects/final_task/qual_table3.tsv


# Second task - PHRED qualities without the header so it can be concatenated with the rest of the files
< $INPUT zcat | grep -v '^#' | cut -f1-6 | grep -E 'chr[0-9]{1,2}\s|^#' | less -S  > ~/projects/final_task/qual_table4.tsv


# Second task - real depth (DP) filtered
< $INPUT zcat | grep -v '^#' | cut -f1-8 | grep -o  'DP=[^;]*' | sed 's/DP=//' | less -S > ~/projects/final_task/dp_filtered.tsv

# Third task - INDELS vs SNPs
< $INPUT zcat | grep -v '^#' | cut -f1-8 |  awk '{if($0 ~ /INDEL/) print "INDEL"; else print "SNP"}' | less -S > ~/projects/final_task/snp.tsv


# Concatenating all the files together to one
paste qual_table4.tsv dp_filtered.tsv snp.tsv > filtered_table.tsv 




