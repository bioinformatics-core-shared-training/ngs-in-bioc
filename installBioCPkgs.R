source("http://www.bioconductor.org/biocLite.R")
options(BioC_mirror = c("Cambridge" = "http://mirrors.ebi.ac.uk/bioconductor/"))
options(repos = c("CRAN" = "http://cran.ma.imperial.ac.uk"))
biocLite(c("Biostrings", "ShortRead", "DESeq", "edgeR","biomaRt", "BSgenome",
        "BSgenome.Dmelanogaster.UCSC.dm6", "org.Dm.eg.db",
        "TxDb.Dmelanogaster.UCSC.dm3.ensGene", "pasillaBamSubset", "pasilla",
        "rtracklayer", "ggbio", "vsn","gplots","RColorBrewer","chipseq","htSeqTools","limma","NBPSeq","tweeDEseqCountData","org.Hs.eg.db","Rcade", "ChIPQC","TxDb.Hsapiens.UCSC.hg19.knownGene","BSgenome.Hsapiens.UCSC.hg19","ChIPpeakAnno","statmod","locfit"))

##Also need to install spp_1.11.tar.gz which requires the 'boost' library.


