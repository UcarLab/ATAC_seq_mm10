#!/bin/bash
#
#  Make IGV and Genome Browser files for visualization
#  
#  STEP 9
#
#  Purpose: Organize files/folders
#
#  Author:
#            Duygu Ucar, PhD
#
#  Date:     2017 December 15
#
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
#            8.  bedgraph files are generated
#-------------------------------------------------------------------------------------
scriptDIR=$(pwd)
workingDIR=$scriptDIR/working
bamDIR=$workingDIR/trimmomatic/adapterTrimmed/bwa
gbDIR=$workingDIR/trimmomatic/adapterTrimmed/bwa/BedGraph
bampeDIR=$workingDIR/trimmomatic/adapterTrimmed/bwa/Bampe_peaks
broadDIR=$workingDIR/trimmomatic/adapterTrimmed/bwa/Broad_peaks

#mkdir $scriptDIR/ATAC_output
#mkdir $scriptDIR/ATAC_output/bamfiles
mkdir $scriptDIR/ATAC_output/bedfiles
mkdir $scriptDIR/ATAC_output/bedGraph
mkdir $scriptDIR/ATAC_output/IGV
mkdir $scriptDIR/ATAC_output/peaks
mkdir $scriptDIR/ATAC_output/peaks/bampe
mkdir $scriptDIR/ATAC_output/peaks/broad
mkdir $scriptDIR/ATAC_output/metrics
mkdir $scriptDIR/ATAC_output/insertSize

mv $bamDIR/*bam $scriptDIR/ATAC_output/bamfiles
mv $bamDIR/*bai $scriptDIR/ATAC_output/bamfiles
mv $bamDIR/*bed $scriptDIR/ATAC_output/bedfiles
mv $bamDIR/*insertSize* $scriptDIR/ATAC_output/insertSize
mv $bamDIR/*metrics.txt $scriptDIR/ATAC_output/metrics
mv $gbDIR/*bedGraph $scriptDIR/ATAC_output/bedGraph
mv $bampeDIR/* $scriptDIR/ATAC_output/peaks/bampe
mv $broadDIR/* $scriptDIR/ATAC_output/peaks/broad

