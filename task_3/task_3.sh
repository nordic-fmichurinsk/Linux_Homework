#!/bin/bash

mkdir -p data

echo "Скачиваем файл аннотации генома..."
curl -o data/gencode.v41.basic.annotation.gff3.gz https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_41/gencode.v41.basic.annotation.gff3.gz

echo "Разархивируем файл..."
gunzip data/gencode.v41.basic.annotation.gff3.gz

mkdir -p terminal_task/results