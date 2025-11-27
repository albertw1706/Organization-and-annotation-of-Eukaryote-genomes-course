#!/usr/bin/env bash

#SBATCH --job-name=genespace          # Job name
#SBATCH --output=/data/users/awidjaja/annotation_course/logs/genespace/_%j.out     # Standard output log
#SBATCH --error=/data/users/awidjaja/annotation_course/logs/genespace/_%j.err      # Standard error log
#SBATCH --cpus-per-task=20
#SBATCH --mem=80G                     # memory allocation
#SBATCH --time=24:00:00
#SBATCH --partition=pibu_el8

# Define variables
WORKDIR="/data/users/awidjaja/annotation_course"
COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"

chmod u+x ${WORKDIR}/scripts/20_genespace.R

apptainer exec --bind /data \
  ${COURSEDIR}/containers/genespace_latest.sif Rscript ${WORKDIR}/scripts/20_genespace.R ${WORKDIR}/results/genespace