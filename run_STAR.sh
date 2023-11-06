#!/bin/bash
#SBATCH --job-name=sing
#SBATCH --mem-per-cpu=64G

# For running STAR RNAseq alignment

WORKDIR=#PATH_TO_CLONED_GTEX_PIPELINE
REFDIR=#PATH_TO_REFERENCE_DIR
GTExDIR=/data/reddylab/software/singularity/GTEx-RNAseq
sample_id="your_sample_identifier"

singularity exec --bind /data $GTExDIR/gtex_rnaseq_V10.sif \
   /bin/bash -c "$GTExDIR/src/run_STAR.py \
      $REFDIR/star_index_oh75 \
      $REFDIR/${sample_id}_1.fastq.gz \
      $REFDIR/${sample_id}_1.fastq.gz \
      ${sample_id} \
      --threads 4 \
      --output_dir $WORKDIR/outdir"
