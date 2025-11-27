#!/usr/bin/env bash

#SBATCH --job-name=rename_map          # Job name
#SBATCH --output=/data/users/awidjaja/annotation_course/logs/output_prep_maker/out_%j.out
#SBATCH --error=/data/users/awidjaja/annotation_course/logs/output_prep_maker/out_%j.err     # Standard error log
#SBATCH --cpus-per-task=5             
#SBATCH --mem=10G                      # 10G memory allocation
#SBATCH --time=01:00:00
#SBATCH --partition=pibu_el8

# Define variables
WORKDIR="/data/users/awidjaja/annotation_course/results/"
COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"
MAKERBIN="${COURSEDIR}/softwares/Maker_v3.01.03/src/bin"

# Filenames
protein="assembly.all.maker.proteins.fasta"
transcript="assembly.all.maker.transcripts.fasta"
gff="assembly.all.maker.noseq.gff"

cd /data/users/awidjaja/annotation_course/results/maker_prep_res

mkdir -p /data/users/awidjaja/annotation_course/results/maker_renamed

# Accession as prefix
prefix="Nov-02"

# Build ID map from the GFF
"${MAKERBIN}/maker_map_ids" --prefix "${prefix}" --justify 7 $gff > id.map 

cp id.map /data/users/awidjaja/annotation_course/results/maker_renamed

# Apply the map to GFF and FASTAs
"${MAKERBIN}/map_gff_ids"   id.map $gff
"${MAKERBIN}/map_fasta_ids" id.map $protein
"${MAKERBIN}/map_fasta_ids" id.map $transcript

cp $gff /data/users/awidjaja/annotation_course/results/maker_renamed
cp $protein /data/users/awidjaja/annotation_course/results/maker_renamed
cp $transcript /data/users/awidjaja/annotation_course/results/maker_renamed



