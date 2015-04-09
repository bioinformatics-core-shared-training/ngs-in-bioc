string <- "The quick brown fox jumps over the lazy dog"

string2 <- c("The", "quick", "brown", "fox", "jumps", "over" ,"the","lazy","dog")


rand <- sapply(1:100, function(x) paste(sample(c("A", "T", 
                                                 "G", "C"), sample(10:20),replace=TRUE),
                                        collapse=""))
randomStrings <- rand
myseq <- rand[1:4]
myseq



myseq 

gsub("ATG", "atg", myseq)

nchar(myseq)
substr(myseq, 1,3)


library(Biostrings)
myseq <- DNAStringSet(randomStrings)


subseq(myseq, 1, 3)


width(myseq)
length(width(myseq))
table(width(myseq))


myseq[width(myseq)>19]
myseq[as.character(substr(myseq,1,3))=="TTC"]



alphabetFrequency(myseq[1:4,], baseOnly=TRUE)
af <- alphabetFrequency(myseq, baseOnly=TRUE)
myseq[af[,1] ==0,]

boxplot(af)

myseq
reverse(myseq)
reverseComplement(myseq)


translate(myseq)


library(BSgenome)
available.genomes()
available.genomes()[23:25]



library(BSgenome.Hsapiens.UCSC.hg19)
hg19 <- BSgenome.Hsapiens.UCSC.hg19::Hsapiens
hg19



tp53 <- getSeq(hg19, "chr17", 7577851, 7590863)
tp53
as.character(tp53)
alphabetFrequency(tp53,baseOnly=TRUE)
subseq(tp53, 1000,1010)


system.time(tp53 <- getSeq(hg19, "chr17", 7577851, 7598063))


translate(subseq(tp53, 1000,1010))
reverseComplement(subseq(tp53, 1000,2000))



library(ShortRead)
fq <- readFastq("exampleData//sample.fq")
fq

sread(fq)
quality(fq)

id <-ShortRead:::id

id(fq)


abc <- alphabetByCycle(sread(fq))
abc[1:4, 1:8]

phred <- 1:9
phreda <- paste(sapply(as.raw((phred)+33), rawToChar), collapse=""); phreda
as.integer(charToRaw(phreda))-33
round(10^((-(as.integer(charToRaw(phreda))-33)/10)),2)


quality(fq)[1]
as.integer(charToRaw(">>>>>>>>>>>>>>>>>>>>><>>>>>+>+:48><"))-33


qual <- as(quality(fq), "matrix")
dim(qual)
qual[1,]


plot(colMeans(qual), type="b")


tbl <- tables(fq)
names(tbl)
tbl$top[1:5]


head(tbl$distribution)

subseq(sread(fq), 1, 10)

system.time(aln <- matchPattern(as.character(sread(fq)[2]),hg19[["chr22"]]))
aln


sread(fq)[2]
getSeq(hg19, "chr1", 249066163, 249066197)
identical(as.character(sread(fq)[2]), as.character(getSeq(hg19,"chr22", 16050151, 16050218)))


ir <- IRanges(start = c(7,9,12,14,22:24), 
              end=c(15,11,12,18,26,27,28))


start(ir)
end(ir)
width(ir)


ir2 <- IRanges(start(ir) + 5, end(ir) + 5) 

identical(ir2, shift(ir, 5))


shift(ir, 7:1)

resize(ir,3)

reduce(ir)

gaps(ir)

cvg <- coverage(ir)
cvg
as.vector(cvg[1:12])


ranges(slice(coverage(ir), 2))

ir3 <- IRanges(start = c(1, 14, 27), end = c(13,
                                             18, 30))
query <- ir
subject <- ir3
ov <- findOverlaps(query, subject)
ov

query[queryHits(ov)]

subject[subjectHits(ov)]

intersect(ir,ir3)

setdiff(ir,ir3)


nearest(ir,ir3)

gr <- GRanges(rep("chr1",length(ir)), ranges=ir)
gr

reduce(gr)
shift(gr,5)


gr <- GRanges(c("A","A","A","B","B","B","B"), ranges=ir)
gr


reduce(gr)


seqlevels(gr)

gr <- renameSeqlevels(gr, c(A = "chr1", B="chr2"))
gr


meta <- data.frame(SomeVals = runif(n=length(gr), 100,200),
                   OtherVals = runif(n=length(gr), 0,1),
                   SomeChars = sample(LETTERS,length(gr))
)
mcols(gr) <- meta 


gr[1:5]

gr[values(gr)$SomeVals > 150]

gr[order(values(gr)$OtherVals)]


suppressPackageStartupMessages(library(pasillaBamSubset))
library(GenomicAlignments)
mybam <- untreated3_chr4()
options(width=60)

bam <- readGAlignments(mybam,use.name=TRUE)

table(strand(bam))
summary(width(bam))
range(start(bam))
cigar(bam)


shift(ranges(bam),10)



flank(ranges(bam),100,both=T)
coverage(ranges(bam))


bam[start(bam) < 20100 & end(bam) > 20000, ]
gr <- GRanges("chr4", IRanges(start = 20000, end = 20100))
gr



findOverlaps(gr,bam)


bam[subjectHits(findOverlaps(gr,bam))]

bam.sub <- bam[bam %over% gr]
bam.sub


system.time(bam.sub <-
              readGAlignments(file=mybam,
                              use.names=TRUE, 
                              param=ScanBamParam(which=gr)))