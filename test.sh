#!/usr/bin/env bash
clear
ROOT_DIR=$PWD
echo "Set root dir to: ""$ROOT_DIR"
TIME_TAG=`date "+%Y%m%d-%H%M%S"` # Time stamp
func_nmt_eval()
{
    SOURCE_DIR=$PWD
    eval cd "${SOURCE_DIR}"
    export PYTHONPATH="$PYTHONPATH:$SOURCE_DIR"
    echo "Start from source dir: "$SOURCE_DIR
    MODEL_NAME=save/demo-model-0303/demo-model-0303-full_acc_54.98_ppl_8.91_e19.pt
    SRC_FILE=0303.zh
    TGT_FILE=en_mscoco.txt
    echo "Model:"$MODEL_NAME "Src:"$SRC_FILE "Tgt:"$TGT_FILE
    python translate.py -model $MODEL_NAME -src $SRC_FILE -output $TGT_FILE -verbose -gpu 0 | tee tmp/log_test_$TIME_TAG.txt
}

func_nmt_eval
