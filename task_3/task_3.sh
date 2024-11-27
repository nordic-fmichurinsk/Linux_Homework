#!/bin/bash

mkdir -p data

echo "Скачиваем файл аннотации генома..."
curl -o data/gencode.v41.basic.annotation.gff3.gz https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_41/gencode.v41.basic.annotation.gff3.gz

echo "Разархивируем файл..."
gunzip data/gencode.v41.basic.annotation.gff3.gz

mkdir -p terminal_task/results
 
awk -F'\t' '
    $3 == "gene" && $9 ~ /gene_type=unprocessed_pseudogene/ {
        split($9, info, ";");
        for (i in info) {
            if (info[i] ~ /gene_name=/) {
                gene_name = substr(info[i], index(info[i], "gene_name=") + 10);
            }
        }
        
        print $1, $4, $5, $7, gene_name;
    }
' OFS='\t' data/gencode.v41.basic.annotation.gff3 > terminal_task/results/filtered_annotation.tsv

awk -F'\t' '
    {
        if ($4 == "+" ) {
            end = $3 + 1;
            start = $3;
        }
        else if ($4 == "-") {
            end = $3;
            start = $3 - 1;
        }
        print $1, start, end, $4, $5;
    }
' terminal_task/results/filtered_annotation.tsv > terminal_task/results/result.tsv

echo "Завершено. Результат записан в terminal_task/results/result.tsv"