count <- read.delim("output_score.txt", head=TRUE)
deg <- subset(count,select=c(GeneNames, log2fc, q.value), subset = (abs(log2fc) >=1 & q.value <= 0.001))
Significant <- count$GeneNames %in% deg$GeneNames

library(ggplot2)
p <- ggplot(count, aes(x = log2fc, y = -log10(q.value)))
p + geom_point(aes(colour=Significant)) +
	scale_color_manual(values = c('black','red'),
	                   breaks = c(0, 1),
	                   labels = c("FALSE", "TRUE")) +
	labs(title="Volcano Plot of DEGs(knockout vs wt)") +
    theme(plot.title = element_text(hjust = 0.5)) + 
	theme(plot.title = element_text(size = rel(1.2))) +
	ylab(expression(paste("log"[10], "q-value")))+
	xlab(expression(paste("log"[2], "Foldchange")))
