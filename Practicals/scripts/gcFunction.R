gcFunction <- function(x){
  
  alf <- alphabetFrequency(x, as.prob=T)
  rowSums(alf[,c("G","C")])
}
