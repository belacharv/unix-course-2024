library(readr)
library(data.table)
d <- read_tsv("~/projects/final_task/qual_table3.tsv")
d1 <- read_tsv("~/projects/final_task/filtered_table.tsv",col_names = FALSE)
colnames(d)[1] <- "CHROM"
colnames(d1) <- c("CHROM","POS","ID","REF","ALT","QUAL","DEPTH","TYPE")
View(d)

# 1. Distribution of PHRED qualities over the whole genome and by chromosome
d %>% 
  filter(QUAL < 500) %>% 
  ggplot(aes(CHROM, QUAL)) + 
  geom_boxplot(aes(fill = CHROM),show.legend = FALSE) +
  theme(axis.text.x = element_text(angle = 90))
ggsave(filename = "plot1.png", path = "~/projects/final_task/",width = 16, height = 9, units = "cm")


# 2. Distribution of read depth (DP) over the whole genome and by chromosome
d1 %>% 
  filter(QUAL < 500) %>%
  ggplot(aes(CHROM, DEPTH)) + 
  geom_boxplot(aes(fill = CHROM),show.legend = FALSE) +
  theme(axis.text.x = element_text(angle = 90))
ggsave(filename = "plot2.png", path = "~/projects/final_task/",width = 16, height = 9, units = "cm")

# 3. Distribution of PHRED qualities INDELS vs. SNPs
d1 %>% 
  filter(QUAL < 500) %>%
  ggplot(aes(TYPE,QUAL)) + 
  geom_violin(aes(fill = TYPE),draw_quantiles = 0.5) #+
  #theme(axis.text.x = element_text(angle = 90))
ggsave(filename = "plot3.png", path = "~/projects/final_task/",width = 16, height = 9, units = "cm")

col0 <- c("#f0bf30","#91e8ef")
# 4. Distribution of read depth (DP) qualities INDELS vs. SNPs
d1 %>% 
  filter(QUAL < 500) %>%
  ggplot(aes(TYPE,DEPTH)) + 
  geom_violin(aes(fill = TYPE),draw_quantiles = 0.5) +
  scale_fill_manual(values = col0)
#theme(axis.text.x = element_text(angle = 90))
ggsave(filename = "plot4.png", path = "~/projects/final_task/",width = 16, height = 9, units = "cm")