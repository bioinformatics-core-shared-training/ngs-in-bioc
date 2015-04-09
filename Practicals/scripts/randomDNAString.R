randomDNAString <-
function(N=500, minL=10, maxL=20){
    sapply(1:N, function(x) paste(sample(c("A", "T", "G", "C"),sample(minL:maxL),replace=TRUE),collapse=""))
    
}
