###Get repository of the course.
git clone https://github.com/bioinformatics-core-shared-training/ngs-in-bioc.git

cd ngs-in-bioc
##Get example data for sequencing practicals
wget https://www.dropbox.com/s/ve6o68hkbthe3lo/exampleData.zip
unzip exampleData.zip

##Download required R packages. Assumes R 3.2.0
R -f installBioCPkgs.R
##Remove some files that came from git 
rm -r images javascripts stylesheets params.json index.html exampleData.zip

##Put example data in the right place
mkdir Practicals/exampleData
mv exampleData/* Practicals/exampleData
rm -r exampleData/

##Get example breast cancer data for the first practical and put in Practicals folder
mkdir Practicals/nki
wget https://www.dropbox.com/s/82p2dcwwo3qnf21/nki.zip -P Practicals/nki
cd Practicals/nki
unzip nki.zip
rm nki.zip
