#!/bin/bash
#SBATCH --job-name=create_control_file
#SBATCH --partition=pibu_el8
#SBATCH --cpus-per-task=20 
#SBATCH --mem=64G # e.g. 64G or 200G
#SBATCH --time=1-00:00:00 
#SBATCH --output=/data/users/awidjaja/annotation_course/logs/maker/control_%j.out
#SBATCH --error=/data/users/awidjaja/annotation_course/logs/maker/control_%j.err

WORKDIR=/data/users/awidjaja/annotation_course/annotation
mkdir -p $WORKDIR
cd $WORKDIR

apptainer exec --bind $WORKDIR \
/data/courses/assembly-annotation-course/CDS_annotation/containers/MAKER_3.01.03.sif maker -CTL