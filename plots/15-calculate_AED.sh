#!/usr/bin/env bash

#SBATCH --job-name=calculate_AED      # Job name
#SBATCH --output=/data/users/awidjaja/annotation_course/logs/aed/out_%j.out  # Standard output log
#SBATCH --error=/data/users/awidjaja/annotation_course/logs/aed/out_%j.err   # Standard error log
#SBATCH --cpus-per-task=2             
#SBATCH --mem=2G                      # memory allocation
#SBATCH --time=01:00:00
#SBATCH --partition=pibu_el8

# Define variables
WORKDIR="/data/users/awidjaja/annotation_course/results"
COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"
MAKERBIN="${COURSEDIR}/softwares/Maker_v3.01.03/src/bin"
FINALDIR="${WORKDIR}/aed"
gff="${WORKDIR}/maker_renamed/assembly.all.maker.noseq.renamed.iprscan.gff"

mkdir -p /data/users/awidjaja/annotation_course/results/aed
mkdir -p /data/users/awidjaja/annotation_course/logs/aed

cd "${FINALDIR}"

perl "${MAKERBIN}/AED_cdf_generator.pl" -b 0.025 ${gff} > assembly.all.maker.renamed.gff.AED.txt 