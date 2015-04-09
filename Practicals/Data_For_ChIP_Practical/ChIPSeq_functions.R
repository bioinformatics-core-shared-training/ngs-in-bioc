Bed2GRanges <- function(BedFileName){
    BedFile <- read.delim(BedFileName,sep="\t",header=F)
      StartPos <- 2
      EndPos <- 3
      ChrPos <- 1
      TempRanges_Bed <- GRanges(seqnames=as.vector(BedFile[,ChrPos]),IRanges(start=as.numeric(as.vector(BedFile[,StartPos])),end=as.numeric(as.vector(BedFile[,EndPos]))),strand=rep("*",nrow(BedFile)))
      if(ncol(BedFile) > 3){
		elementMetadata(TempRanges_Bed) <- BedFile[,-c(ChrPos,StartPos,EndPos)]
		colnames(elementMetadata(TempRanges_Bed)) <- c("Peak_ID","Score")
	}
      TempRanges_Bed
}

MakeConsensusSet <- function(PeakFileList){

  for(i in 1:length(PeakFileList)){
    if(i == 1){
      ToMerge <- PeakFileList[[i]]
    }else{
      ToMerge <- c(ToMerge,PeakFileList[[i]])

    }
  }
  NonOverlappingSet <- reduce(ToMerge)
  Temp <- do.call(cbind,lapply(PeakFileList,function(x)countOverlaps(NonOverlappingSet,x)))
  Temp[Temp > 1] <- 1
  elementMetadata(NonOverlappingSet) <- Temp
  return(NonOverlappingSet)
}

GetAverageSignalOverRanges <- function(bwfile,selection,Window){
  resizedselection <- resize(selection,fix="center",Window)
  BWSLeft <- BigWigSelection(ranges = resizedselection)
  TempLeft <- import(bwfile,which=resizedselection,selection = BWSLeft)
  CovResLeft <- rep(TempLeft$score,width(TempLeft))
  YouLeft <-   matrix(CovResLeft,ncol=(Window),byrow=T)
  LeftMatrix1 <- apply(YouLeft, MARGIN = 2, FUN = function(X) (X - min(X))/diff(range(X)))
  Leftmeans <- colMeans(YouLeft)
  return(Leftmeans)
}
