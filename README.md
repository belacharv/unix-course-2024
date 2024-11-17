Hello and welcome to my final task code for unix-course. 
From the possible tasks we could have chosen, I decided to do first four (but of course there´s no need to check all of them to complete the final task).
1. Distribution of PHRED qualities over the whole genome and by chromosome
2. Distribution of read depth (DP) over the whole genome and by chromosome
3. Distribution of PHRED qualities INDELS vs. SNPs
4. Distribution of read depth (DP) qualities INDELS vs. SNPs


## List of files you can find in this repo:
- dp_filtered.tsv  *only DP values filtered*
- filtered_table.tsv *table used for the 2 to 4th task*
- luscinia_vars.vcf.gz *input file*
- plot1.png *result task 1*
- plot2.png *result task 2*
- plot3.png *result task 3*
- plot4.png *result task 4*
- qual_table3.tsv *table used for the first task, first 6 columns with the header*
- qual_table4.tsv  *first 6 columns without the header*
- snp.tsv  *only SNP/INDEL values filtered*
- workflow.sh  *file with complete workflow in unix*

# 1. Distribution of PHRED qualities over the whole genome and by chromosome
In this task, the main goal was to get a table, where we can access PHRED qualities (in the input file named as QUAL) and divide them for each chromosome (the first column in the input file)
The code in unix:
*setting input file as an INPUT*

      INPUT=~/projects/final_task/luscinia_vars.vcf.gz  

      < $INPUT zcat | grep -v '^##' | cut -f1-6 | grep -E 'chr[0-9]{1,2}\s|^#' | less -S  > ~/projects/final_task/qual_table3.tsv
decompressing the file, excluding first few rows starting with ## (but header still present), extracting only first 6 columns, getting rid of the files named differently than "chr[number on 1st and 2nd possision]" and then saving it to qual_table3.tsv

The code in R:
d <- read_tsv("~/projects/final_task/qual_table3.tsv")
colnames(d)[1] <- "CHROM"

*# 1. Distribution of PHRED qualities over the whole genome and by chromosome*

      d %>% 

   filtering the quality smaller than 500
      
      filter(QUAL < 500) %>%

  
 setting up the x and y axis
 
     ggplot(aes(CHROM, QUAL)) + 

 creating boxplots for each chromosome
 
    geom_boxplot(aes(fill = CHROM),show.legend = FALSE) +

moving the description so it´s readable

     theme(axis.text.x = element_text(angle = 90))

   
saving the final plot
   
      ggsave(filename = "plot1.png", path = "~/projects/final_task/",width = 16, height = 9, units = "cm")

# 2. Distribution of read depth (DP) over the whole genome and by chromosome
This task is very similar as the previous one, except we want to get the read depth (DP)

Second task - PHRED qualities without the header so it can be concatenated with the rest of the files

      < $INPUT zcat | grep -v '^#' | cut -f1-6 | grep -E 'chr[0-9]{1,2}\s|^#' | less -S  > ~/projects/final_task/qual_table4.tsv

decompressing the file, getting rid of the first lines (header included), extracting only first 6 columns, filtering out the lines with wrong format of chromosome, saving it to qual_table4.tsv

Second task - real depth (DP) filtered

      < $INPUT zcat | grep -v '^#' | cut -f1-8 | grep -o  'DP=[^;]*' | sed 's/DP=//' | less -S > ~/projects/final_task/dp_filtered.tsv

Extracting only DP and saving it to the dp_filtered.tsv






Third task - INDELS vs SNPs

      < $INPUT zcat | grep -v '^#' | cut -f1-8 |  awk '{if($0 ~ /INDEL/) print "INDEL"; else print "SNP"}' | less -S > ~/projects/final_task/snp.tsv






