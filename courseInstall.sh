###Get repository of the course. Install data and R packages
git clone https://github.com/bioinformatics-core-shared-training/ngs-in-bioc.git

cd ngs-in-bioc
wget https://www.dropbox.com/s/ve6o68hkbthe3lo/exampleData.zip

unzip exampleData.zip
R -f installBioCPkgs.R
rm -r images javascripts stylesheets params.json index.html exampleData.zip
mkdir Practicals/exampleData
mv exampleData/* Practicals/exampleData
rm -r exampleData/
mkdir Practicals/nki

wget https://www.dropbox.com/s/82p2dcwwo3qnf21/nki.zip -P Practicals/nki

cd Practicals/nki
unzip nki.zip
rm nki.zip
