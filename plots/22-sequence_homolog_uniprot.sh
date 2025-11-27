#!/usr/bin/env bash
#SBATCH --job-name=blastp_uniprot              # Job name
#SBATCH --output=/data/users/awidjaja/annotation_course/logs/blastp_uniprot/out_%j.out         # Standard output log
#SBATCH --error=/data/users/awidjaja/annotation_course/logs/blastp_uniprot/out_%j.err          # Standard error log
#SBATCH --cpus-per-task=10
#SBATCH --mem=10G                     # memory allocation
#SBATCH --time=4:00:00
#SBATCH --partition=pibu_el8

module load BLAST+/2.15.0-gompi-2021a

WORKDIR="/data/users/awidjaja/annotation_course/results"

mkdir -p /data/users/awidjaja/annotation_course/results/blastp_uniprot

cd /data/users/awidjaja/annotation_course/results/blastp_uniprot

blastp -query ${WORKDIR}/maker_renamed/maker_proteins.longest.fasta -db /data/courses/assembly-annotation-course/CDS_annotation/data/uniprot/uniprot_viridiplantae_reviewed.fa -num_threads 10 -outfmt 6 -evalue 1e-5 -max_target_seqs 10 -out blastp_uniprot

# Now sort the blast output to keep only the best hit per query sequence
sort -t $'\t' -k1,1 -k12,12nr -k11,11g blastp_uniprot | sort -t $'\t' -u -k1,1 --merge > blastp_uniprot_output.besthits