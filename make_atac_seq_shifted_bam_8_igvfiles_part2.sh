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

scriptDIR=$(pwd)
workingDIR=$scriptDIR/working
igvDIR=$workingDIR/trimmomatic/adapterTrimmed/bwa/IGV
gbDIR=$workingDIR/trimmomatic/adapterTrimmed/bwa/BedGraph

# Clean files from previous runs
rm -r $igvDIR
mkdir $igvDIR

#rm $workingDIR/bedfilelist.txt
rm $workingDIR/bedgraphfilelist.txt

#ls -1 $inputDIR/*bed > $workingDIR/bedfilelist.txt
ls -1 $gbDIR/*.bedGraph > $workingDIR/bedgraphfilelist.txt
FILENUMBER=$(wc -l $workingDIR/bedgraphfilelist.txt | cut -d' ' -f1)

echo \#!/bin/bash > $workingDIR/IGV.qsub
echo \#PBS -l nodes=1:ppn=16 >> $workingDIR/IGV.qsub
echo \#PBS -l walltime=12:00:00 >> $workingDIR/IGV.qsub
echo \#PBS -N igv  >> $workingDIR/IGV.qsub
echo \#PBS -t 1-$FILENUMBER >> $workingDIR/IGV.qsub
echo module load python/2.7.3 >> $workingDIR/IGV.qsub
echo module load bedtools/2.17.0 >> $workingDIR/IGV.qsub
echo module load samtools/0.1.19 >> $workingDIR/IGV.qsub

# Change file names
echo FILE=\$\(head -n \$PBS_ARRAYID $workingDIR/bedgraphfilelist.txt \| tail -1\) >> $workingDIR/IGV.qsub
echo FILENAME=\$\(basename \"\${FILE}\" \| sed \'s/bedGraph/tdf/g\'\)  >> $workingDIR/IGV.qsub
# run programs
#echo /home/ducar/Software/HOMER/bin/makeTagDirectory $gbDIR/\$BASENAME \$FILE -genome mm10 -single -fragLength 150 >> $workingDIR/MACS.qsub
#echo /home/ducar/Software/HOMER/bin/makeUCSCfile $gbDIR/\$BASENAME -fragLength 150 -o $gbDIR/\$FILENAME >> $workingDIR/MACS.qsub
#echo /home/ducar/Software/HOMER/bin/makeUCSCfile $gbDIR/\$BASENAME -fragLength 150 -o $gbDIR/\$FILENAME >> $workingDIR/MACS.qsub
#echo gunzip $gbDIR/*.gz >> $workingDIR/MACS.qsub 
echo echo $gbDIR/\$FILE >> $workingDIR/IGV.qsub
echo echo $FILENAME >> $workingDIR/IGV.qsub
echo /home/ducar/Software/IGVTools/igvtools toTDF $gbDIR/\$FILE $igvDIR/\$FILENAME mm10 >> $workingDIR/IGV.qsub

qsub -V $workingDIR/IGV.qsub
echo "use qstat -u <username> to check the status of your job" 
echo "done with STEP 8 when qsub is complete"

