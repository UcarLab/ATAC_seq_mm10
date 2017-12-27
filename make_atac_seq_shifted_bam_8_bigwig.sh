#!/bin/bash
#
#  Make IGV and Genome Browser files for visualization
#  
#  STEP 8 
#
#  Name   :  make_atac_seq_shifted_bam_8_igvfiles.sh
#
#  Purpose: This routine generates tdf files for IGV and bedgraph files for UCSC GB
#
#  Author:
#            Duygu Ucar, PhD
#
#  Date:     2017 December 15
#
#  Call:     make_atac_seq_shifted_bam_8_igvfiles.sh
#
#  Assumptions:  
#
#            1.  code has been checked out - fastqc has been run - working directory created
#            2.  we are in the same directory as the scripts.
#            3.  trimmomatic has been run
#            4.  bwa has been run
#            5.  shifted_bam has been called to make the sam file correct for ATAC_seq
#            6.  bam files are converted to bed files           
#            7.  peak calling is completed
#
#-------------------------------------------------------------------------------------
#!/bin/bashmake_atac_seq_shifted_bam_8_igvfiles.sh
dataDIR=$1 #ARGV, contains folder with FASTQ files, right now needs trailing /
workingDIR=$(pwd)

# Clean files from previous runs
rm -r $bwDIR
mkdir $bwDIR

#rm $workingDIR/bedfilelist.txt
rm $workingDIR/bedgraphfilelist.txt

#ls -1 $inputDIR/*bed > $workingDIR/bedfilelist.txt
ls -1 $dataDIR/*.bedGraph > $workingDIR/bedgraphfilelist.txt
FILENUMBER=$(wc -l $workingDIR/bedgraphfilelist.txt | cut -d' ' -f1)

echo \#!/bin/bash > $workingDIR/IGV.qsub
echo \#PBS -l nodes=1:ppn=16 >> $workingDIR/IGV.qsub
echo \#PBS -l walltime=2:00:00 >> $workingDIR/IGV.qsub
echo \#PBS -N igv  >> $workingDIR/IGV.qsub
echo \#PBS -t 1-$FILENUMBER >> $workingDIR/IGV.qsub
echo module load python/2.7.3 >> $workingDIR/IGV.qsub
echo module load bedtools/2.17.0 >> $workingDIR/IGV.qsub
echo module load samtools/0.1.19 >> $workingDIR/IGV.qsub
echo module load kent >> $workingDIR/IGV.qsub

#bedGraphToBigWig in.bedGraph chrom.sizes out.bw

# Change file names
echo FILE=\$\(head -n \$PBS_ARRAYID $workingDIR/bedgraphfilelist.txt \| tail -1\) >> $workingDIR/IGV.qsub
echo FILENAME=\$\(basename \"\${FILE}\" \| sed \'s/bedGraph/bw/g\'\)  >> $workingDIR/IGV.qsub

# run programs
echo bedGraphToBigWig \$FILE /home/ducar/Genomes/mm10.chrom.sizes $dataDIR/\$FILENAME >> $workingDIR/IGV.qsub

qsub -V $workingDIR/IGV.qsub
echo "use qstat -u <username> to check the status of your job" 
echo "done with STEP 8 when qsub is complete"

