# Make sure you have loaded the module for compiler
# First clean the make file
## make clean 
module load compiler/gcc/7.1
if [ -z $WORK ]; then WORK=`pwd`; fi

####  Download reference genome    ####
cd $WORK/
mkdir SANVA_reference_genome
cd SANVA_reference_genome
wget ftp://igenome:G3nom3s4u@ussd-ftp.illumina.com/Staphylococcus_aureus_NCTC_8325/NCBI/2006-02-13/Staphylococcus_aureus_NCTC_8325_NCBI_2006-02-13.tar.gz
tar -xzf Staphylococcus_aureus_NCTC_8325_NCBI_2006-02-13.tar.gz
rm Staphylococcus_aureus_NCTC_8325_NCBI_2006-02-13.tar.gz

#######   Download softwares    #######
cd $WORK
mkdir SANVA-softwares
cd SANVA-softwares/
####      Bioconda          ####
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
sh Miniconda3-latest-Linux-x86_64.sh
conda update conda
conda activate ~/miniconda3
#conda install python=3.7
conda install -c r r 

conda install -c bioconda trimmomatic 
conda install -c conda-forge biopython 
conda install -c bioconda bedops
#conda install -c bioconda samtools
#conda install -c bioconda picard/2.18
#conda install -c bioconda bcftools
conda install -c bioconda java-jdk 
conda deactivate

####   Download trimmomatic       #####

#wget http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-Src-0.36.zip
#unzip Trimmomatic-Src-0.36.zip
#rm Trimmomatic-Src-0.36.zip
#cd trimmomatic-0.36/ 

####   Download BWA       #####
cd $WORK/SANVA-softwares/
wget https://sourceforge.net/projects/bio-bwa/files/bwa-0.7.17.tar.bz2
tar -xvjf bwa-0.7.17.tar.bz2
rm bwa-0.7.17.tar.bz2
cd bwa-0.7.17/
conda deactivate

make
##### Download Samtools      #####
cd $WORK/SANVA-softwares/
wget https://sourceforge.net/projects/samtools/files/samtools/1.5/samtools-1.5.tar.bz2
tar -xvjf samtools-1.5.tar.bz2
rm samtools-1.5.tar.bz2
cd samtools-1.5 # Within the unpacked release directory
sh configure
conda deactivate

make
####    Picard              ####
#git clone https://github.com/broadinstitute/picard.git
#cd picard
#./gradlew shadowJar
cd $WORK/SANVA-softwares/
mkdir picard
cd picard/
wget https://github.com/broadinstitute/picard/releases/download/2.9.0/picard.jar
cd ../
####   Download freebayes    #####
cd $WORK/SANVA-softwares/
git clone --recursive git://github.com/ekg/freebayes.git
cd freebayes
conda deactivate

make
####       Download VCF       #####
cd $WORK/SANVA-softwares/freebayes/vcflib
make
#### Download BcftTools       ####
cd $WORK/SANVA-softwares/
wget  wget https://github.com/samtools/bcftools/releases/download/1.8/bcftools-1.8.tar.bz2
tar -xvjf bcftools-1.8.tar.bz2
rm bcftools-1.8.tar.bz2
cd bcftools-1.8
conda deactivate

make
####      Download snpEff      #####
cd $WORK/SANVA-softwares/
wget http://sourceforge.net/projects/snpeff/files/snpEff_latest_core.zip
unzip snpEff_latest_core.zip
rm snpEff_latest_core.zip

####          bedtools        ####
cd $WORK/SANVA-softwares/
wget https://github.com/arq5x/bedtools2/releases/download/v2.25.0/bedtools-2.25.0.tar.gz
tar -zxvf bedtools-2.25.0.tar.gz
cd bedtools2
conda deactivate

make
###########################
conda activate ~/miniconda3



