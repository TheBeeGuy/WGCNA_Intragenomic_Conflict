

###just use the for loop to get a working function. this is the function to beat
find_keggs<-function(mod_genes ,bg=1,rows=40,...){ #module genes is data frame of gene names, each column a diferent list
  n<-Sys.time()
  kegg_pathways_WGCNA<-data.frame(matrix(data=NA,
                                         nrow = rows,
                                         ncol = dim(mod_genes)[2]))#define new data frame
  #download_KEGGfile(species="ame")

    background<-mod_genes[,bg]#background is either the column index or column name of background gene set


  for(i in 1:dim(mod_genes)[2]){ ##for each column, index
    genes<-mod_genes[,i] #get list of genes
    x<-find_enriched_pathway(genes, #perfrom kegg on genes
                             species='ame', #specify honey bees
                             returned_adjpvalue = 0.051,#set alpha
                             refGene = background,
                             download_latest = F
                             )
    pathways<-x$stastic$Pathway_Name #extract genes
    length(pathways)<-rows ##set uniform arbitrary length, > # keggs
    kegg_pathways_WGCNA[,i]<-pathways##grow the list without referencing full df
  }
  print(Sys.time()-n)##for my data, 54 seconds
  return(kegg_pathways_WGCNA) #hand it back
}


# setwd("C:/Users/Rong/Box Sync/Projects/BPO_rnaseq/BPO_rnaseq")
# load("module_sig_genes.RData")
# attach(module_significant_genes)
#
# require(KEGGprofile)
# require(tidyverse)
#
# find.kegs<-function(data,background="background", ...){
#   ##takes a data frame of list of genes with column names
#   ##background is the set of all background, and columns contain interesting gene lists
#   n<-Sys.time()#figure out how long it took, sets beggining
#   background<-data[,background]#find background gene list
#   data<-data%>%select(-background) ##remove background from list
#   dims<-dim(naremoved)[2]##record number of columns
#   lists<-lapply(1:dims, #set column index, pass to function
#                 function(x,y) #function with two arguments
#                   find_enriched_pathway(y[,x],
#                                         species="ame",
#                                         returned_adjpvalue = 0.051), #for indexes in data frame, find genes
#                 y=naremoved) #set data frame
#   ##lists is now a series of lists, one for each column in original data
#   ##the problem is that multiple lists of lists are retained for each column
#   keggs<-lapply(1:dims, ##column index
#                 function(x,y) ##pass to function, two arguments
#                   print(y[[x]]$stastic$Pathway_Name), #x is indexes, estract pathways we want
#                 y=lists) ##takes a list of lists
#   ##now you only have a single list for each column, but those lists are variable length
#   unlist<-data.frame(matrix(unlist(keggs),ncol = dims, byrow = F))
#
#   print(Sys.time()-n)##how long?
#   #return(unlist)
# }
#
# lists[,1]$stastic$Pathway_Name
#
# #https://www.r-bloggers.com/using-apply-sapply-lapply-in-r/
# naremoved<-module_significant_genes[is.na(module_significant_genes)==FALSE,]
#
#
# as.data.frame(sapply(module_significant_genes[, 1:4], find_enriched_pathway(species="ame")))
# work<-sapply(1:dim(naremoved)[2],
#              function(x) find_enriched_pathway(naremoved[,x],
#                                                species="ame"))
# ##not working
# sapply(1:dim(naremoved)[2], function(x,y) find_enriched_pathway(y[,x],
#                                                                 species="ame"),y=naremoved)
#
# ##from wgcna
# #this is what I wont to do, but more efficient
#
#
# kegg_pathways_WGCNA<-c()
# for(i in 1:dim(module_significant_genes)[2]){
#   genes<-module_significant_genes[,i]
#   x<-find_enriched_pathway(genes,species='ame')
#   pathways<-x$stastic$Pathway_Name
#   length(pathways)<-30
#   kegg_pathways_WGCNA<-cbind(kegg_pathways_WGCNA,pathways)
# }
#
#
# ####trying to make it more efficient
# kegg_pathways_WGCNA<-data.frame()
# for(i in 1:dim(module_significant_genes)[2]){
#   genes<-module_significant_genes[,i]
#   name<-colnames(module_significant_genes)[i]
#   x<-find_enriched_pathway(genes,species='ame',refGene = background,returned_adjpvalue = 0.05)
#   pathways<-x$stastic$Pathway_Name
#   length(pathways)<-30
#   kegg_pathways_WGCNA$name<-pathways
# }

