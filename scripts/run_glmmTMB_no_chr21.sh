#!/bin/bash
#SBATCH --job-name=glmmTMB_no_chr21
#SBATCH --partition=ncpu
#SBATCH --cpus-per-task=80
#SBATCH --mem=700G
#SBATCH --time=24:00:00
#SBATCH --output=logs/glmmTMB_no_chr21_%j.log
#SBATCH --error=logs/glmmTMB_no_chr21_%j.log

set -euo pipefail
cd "${SLURM_SUBMIT_DIR}"
mkdir -p logs

export OPENBLAS_NUM_THREADS=1
export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1

echo "host: $(hostname)"
echo "cpus: ${SLURM_CPUS_PER_TASK}"
echo "mem:  ${SLURM_MEM_PER_NODE} MB"
echo "BLAS threads (env): OPENBLAS=${OPENBLAS_NUM_THREADS} OMP=${OMP_NUM_THREADS} MKL=${MKL_NUM_THREADS}"
echo "start: $(date -Is)"

Rscript -e "src <- tempfile(fileext='.R'); knitr::purl('scripts/glmmTMB_no_chr21.qmd', output=src, quiet=TRUE); source(src, echo=TRUE)"

echo "end: $(date -Is)"
