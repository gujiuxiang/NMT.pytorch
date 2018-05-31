#!/usr/bin/env bash

func_opennmt_process()
{
    PROCESS_DIR=$PWD
    eval cd "${PROCESS_DIR}"
    export PYTHONPATH="$PYTHONPATH:$PROCESS_DIR"
    echo "Start from source dir: "$PROCESS_DIR
    python scripts/prepro_aic_mt.py -train_src $DATA_DIR/train_0303.zh -train_tgt $DATA_DIR/train_0303.en -valid_src $DATA_DIR/valid_0303.zh -valid_tgt $DATA_DIR/valid_0303.en -save_data $DATA_DIR/nmt_all_0303
}

func_preprocess()
{
    eval cd $PWD
    #unwrap xml for valid data and test data
    #python prepare_data/unwrap_xml.py $TMP_DIR/translation_validation_20170912/valid.en-zh.zh.sgm >$DATA_DIR/valid.en-zh.zh
    #python prepare_data/unwrap_xml.py $TMP_DIR/translation_validation_20170912/valid.en-zh.en.sgm >$DATA_DIR/valid.en-zh.en

    #Prepare Data
    ##Chinese words segmentation
    python prepare_data/jieba_cws.py $TMP_DIR/translation_train_20170912/train_0303.zh > $DATA_DIR/train_0303.zh
    python prepare_data/jieba_cws.py $TMP_DIR/translation_validation_20170912/valid_0303.en-zh.zh > $DATA_DIR/valid_0303.zh

    ## Tokenize and Lowercase English training data
    cat $TMP_DIR/translation_train_20170912/train_0303.en | prepare_data/tokenizer.perl -l en | tr A-Z a-z > $DATA_DIR/train_0303.en
    cat $TMP_DIR/translation_validation_20170912/valid_0303.en-zh.en | prepare_data/tokenizer.perl -l en | tr A-Z a-z > $DATA_DIR/valid_0303.en

    #Bulid Dictionary
    python prepare_data/build_dictionary.py $DATA_DIR/train_0303.en
    python prepare_data/build_dictionary.py $DATA_DIR/train_0303.zh

    src_vocab_size=50000
    trg_vocab_size=50000
    python prepare_data/generate_vocab_from_json.py $DATA_DIR/train.en.json ${src_vocab_size} > $DATA_DIR/vocab_0202.en
    python prepare_data/generate_vocab_from_json.py $DATA_DIR/train.zh.json ${trg_vocab_size} > $DATA_DIR/vocab_0202.zh
    rm -r $DATA_DIR/train.*.json
}

clear
ROOT_DIR=$PWD
DATA_DIR=$PWD/data/aic_mt/nmt_t2t_data_all
TMP_DIR=$PWD/data/aic_mt/raw_data
mkdir -p $DATA_DIR

#func_preprocess
func_opennmt_process