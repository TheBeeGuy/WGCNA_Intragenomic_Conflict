## This function takes a list of genes, a reference conversion table, and a common primary key, and the desired output. It does a left join to find all the corresponding Entrez Ids, and outputs the entrez ids. 
#This assumes the reference table has a column with name specified by on argument, and that it is output column specified by out. Defaults are to join on "Beebase" and output the 'Entrez' Id.

convert_entrez<- function(beebase_gene_list, ref, on = "Beebase", out = "Entrez"){
    gene_names<- beebase_gene_list%>%as.data.frame()
    colnames(gene_names)<- on
    gene_entrez<-left_join(gene_names,ref)%>%distinct
    return(unique(gene_entrez[,out]))
}


# This function takes a table, and applies the convert_entrez function columnwise. It passes every column and the reference file to the convert entrez file.
#if on and out need to be specified, must add them.

convert_table <- function(table, ref, on = "Beebase", out = "Entrez"){
    dimensions <- dim(table)
    row = dimensions[1]
    col = dimensions[2] 
    entrez<-data.frame(matrix(NA, nrow = row, ncol = col))
    for (i in 1:col){
        x<-convert_entrez(table[,i],ref)
        length(x)<-row
        entrez[,i]<-x
    }
    colnames(entrez)<-colnames(table)
    return(entrez)
    
}
