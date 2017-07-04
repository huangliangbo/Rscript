library(ggplot2)
library(ggrepel)
genes <- read.table("https://gist.githubusercontent.com/stephenturner/806e31fce55a8b7175af/raw/1a507c4c3f9f1baaa3a69187223ff3d3050628d4/results.txt", header = TRUE)
genes$Significant <- ifelse(genes$padj < 0.05, "FDR < 0.05", "Not Sig")

ggplot(genes, aes(x = log2FoldChange, y = -log10(pvalue))) +
    geom_point(aes(color = Significant)) +
    scale_color_manual(values = c("red", "grey")) +
    theme_bw(base_size = 12) + theme(legend.position = "bottom") +
    geom_text_repel(
        data = subset(genes, padj < 0.05),
        aes(label = Gene),
        size = 5,
        box.padding = unit(0.35, "lines"),
        point.padding = unit(0.3, "lines")
    )
