#!/bin/bash                                          
#$ -S /bin/bash
#$ -cwd                                                                                                                                                                           

module load bwa
module load samtools
module load bedtools

fq_r1=$1
bam=$1.bam
sam=$1.sam
sortbam=$1.sorted

echo "fq_r1=${fq_r1}"
echo "sortbam=$sortbam"

bwa mem -t 1 /ifs/data/proteomics/projects/Sunny/genome/L1HS.fa /ifs/data/proteomics/projects/Sunny/allfastq/hg38_shorter_than_50/${fq_r1} > ${sam}
samtools view -b -S ${sam} > ${bam}
samtools sort ${bam} ${sortbam}
samtools index ${sortbam}.bam
bedtools genomecov -ibam ${sortbam}.bam -bg > $1-coverage.bedgraph