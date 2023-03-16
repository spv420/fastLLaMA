#!/bin/bash

if [ "$#" == '0' ]; then
    echo "usage: $0 (model_sizes)"
    echo "model_sizes is a comma separated list containing one of the following"
    echo "4 values:7B,13B,30B,65B"
    exit 1
fi

mkdir -p models

bash llama.sh $1

git clone https://github.com/ggerganov/llama.cpp.git