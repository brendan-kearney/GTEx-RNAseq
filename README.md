# GTEx-RNAseq
Running GTEx RNAseq Docker pipeline in a cluster environment with Singularity
Made from: https://github.com/broadinstitute/gtex-pipeline/tree/master/rnaseq

# Requirements:

Access to gtex_rnaseq_V10.sif Singularity image

Python scripts from GTEx (/src folder)

Reference files (/references) - can be custom created in create_references.sh

Working installation of Singularity

Pipeline was tested with hg38 reference genome

# To run this pipeline:

Clone the Github repo

Edit .sh files. Most will require adding a few paths (reference dir, run dir), and a {sample_id}. 

## General order of pipeline is

  prepare_references.sh (optional)
  
  run_STAR.sh
  
  run_MarkDuplicates.sh
  
  run_rnaseqc.sh
  
  run_RSEM.sh

