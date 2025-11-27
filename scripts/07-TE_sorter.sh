#!/bin/bash
#SBATCH --job-name=te_sorter 
#SBATCH --partition=pibu_el8
#SBATCH --cpus-per-task=20
#SBATCH --mem=64G # e.g. 64G or 200G
#SBATCH --time=1-00:00:00 
#SBATCH --output=/data/users/awidjaja/annotation_course/logs/te_sorter/te_%j.out
#SBATCH --error=/data/users/awidjaja/annotation_course/logs/te_sorter/te_%j.err

# User-editable variables
WORKDIR="/data/users/awidjaja/annotation_course"
OUTDIR="$WORKDIR/results/TE_sorter"
CONTAINER="/data/courses/assembly-annotation-course/CDS_annotation/containers/TEsorter_1.3.0.sif"

INPUT_COPIA="${WORKDIR}/results/seqkit/Copia_seqkit.fa"
INPUT_GYPSY="${WORKDIR}/results/seqkit/Gypsy_seqkit.fa"

mkdir -p "${OUTDIR}"
cd "${OUTDIR}"

apptainer exec --bind "${WORKDIR}" "${CONTAINER}" TEsorter \
"${INPUT_COPIA}" -db rexdb-plant -p "${SLURM_CPUS_PER_TASK}"

apptainer exec --bind "${WORKDIR}" "${CONTAINER}" TEsorter \
"${INPUT_GYPSY}" -db rexdb-plant -p "${SLURM_CPUS_PER_TASK}"