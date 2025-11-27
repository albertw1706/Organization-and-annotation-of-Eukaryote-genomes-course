#!/bin/bash
#SBATCH --job-name=TE_annotation_edta 
#SBATCH --partition=pibu_el8
#SBATCH --cpus-per-task=20 
#SBATCH --mem=64G # e.g. 64G or 200G
#SBATCH --time=1-00:00:00 
#SBATCH --output=/data/users/awidjaja/annotation_course/logs/edta/edta_%j.out
#SBATCH --error=/data/users/awidjaja/annotation_course/logs/edta/edta_%j.err


# User-editable variables
WORKDIR="/data/users/awidjaja/annotation_course"
CONTAINER="/data/courses/assembly-annotation-course/CDS_annotation/containers/EDTA2.2.sif" # e.g. /data/.../EDTA2.2.sif
INPUT_FASTA="$WORKDIR/assemblies/ERR11437321_hifiasm.fa"
OUTDIR="$WORKDIR/results/EDTA_res"
CDS_PATH="/data/courses/assembly-annotation-course/CDS_annotation/data/TAIR10_cds_20110103_representative_gene_model_updated"
cd "$OUTDIR"

TOOL_CMD=$(cat <<EOF
EDTA.pl \
  --genome "$INPUT_FASTA" \
  --species others \
  --step all \
  --sensitive 1 \
  --cds "$CDS_PATH" \
  --anno 1 \
  --threads 20
EOF
)

# Full run: runs TOOL_CMD inside the container using allocated CPUs
apptainer exec --bind "$WORKDIR" \
--bind "/data" \
"$CONTAINER" \
bash -lc "$TOOL_CMD"