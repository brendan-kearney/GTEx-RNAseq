#!/bin/bash
#SBATCH --job-name=sing
#SBATCH --mem-per-cpu=64G

# Optional for creating new references. A custom GTF is required (see https://github.com/broadinstitute/gtex-pipeline/tree/master/rnaseq#reference-genome-and-annotation).
# STAR and RSEM references require FASTA and GTF. hg38 was used for testing

WORKDIR=#PATH_TO_CLONED_GTEX_PIPELINE
REFDIR=#PATH_TO_REFERENCE_DIR
GTExDIR=/data/reddylab/software/singularity/GTEx-RNAseq

# For GTF annotation step (only need install once)
#pip install pandas
#pip install bx-python
# Prep GTF annotation
python3 $GTExDIR/src/collapse_annotation.py \ 
   --collapse_only #REFDIR/gencode.v34.annotation.gtf \
   REFDIR/gencode.v34.GRCh38.genes.collapsed_only.gtf

# STAR and RSEM reference prep
# genomeDir is the output
singularity exec --bind /data/ $GTExDIR/gtex_rnaseq_V10.sif \
   /bin/bash -c "STAR \
      --runMode genomeGenerate \
      --genomeDir $REFDIR/star_index_oh75 \
      --genomeFastaFiles $REFDIR/fasta/IGVFFI0653VCGH.fasta \
      --sjdbGTFfile $REFDIR/Gencode/v43/IGVFFI7217ZMJZ.gtf \
      --sjdbOverhang 75 \
      --runThreadN 4"

singularity exec --bind /data/ $GTExDIR/gtex_rnaseq_V10.sif \
   /bin/bash -c "rsem-prepare-reference \
      $REFDIR/fasta/IGVFFI0653VCGH.fasta \
      $REFDIR/rsem_reference/rsem_reference \
      --gtf $REFDIR/Gencode/v43/IGVFFI7217ZMJZ.gtf \
      --num-threads 4"
