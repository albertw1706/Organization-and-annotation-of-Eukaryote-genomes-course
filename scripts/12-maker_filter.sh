#!/usr/bin/env bash

#SBATCH --job-name=maker_filter       # Job name
#SBATCH --output=/data/users/awidjaja/annotation_course/logs/maker_filter/out_%j.out  # Standard output log
#SBATCH --error=/data/users/awidjaja/annotation_course/logs/maker_filter/out_%j.err   # Standard error log
#SBATCH --cpus-per-task=5
#SBATCH --mem=10G                     # 20G memory allocation
#SBATCH --time=01:00:00
#SBATCH --partition=pibu_el8

# Define variables
WORKDIR="/data/users/awidjaja/annotation_course/results"
FINALDIR="${WORKDIR}/filtered_after_aed"
COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"
MAKERBIN="${COURSEDIR}/softwares/Maker_v3.01.03/src/bin"

# Inputs
gff="/data/users/awidjaja/annotation_course/results/maker_renamed/assembly.all.maker.noseq.renamed.iprscan.gff"
transcript="/data/users/awidjaja/annotation_course/results/maker_renamed/assembly.all.maker.transcripts.fasta"
protein="/data/users/awidjaja/annotation_course/results/maker_renamed/assembly.all.maker.proteins.fasta"

mkdir -p "${FINALDIR}"
mkdir -p /data/users/awidjaja/annotation_course/logs/maker_filter
cd "${FINALDIR}"

# Filter the GFF by AED and/or Pfam (InterProScan) annotations
perl "${MAKERBIN}/quality_filter.pl" -s "${gff}" > assembly_iprscan_quality_filtered.gff

# Keep only gene-relevant features
grep -P "\tgene\t|\tCDS\t|\texon\t|\tfive_prime_UTR\t|\tthree_prime_UTR\t|\tmRNA\t" \
  assembly_iprscan_quality_filtered.gff > assembly_filtered.genes.renamed.gff3

cut -f3 assembly_filtered.genes.renamed.gff3 | sort | uniq

# Extract remaining mRNA IDs and filter transcript/protein FASTAs
module load UCSC-Utils/448-foss-2021a
module load MariaDB/10.6.4-GCC-10.3.0

grep -P "\tmRNA\t" assembly_filtered.genes.renamed.gff3 | awk '{print $9}' | cut -d ';' -f1 | sed 's/ID=//g' > list.txt 

faSomeRecords "${transcript}" list.txt "${FINALDIR}/assembly.transcripts.renamed.filtered.fasta"
faSomeRecords "${protein}"    list.txt "${FINALDIR}/assembly.proteins.renamed.filtered.fasta"