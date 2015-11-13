mkdir Day1/alignment-demo
cd Day1/alignment-demo
wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX%2FSRX483%2FSRX483591/SRR1186252/SRR1186252.sra
fastq-dump SRR1186252.sra
wget https://www.dropbox.com/s/68p2g96v5fpun5f/SRR1186252_trimmed.fq.chr6.fq
wget http://hgdownload.cse.ucsc.edu/goldenpath/hg19/chromosomes/chr6.fa.gz
gunzip chr6.fa.gz
mv chr6.fa hg19chr6.fa
cd ../../
### 1000 Genomes bam for Day 2

samtools view -h ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/other_exome_alignments/HG00096/exome_alignment/HG00096.mapped.illumina.mosaik.GBR.exome.20111114.bam 22 | samtools view -bS - > Day2/HG00096.chr22.bam
samtools index Day2/HG00096.chr22.bam
rm HG00096.mapped.illumina.mosaik.GBR.exome.20111114.bam.bai
 
mkdir Day2/bam
cd Day2/bam
wget training.bio.cam.ac.uk/bam.tar.gz
cd ../../

cd Software
##Get latest version of bowtie and tophat

wget http://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.2.5/bowtie2-2.2.5-linux-x86_64.zip
unzip bowtie2-2.2.5-linux-x86_64.zip

wget http://ccb.jhu.edu/software/tophat/downloads/tophat-2.1.0.Linux_x86_64.tar.gz
gunzip tophat-2.1.0.Linux_x86_64.tar.gz
tar xvf tophat-2.1.0.Linux_x86_64.tar

wget http://cole-trapnell-lab.github.io/cufflinks/assets/downloads/cufflinks-2.2.1.Linux_x86_64.tar.gz
gunzip cufflinks-2.2.1.Linux_x86_64.tar.gz
tar xvf cufflinks-2.2.1.Linux_x86_64.tar

rm *.tar *.zip

###Get chromosome 22 fasa

cd ../ref_data
wget http://hgdownload-test.cse.ucsc.edu/goldenPath/hg19/chromosomes/chr22.fa.gz
gunzip chr22.fa.gz

##Build bwa and bowtie indices
mkdir bwa
ln -s $(pwd)/chr22.fa bwa/
bwa index bwa/chr22.fa

mkdir bowtie

../Software/bowtie2-2.2.5/bowtie2-build chr22.fa bowtie/chr22

mkdir whole_genome
cd whole_genome
wget ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/reference/human_g1k_v37.fasta.gz
mkdir bwa
mkdir bowtie
ln -s $(pwd)/human_g1k_v37.fasta.gz bwa/
bwa index -p hg19 bwa/human_g1k_v37.fasta.gz
../../Software/bowtie2-2.2.5/bowtie2-build human_g1k_v37.fasta.gz bowtie/hg19

cd ../..
