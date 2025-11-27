#!/usr/bin/env bash

#SBATCH --job-name=agat         # Job name
#SBATCH --output=/data/users/awidjaja/annotation_course/logs/stats_agat/out_%j.out    # Standard output log
#SBATCH --error=/data/users/awidjaja/annotation_course/logs/stats_agat/out_%j.err     # Standard error log
#SBATCH --cpus-per-task=2
#SBATCH --mem=10G                      # 10G memory allocation
#SBATCH --time=10:00:00
#SBATCH --partition=pibu_el8

# Define variables
WORKDIR="/data/users/awidjaja/annotation_course/results"
FINALDIR="${WORKDIR}/filtered_after_aed"
CONTAINER="/data/courses/assembly-annotation-course/CDS_annotation/containers/agat_1.5.1--pl5321hdfd78af_0.sif"

# Run AGAT
apptainer exec --bind "${WORKDIR}" "${CONTAINER}" agat_sp_statistics.pl\
    -i "${FINALDIR}/assembly_filtered.genes.renamed.gff3" -o "${FINALDIR}/annotation.stat"

apptainer exec --bind "${WORKDIR}" "${CONTAINER}" agat_sp_statistics.pl\
    -i /data/users/awidjaja/annotation_course/results/maker_renamed/assembly.all.maker.noseq.gff -o "${FINALDIR}/unfiltered_annotation.stat"
