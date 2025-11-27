#!/usr/bin/env bash
#SBATCH --job-name=BUSCO              # Job name
#SBATCH --output=/data/users/awidjaja/annotation_course/logs/busco/out_%j.out         # Standard output log
#SBATCH --error=/data/users/awidjaja/annotation_course/logs/busco/out_%j.err          # Standard error log
#SBATCH --cpus-per-task=32
#SBATCH --mem=80G                     # 80G memory allocation
#SBATCH --time=24:00:00
#SBATCH --partition=pibu_el8

# Load BUSCO module
module load BUSCO/5.4.2-foss-2021a

# Define variables
WORKDIR="/data/users/awidjaja/annotation_course/results"
OUTPROT="${WORKDIR}/busco_proteins"
OUTTRANSCRIPT="${WORKDIR}/busco_transcripts"

cd /data/users/awidjaja/annotation_course/results/maker_renamed
mkdir -p "${OUTPROT}"
mkdir -p "${OUTTRANSCRIPT}"
mkdir -p /data/users/awidjaja/annotation_course/logs/busco

# Run BUSCO on proteins
busco -i "/data/users/awidjaja/annotation_course/results/maker_renamed/maker_proteins.longest.fasta" \
      -l brassicales_odb10 \
      -o busco_proteins \
      -m proteins \
      --cpu ${SLURM_CPUS_PER_TASK} \
      --out_path ${OUTPROT} \
      -f

# Run BUSCO on transcripts
busco -i "/data/users/awidjaja/annotation_course/results/maker_renamed/maker_transcripts.longest.fasta" \
      -l brassicales_odb10 \
      -o busco_transcripts \
      -m transcriptome \
      --cpu ${SLURM_CPUS_PER_TASK} \
      --out_path ${OUTTRANSCRIPT} \
      -f