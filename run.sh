#!/bin/bash
# 新習志野 research パーティションで gpgpu 競技を実行するジョブ例
# 上限: GPU4 / CPU32 / MEM512G / 24h（ノード跨ぎ不可）

#SBATCH --job-name=gpgpu-run
#SBATCH --partition=research
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:4
#SBATCH --mem=512G
#SBATCH --time=24:00:00
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=s24c1102ug@s.chibakoudai.jp
#SBATCH --container=gpumng.cle.it-chiba.ac.jp/n24c1102/1xgpt:latest
#SBATCH --output=logs/gpgpu-%j.out
#SBATCH --error=logs/gpgpu-%j.err

set -eux
cd "${SLURM_SUBMIT_DIR}"

# 実行したいコマンドをここに記述（例として train.py を呼ぶ）
# 必要に応じて書き換えてください。
TRAIN_CMD="python train.py"

# 共有データを使う場合の例（読み取り専用）:
# DATA_DIR=/data/share_data/<dataset_dir>
# TRAIN_CMD="python train.py --data ${DATA_DIR}"

srun ${TRAIN_CMD}
srun nvidia-smi
