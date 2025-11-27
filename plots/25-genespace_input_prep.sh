#!/usr/bin/env bash
#SBATCH --job-name=genespace      # Job name
#SBATCH --output=/data/users/awidjaja/annotation_course/logs/genespace_input/out_%j.out # Standard output log
#SBATCH --error=/data/users/awidjaja/annotation_course/logs/genespace_input/out_%j.err  # Standard error log
#SBATCH --cpus-per-task=2
#SBATCH --mem=4G                        # 4G memory allocation
#SBATCH --time=01:00:00
#SBATCH --partition=pibu_el8

# Define variables
WORKDIR="/data/users/awidjaja/annotation_course/results"
FINALDIR="${WORKDIR}/maker_renamed"
OUTDIRBED="${WORKDIR}/genespace/bed"
OUTDIRPEPTIDE="${WORKDIR}/genespace/peptide"

# Longest Protein File Path
LONGPROT="${FINALDIR}/maker_proteins.longest.fasta"

mkdir -p "${OUTDIRBED}"
mkdir -p "${OUTDIRPEPTIDE}"

# Accession Names
NOV="Nov_02"
ALTAI="Altai_5"
ICE="Ice_1"
KAR="Kar_1"

GENEGFFS="/data/courses/assembly-annotation-course/CDS_annotation/data/Lian_et_al/gene_gff/selected"
PROTFASTA="/data/courses/assembly-annotation-course/CDS_annotation/data/Lian_et_al/protein/selected"

# Prepare BED Files
cd "${OUTDIRBED}"

# Nov-02 GFF3
grep -P "\tgene\t" "${FINALDIR}/assembly_filtered.genes.renamed.gff3" > temp_genes.gff3

awk 'BEGIN{OFS="\t"}{
  split($9,a,";"); split(a[1],b,"=");
  print $1, $4-1, $5, b[2]
}' temp_genes.gff3 > "${NOV}.bed"

# Altai-5 GFF3
grep -P "\tgene\t" "${GENEGFFS}/Altai-5.EVM.v3.5.ann.protein_coding_genes.gff" > temp_genes.gff3

awk 'BEGIN{OFS="\t"}{
  split($9,a,";"); split(a[1],b,"=");
  print $1, $4-1, $5, b[2]
}' temp_genes.gff3 > "${ALTAI}.bed"

# Ice-1 GFF3
grep -P "\tgene\t" "${GENEGFFS}/Ice-1.EVM.v3.5.ann.protein_coding_genes.gff" > temp_genes.gff3

awk 'BEGIN{OFS="\t"}{
  split($9,a,";"); split(a[1],b,"=");
  print $1, $4-1, $5, b[2]
}' temp_genes.gff3 > "${ICE}.bed"

# Kar-1 GFF3
grep -P "\tgene\t" "${GENEGFFS}/Kar-1.EVM.v3.5.ann.protein_coding_genes.gff" > temp_genes.gff3

awk 'BEGIN{OFS="\t"}{
  split($9,a,";"); split(a[1],b,"=");
  print $1, $4-1, $5, b[2]
}' temp_genes.gff3 > "${KAR}.bed"


# Prepare Peptide Files
cd "${OUTDIRPEPTIDE}"

# rewrite headers from isoform -> gene (strip -R*)
awk 'BEGIN{FS="[ \t]"; OFS=""}
  /^>/{
    id=$1; sub(/^>/,"",id);           # first token of header
    gene=id; sub(/-R.*/,"",gene);     # drop isoform suffix (e.g., -RA/-RB/…)
    print ">", gene; next
  }
  { print }
' "${FINALDIR}/maker_proteins.longest.fasta" > ${NOV}.fa
cp "${PROTFASTA}/Altai-5.protein.faa" "${ALTAI}.fa"
cp "${PROTFASTA}/Ice-1.protein.faa" "${ICE}.fa"
cp "${PROTFASTA}/Kar-1.protein.faa" "${KAR}.fa"

# TAIR10 files
TAIRFILES="/data/courses/assembly-annotation-course/CDS_annotation/data"

# Copy TAIR10 files
cp "${TAIRFILES}/TAIR10.bed" "${OUTDIRBED}"
cp "${TAIRFILES}/TAIR10.fa" "${OUTDIRPEPTIDE}"