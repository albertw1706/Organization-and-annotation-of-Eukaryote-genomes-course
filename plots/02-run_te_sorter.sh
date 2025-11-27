#!/bin/bash
#SBATCH --job-name=TE_sorter
#SBATCH --partition=pibu_el8
#SBATCH --cpus-per-task=20 
#SBATCH --mem=64G # e.g. 64G or 200G
#SBATCH --time=1-00:00:00 
#SBATCH --output=/data/users/awidjaja/annotation_course/logs/te_sorter/te_sorter_%j.out
#SBATCH --error=/data/users/awidjaja/annotation_course/logs/te_sorter/te_sorter_%j.err


# User-editable variables
WORKDIR="/data/users/awidjaja/annotation_course"
CONTAINER="/data/courses/assembly-annotation-course/CDS_annotation/containers/TEsorter_1.3.0.sif" # e.g. /data/.../EDTA2.2.sif
INPUT="$WORKDIR/results/EDTA_res/ERR11437321_hifiasm.fa.mod.EDTA.raw/ERR11437321_hifiasm.fa.mod.LTR.raw.fa"
OUTDIR="$WORKDIR/results/te_sorter_res"
mkdir "$OUTDIR"
cd "$OUTDIR"

TOOL_CMD=$(cat <<EOF
TEsorter \
$INPUT \
-db rexdb-plant
EOF
)

# Full run: runs TOOL_CMD inside the container using allocated CPUs
apptainer exec --bind "$WORKDIR" \
--bind "/data" \
"$CONTAINER" \
bash -lc "$TOOL_CMD"