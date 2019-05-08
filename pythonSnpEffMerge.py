import csv
import sys

if len(sys.argv) < 4:
    sys.stderr.write('No Input CSV file and BCFTools and java\n')
    sys.exit(0)
    
inputFile = sys.argv[1]
BCFTools = sys.argv[2]
minicondaBin = sys.argv[3]
cpath = sys.argv[4]
outputFile = "snpEffMerge.sh"

with open(outputFile,'w') as outFile:
        outFile.write(f'{BCFTools}bcftools merge --force $WORK/SAEVA-outputs/bcfoutput/*.gz -p $WORK/SAEVA-outputs/merge -n=100;\n')
        outFile.write('sed -i 's/^chr/Chromosome/' $WORK/SAEVA-outputs/merge.vcf;)
        outFile.write(f'{minicondaBin}java -Xmx4g -jar $WORK/SAEVA-softwares/snpEff/snpEff.jar -v Staphylococcus_aureus_subsp_aureus_nctc_8325 $WORK/SAEVA-outputs/merg.vcf > $WORK/SAEVA-outputs/snpEff.ann.vcf \n')
        outFile.write('mv $WORK/ACMBCB/snpEff_genes.txt $WORK/SAEVA-outputs/snpEff.txt \n')
        outFile.write('mv $WORK/ACMBCB/snpEff_summary.html $WORK/SAEVA-outputs/snpEff_summary.html \n')
