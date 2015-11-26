###Get repository of the course.
git clone https://github.com/bioinformatics-core-shared-training/ngs-in-bioc.git

cd ngs-in-bioc
##Get example data for sequencing practicals
samtools view -h ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/other_exome_alignments/HG00096/exome_alignment/HG00096.mapped.illumina.mosaik.GBR.exome.20111114.bam 22 | samtools view -bS - > Day1/HG00096.chr22.bam
samtools index Day1/HG00096.chr22.bam
rm HG00096.mapped.illumina.mosaik.GBR.exome.20111114.bam.bai

##Download required R packages. Assumes R 3.2.0
R -f installBioCPkgs.R
##Remove some files that came from git 
rm -r images javascripts stylesheets params.json index.html

##Get example breast cancer data for the first practical and put in Practicals folder
mkdir Day1/nki
R -f getNKIData.R
