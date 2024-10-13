
# Data exploration: bumber of variants
INPUT=data/Ensembl.NCBIM37.67.bed
< $INPUT cut -f1 | sort | uniq -c | less

#Table of the above
< $INPUT cut -f1 | sort | uniq -c | awk "{print $2, $1}" | head

#Shell filtering function
 fastq-min-length() { paste - - - - | sort | awk -v min_len="$1" '(length($2) > min_len)' | tr "\t" "\n" ;}
