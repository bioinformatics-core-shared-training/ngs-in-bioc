####biomaRt

library(biomaRt)
listMarts()

ensembl <- useMart("ensembl", dataset="hsapiens_gene_ensembl")

listDatasets(ensembl)

listFilters(ensembl)

flt <- listFilters(ensembl)
flt[grep("entrez",flt[,1]),]

listAttributes(ensembl)

entrez <- c("673", "837")

attr <- c("entrezgene","hgnc_symbol","ensembl_gene_id","description")

myInfo <- getBM(filters="entrezgene",values=entrez,attributes=attr,
                mart=ensembl)
myInfo


getBM(c("ensembl_gene_id", "hgnc_symbol","entrezgene"),
      filters = c("chromosome_name","start","end"),
      values = list(16,1100000,1250000),mart=ensembl)

getBM(c("ensembl_gene_id", "start_position","end_position"),
      filters = c("ensembl_gene_id"),
      values = c("ENSG00000260702","ENSG00000260532","ENSG00000181791"),
      ensembl)

#####Genome sequence packages

library(BSgenome.Hsapiens.UCSC.hg19)
hg19 <- BSgenome.Hsapiens.UCSC.hg19
gr <- GRanges("chr16", IRanges(1100000, 1250000))
getSeq(hg19, gr)

####Organism-level packages

library(org.Hs.eg.db)
columns(org.Hs.eg.db)
keytypes(org.Hs.eg.db)

select(org.Hs.eg.db, keys=entrez,
       keytype="ENTREZID",
       columns=c("SYMBOL",
                 "CHR", "CHRLOC",
                 "CHRLOCEND"))

select(org.Hs.eg.db, keys = "GO:0003674",
       keytype = "GO", columns = "SYMBOL")

####Transcript databases

library(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
txdb
columns(txdb)
keytypes(txdb)

select(txdb, keys=entrez,
       keytype="GENEID",
       columns=c("TXID",
                 "TXCHROM", "TXSTART",
                 "TXEND"))


mygene <- select(txdb, keys = "673", keytype = "GENEID",
                 columns = c("EXONID", "EXONCHROM", "EXONSTART","EXONEND"))
mygene

GRanges(mygene$EXONCHROM, IRanges(mygene$EXONSTART,
                                  mygene$EXONEND))

trs <- transcripts(txdb)
trs

exs <- exons(txdb)
exs


exons <- exonsBy(txdb, "gene")
is(exons)
length(exons)
exons[["673"]]

gr <- exons[["49"]]
gr <- renameSeqlevels(gr,value = c("chr22"=22))

library(GenomicAlignments)

mybam <- "/home//participant/Course_Materials/Practicals/exampleData/NA19914.chr22.bam"
system.time(bam.sub <- readGAlignments(file = mybam,use.names = TRUE,param = ScanBamParam(which = gr)))

exonList <- split(gr, values(gr)$exon_id)
names(exonList)

exonList[[1]]
gr[1]

system.time(bam.sub2 <- lapply(exonList, function(x) readGAlignments(file=mybam,
                                                                     use.names=TRUE, 
                                                                     param=ScanBamParam(which=x))))
names(bam.sub2)
bam.sub2[[1]]
system.time(seqs <- getSeq(hg19, exons[["49"]]))

seqs
width(gr)


bam <- readGAlignments(file = mybam)
countOverlaps(gr, bam)

library(ggbio)
autoplot(bam.sub)
autoplot(bam.sub,stat="coverage")
autoplot(txdb,which=exons[["49"]])

tracks(autoplot(txdb,which=exons[["49"]]),
       autoplot(bam.sub,stat="coverage"))
