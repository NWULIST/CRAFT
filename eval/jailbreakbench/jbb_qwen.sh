#!/bin/bash
# Set credentials and paths in config.yaml at the repo root before running.
set -x

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
export PYTHONPATH="$PROJECT_ROOT:${PYTHONPATH:-}"
cd "$PROJECT_ROOT"

export HF_HOME="${HF_HOME:-$HOME/.cache/huggingface}/"
# Cluster setup (uncomment / adapt for your environment):
# module load cuda/12.4 cudnn/8.9.7-cuda-12 vllm/0.10.1
# export CUDA_HOME=/path/to/cuda

PYTHON_BIN="${CONDA_PREFIX:+${CONDA_PREFIX}/bin/python3}"
PYTHON_BIN="${PYTHON_BIN:-python3}"

echo "Using Python: $PYTHON_BIN"
$PYTHON_BIN --version

# Run JailbreakBench evaluation script
$PYTHON_BIN "$SCRIPT_DIR/jbb_qwen.py"
