#!/bin/bash
#SBATCH --job-name=maker_output_prep
#SBATCH --partition=pibu_el8
#SBATCH --cpus-per-task=5
#SBATCH --mem=16G # e.g. 64G or 200G
#SBATCH --time=1-00:00:00 
#SBATCH --output=/data/users/awidjaja/annotation_course/logs/output_prep_maker/out_%j.out
#SBATCH --error=/data/users/awidjaja/annotation_course/logs/output_prep_maker/out_%j.err

mkdir -p /data/users/awidjaja/annotation_course/logs/output_prep_maker
mkdir -p /data/users/awidjaja/annotation_course/results/maker_prep_res

cd /data/users/awidjaja/annotation_course/results/maker_prep_res

COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"
MAKERBIN="$COURSEDIR/softwares/Maker_v3.01.03/src/bin"
$MAKERBIN/gff3_merge -s -d /data/users/awidjaja/annotation_course/annotation/ERR11437321_hifiasm.maker.output/ERR11437321_hifiasm_master_datastore_index.log > assembly.all.maker.gff
$MAKERBIN/gff3_merge -n -s -d /data/users/awidjaja/annotation_course/annotation/ERR11437321_hifiasm.maker.output/ERR11437321_hifiasm_master_datastore_index.log > assembly.all.maker.noseq.gff
$MAKERBIN/fasta_merge -d /data/users/awidjaja/annotation_course/annotation/ERR11437321_hifiasm.maker.output/ERR11437321_hifiasm_master_datastore_index.log -o assembly