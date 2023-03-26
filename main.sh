#!/bin/bash

echo "make sure you have a good amount of free space!"
echo "also get a decent chunk of RAM or enable a large amount of swap."

if [ "$#" == '0' ]; then
    echo "usage: $0 (model_sizes)"
    echo "model_sizes is a comma separated list containing one of the following"
    echo "4 values:7B,13B,30B,65B"
    exit 1
fi

mkdir -p models

bash llama.sh $1

git clone https://github.com/ggerganov/llama.cpp.git

mv models llama.cpp/

cd llama.cpp

make

python3 -m venv venv

venv/bin/python3 -m pip install torch numpy sentencepiece

IFS=","

for i in $1; do
    venv/bin/python3 convert-pth-to-ggml.py models/$i/ 1
    venv/bin/python3 quantize.py $i
done

echo "models ready! run llama.cpp/main to use the models."
