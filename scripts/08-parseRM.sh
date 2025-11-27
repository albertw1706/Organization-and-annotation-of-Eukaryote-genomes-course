#!/bin/bash
#SBATCH --job-name=parseRM 
#SBATCH --partition=pibu_el8
#SBATCH --cpus-per-task=10
#SBATCH --mem=32G # e.g. 64G or 200G
#SBATCH --time=1-00:00:00 
#SBATCH --output=/data/users/awidjaja/annotation_course/logs/parseRM/parseRM_%j.out
#SBATCH --error=/data/users/awidjaja/annotation_course/logs/parseRM/parseRM_%j.err

# User-editable variables
WORKDIR="/data/users/awidjaja/annotation_course"
OUTDIR="$WORKDIR/results/parseRM"
PARSERM_SCRIPT="${WORKDIR}/scripts/parseRM.pl"

# RepeatMasker Output File
RM_FILE="${WORKDIR}/results/EDTA_res/ERR11437321_hifiasm.fa.mod.EDTA.anno/ERR11437321_hifiasm.fa.mod.out"

# Load BioPerl Module (required for parseRM.pl)
module load BioPerl/1.7.8-GCCcore-10.3.0

# Parse the RepeatMasker Output
perl "${PARSERM_SCRIPT}" -i "${RM_FILE}" -l "50,1" -v