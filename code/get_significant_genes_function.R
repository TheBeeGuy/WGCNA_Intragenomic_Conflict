get_sig_genes <- function(x,alpha = 0.05) {
  significant<-subset(x, padj < alpha)#subset only with p below alpha threshold
  significant%>%row.names() #report only the names of the gene
}

##assume x is results output from DEseq,
#with a matrix of genes, and their pvalues