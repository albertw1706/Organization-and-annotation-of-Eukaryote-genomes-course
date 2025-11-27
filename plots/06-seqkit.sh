#!/bin/bash
#SBATCH --job-name=seqkit 
#SBATCH --partition=pibu_el8
#SBATCH --cpus-per-task=10
#SBATCH --mem=32G # e.g. 64G or 200G
#SBATCH --time=1-00:00:00 
#SBATCH --output=/data/users/awidjaja/annotation_course/logs/seqkit/seqkit_%j.out
#SBATCH --error=/data/users/awidjaja/annotation_course/logs/seqkit/seqkit_%j.err

# User-editable variables
WORKDIR="/data/users/awidjaja/annotation_course"
OUTDIR="$WORKDIR/results/seqkit"
TELIB="${WORKDIR}/results/EDTA_res/ERR11437321_hifiasm.fa.mod.EDTA.TElib.fa"

# Load SeqKit module
module load SeqKit/2.6.1

# Create the output directory if it doesn't already exist:
mkdir -p "${OUTDIR}"
cd "${OUTDIR}"

# Extract Copia sequences
seqkit grep -r -p "Copia" "${TELIB}" > "${OUTDIR}/Copia_seqkit.fa"
seqkit grep -r -p "Gypsy" "${TELIB}" > "${OUTDIR}/Gypsy_seqkit.fa"