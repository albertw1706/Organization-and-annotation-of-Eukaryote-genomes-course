#!/usr/bin/env bash
#SBATCH --job-name=longest_proteins
#SBATCH --output=/data/users/awidjaja/annotation_course/logs/longest_protein/out_%j.out
#SBATCH --error=/data/users/awidjaja/annotation_course/logs/longest_protein/out_%j.err
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=00:30:00
#SBATCH --partition=pibu_el8

module load SAMtools/1.13-GCC-10.3.0
module load UCSC-Utils/448-foss-2021a
module load MariaDB/10.6.4-GCC-10.3.0

INPUTDIR="/data/users/awidjaja/annotation_course/results/filtered_after_aed"

PROT="${INPUTDIR}/assembly.proteins.renamed.filtered.fasta"

cd "${INPUTDIR}"

# Index and pick longest isoform per gene
samtools faidx "${PROT}"
cut -f1,2 "${PROT}.fai" \
| awk 'BEGIN{FS=OFS="\t"}{id=$1; len=$2; split(id,a,"-R"); gene=a[1]; print gene,len,id}' \
| sort -t $'\t' -k1,1 -k2,2nr \
| awk -F'\t' '!seen[$1]++ {print $3}' \
> protein_longest_ids.txt

# Extract those records
faSomeRecords "${PROT}" protein_longest_ids.txt maker_proteins.longest.fasta