#!/bin/bash
#PBS -l nodes=1:ppn=2
#PBS -l walltime=24:00:00
#PBS -N trimmomatic
module load python
mkdir /sdata/dbGaP/13995/ATAC-seq/working/test
FILE=SRR5198816_1.fastq
FILE2=SRR5198816_2.fastq
FILE1paired=$(basename "${FILE}" | sed 's/_1.fastq/_1.trim.fastq.gz/g')
FILE2paired=$(basename "${FILE2}" | sed 's/_2.fastq/_2.trim.fastq.gz/g')
FILE1unpaired=$(basename "${FILE}" | sed 's/_1.fastq/_1.trimU.fastq.gz/g')
FILE2unpaired=$(basename "${FILE2}" | sed 's/_2.fastq/_2.trimU.fastq.gz/g')
java -jar /opt/compsci/Trimmomatic/0.33/trimmomatic-0.33.jar PE -threads 2 /sdata/dbGaP/13995/FASTQ/$FILE /sdata/dbGaP/13995/FASTQ/$FILE2 /sdata/dbGaP/13995/ATAC-seq/working/test/$FILE1paired /sdata/dbGaP/13995/ATAC-seq/working/test/$FILE1unpaired /sdata/dbGaP/13995/ATAC-seq/working/test/$FILE2paired /sdata/dbGaP/13995/ATAC-seq/working/test/$FILE2unpaired TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
python /sdata/dbGaP/13995/ATAC-seq/auyar/pyadapter_trim_DU.py -a /sdata/dbGaP/13995/ATAC-seq/working/test/$FILE1paired -b /sdata/dbGaP/13995/ATAC-seq/working/test/$FILE2paired -f /sdata/dbGaP/13995/ATAC-seq/working/test/


