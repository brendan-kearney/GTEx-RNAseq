#!/bin/bash
#SBATCH --job-name=sing
#SBATCH --mem-per-cpu=64G

# For running STAR RNAseq alignment

WORKDIR=#PATH_TO_CLONED_GTEX_PIPELINE
REFDIR=#PATH_TO_REFERENCE_DIR
GTExDIR=/data/reddylab/software/singularity/GTEx-RNAseq
sample_id="your_sample_identifier"

singularity exec --bind /data $GTExDIR/gtex_rnaseq_V10.sif \
   /bin/bash -c "$GTExDIR/src/run_rnaseqc.py \
     $REFDIR/gencode.v34.GRCh38.genes.collapsed_only.gtf \
     $WORKDIR/outdir/${sample_id}.Aligned.sortedByCoord.out.md.bam \
     ${sample_id} \
     --output_dir $WORKDIR/outdir"

# Workaround for gzip error at end of script
gzip $WORKDIR/outdir/${sample_id}.exon_reads.gct $WORKDIR/outdir/${sample_id}.gene_tpm.gct $WORKDIR/outdir/${sample_id}.gene_reads.gct
