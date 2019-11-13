#get number of gene overlaps
m_intersect <- function(var1,var2){intersect(var1,var2)%>%unique()%>%length()}

#get number of unique genes
unique_length<-function(x){length(unique(x))}
