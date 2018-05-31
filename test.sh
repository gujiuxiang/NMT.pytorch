#!/usr/bin/env bash
clear
ROOT_DIR=$PWD
echo "Set root dir to: ""$ROOT_DIR"
TIME_TAG=`date "+%Y%m%d-%H%M%S"` # Time stamp
func_nmt_eval_ft()
{
    SOURCE_DIR=$PWD
    eval cd "${SOURCE_DIR}"
    export PYTHONPATH="$PYTHONPATH:$SOURCE_DIR"
    echo "Start from source dir: "$SOURCE_DIR
    MODEL_NAME=$SOURCE_DIR/save/demo-model-ft/model_acc_54.82_ppl_8.93_e13.pt
    SRC_FILE=$SOURCE_DIR/data/aic_mt/nmt_t2t_data_all/valid_0303.zh
    TGT_FILE=$SOURCE_DIR/tmp/aic_mt_val.en.txt
    echo "Model:"$MODEL_NAME "Src:"$SRC_FILE "Tgt:"$TGT_FILE
    python translate.py -model $MODEL_NAME -src $SRC_FILE -output $TGT_FILE -verbose -gpu 0 | tee tmp/log_test_$TIME_TAG.txt
}

func_nmt_eval_bt()
{
    SOURCE_DIR=$PWD
    eval cd "${SOURCE_DIR}"
    export PYTHONPATH="$PYTHONPATH:$SOURCE_DIR"
    echo "Start from source dir: "$SOURCE_DIR
    MODEL_NAME=/home/jxgu/github/unparied_im2text_jxgu/neural_machine_translation/save/demo-model-bt/model_acc_47.67_ppl_22.55_e13.pt
    #SRC_FILE=/home/jxgu/github/unparied_im2text_jxgu/misc/dataloader/vg_attributes_vocab.txt
    #TGT_FILE=/home/jxgu/github/unparied_im2text_jxgu/misc/dataloader/vg_attributes_vocab_zh.txt
    SRC_FILE=/home/jxgu/github/unparied_im2text_jxgu/data/mscoco/output_cocotalk_sents.txt
    TGT_FILE=/home/jxgu/github/unparied_im2text_jxgu/data/mscoco/output_cocotalk_sents_zh.txt
    echo "Model:"$MODEL_NAME "Src:"$SRC_FILE "Tgt:"$TGT_FILE
    python translate.py -model $MODEL_NAME -src $SRC_FILE -output $TGT_FILE -verbose -gpu 0 | tee tmp/log_test_$TIME_TAG.txt
}


func_nmt_eval_bt
