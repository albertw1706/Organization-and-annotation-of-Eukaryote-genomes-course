#!/usr/bin/env bash
#SBATCH --job-name=map_blastp_uniprot             # Job name
#SBATCH --output=/data/users/awidjaja/annotation_course/logs/map_blastp_uniprot/out_%j.out         # Standard output log
#SBATCH --error=/data/users/awidjaja/annotation_course/logs/map_blastp_uniprot/out_%j.err          # Standard error log
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G                     # memory allocation
#SBATCH --time=4:00:00
#SBATCH --partition=pibu_el8

COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"
MAKERBIN="$COURSEDIR/softwares/Maker_v3.01.03/src/bin"
WORKDIR="/data/users/awidjaja/annotation_course/results"

cd /data/users/awidjaja/annotation_course/results/blastp_uniprot

cp ${WORKDIR}/filtered_after_aed/assembly.proteins.renamed.filtered.fasta maker_proteins.filtered.fasta.Uniprot
cp ${WORKDIR}/filtered_after_aed/assembly_filtered.genes.renamed.gff3 filtered.genes.renamed.gff3.Uniprot.gff3

$MAKERBIN/maker_functional_fasta /data/courses/assembly-annotation-course/CDS_annotation/data/uniprot/uniprot_viridiplantae_reviewed.fa blastp_uniprot_output.besthits \
        ${WORKDIR}/filtered_after_aed/assembly.proteins.renamed.filtered.fasta > \
        maker_proteins.filtered.fasta.Uniprot

$MAKERBIN/maker_functional_gff /data/courses/assembly-annotation-course/CDS_annotation/data/uniprot/uniprot_viridiplantae_reviewed.fa blastp_uniprot_output.besthits \
        ${WORKDIR}/filtered_after_aed/assembly_filtered.genes.renamed.gff3 > \
        filtered.genes.renamed.gff3.Uniprot.gff3
