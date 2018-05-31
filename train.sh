#!/usr/bin/env bash
MODEL_TYPE=''
ROOT_DIR=$PWD
echo "run "$MODEL_TYPE
GPU_ID=$1 # Get gpu id
CKPT_PATH=$2 # Get save path
echo "GPU using "$GPU_ID
TIME_TAG=`date "+%Y%m%d-%H%M%S"` # Time stamp
CUDA_VISIBLE_DEVICES=$GPU_ID python train.py | tee tmp/log_train_$TIME_TAG.txt