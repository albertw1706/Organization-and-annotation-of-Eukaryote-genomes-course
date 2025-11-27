#!/bin/bash
#SBATCH --job-name=samtool_faidx 
#SBATCH --partition=pibu_el8
#SBATCH --cpus-per-task=5 
#SBATCH --mem=32G # e.g. 64G or 200G
#SBATCH --time=1-00:00:00 
#SBATCH --output=/data/users/awidjaja/annotation_course/logs/samtools/samtools_faidx_%j.out
#SBATCH --error=/data/users/awidjaja/annotation_course/logs/samtools/samtools_faidx_%j.err


# User-editable variables
WORKDIR="/data/users/awidjaja/annotation_course"
CONTAINER="/containers/apptainer/samtools-1.19.sif" # e.g. /data/.../EDTA2.2.sif
INPUT_FASTA="$WORKDIR/assemblies/ERR11437321_hifiasm.fa"
OUTDIR="$WORKDIR/results/samtools"

# Create the output directory if it doesn't already exist:
mkdir -p "${OUTDIR}"
cd "${OUTDIR}"

# Run samtools faidx on the assembly FASTA (index is created next to the FASTA)
apptainer exec --bind "${WORKDIR}" "${CONTAINER}" samtools \
faidx "${INPUT_FASTA}"

# Copy index from the FASTA directory to the output directory
cp -f "${INPUT_FASTA}.fai" "${OUTDIR}"