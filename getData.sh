
samtools view -h ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/other_exome_alignments/HG00096/exome_alignment/HG00096.mapped.illumina.mosaik.GBR.exome.20111114.bam 22 | samtools view -bS - > Day1/HG00096.chr22.bam
samtools index Day1/HG00096.chr22.bam
rm HG00096.mapped.illumina.mosaik.GBR.exome.20111114.bam.bai
 
mkdir Day2/bam
cd Day2/bam
wget archers.bio.cam.ac.uk/*
cd ../../


wget http://archers.bio.cam.ac.uk/cruk/16N_aligned.bam
wget http://archers.bio.cam.ac.uk/cruk/16N_aligned.bam.bai
wget http://archers.bio.cam.ac.uk/cruk/16T_aligned.bam
wget http://archers.bio.cam.ac.uk/cruk/16T_aligned.bam.bai
wget http://archers.bio.cam.ac.uk/cruk/18N_aligned.bam
wget http://archers.bio.cam.ac.uk/cruk/18N_aligned.bam.bai
wget http://archers.bio.cam.ac.uk/cruk/18T_aligned.bam
wget http://archers.bio.cam.ac.uk/cruk/18T_aligned.bam.bai
wget http://archers.bio.cam.ac.uk/cruk/19N_aligned.bam
wget http://archers.bio.cam.ac.uk/cruk/19N_aligned.bam.bai
wget http://archers.bio.cam.ac.uk/cruk/19T_aligned.bam
wget http://archers.bio.cam.ac.uk/cruk/19T_aligned.bam.bai

