#!/bin/bash

BUCKET=$1
DIRECTORY=$2

mkdir -p "$DIRECTORY"
DIRECTORY=$(realpath "$DIRECTORY")

aws s3 cp "s3://$BUCKET/" "$DIRECTORY/" \
    --recursive \
    --exclude "*" \
    --include "*.txt"

echo "File path" > book_list.txt
find "$DIRECTORY" -type f -name "*.txt" | sort >> book_list.txt


COUNT=$(($(wc -l < book_list.txt) - 1))

echo "Wrote $COUNT book files to book_list.txt"
