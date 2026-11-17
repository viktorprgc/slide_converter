#!/bin/bash

INPUT_DIR='/mnt/t/Victor/lam/pato_ger'
OUTPUT_DIR='/mnt/t/Victor/lam_compr'
DONEFILE=done
TODOFILE=todo

chunks=( $(ls chunks) )

read -a already_done -d '\n' < $DONEFILE
echo "${chunks[@]} ${already_done[@]}" | tr ' ' '\n' | sort | uniq -u > $TODOFILE
read -a todo -d '\n' < todo
next=${todo[0]}

echo ${next}

chunk=${1:-$next}

chunkfile="./chunks/${chunk}"

echo ${chunk}
echo ${chunkfile}

process_image()
{
    while IFS= read -r file_stem; do
        echo "processing $file_stem"
        python3 ../convslide "${INPUT_DIR}/${file_stem}.mrxs" "${OUTPUT_DIR}" \
        --raw-compression 9 --tiff-compression 0.2 --max-cached-tiles 256
    done < "$chunkfile"
}

in_array=$(echo ${chunks[@]} | grep -ow "$chunk" | wc  -w)
echo $in_array

if [[ $in_array = 1 ]]; then
    process_image && echo $chunk# >> $DONEFILE
fi

read -a already_done -d '\n' < $DONEFILE
echo "${chunks[@]} ${already_done[@]}" | tr ' ' '\n' | sort | uniq -u > $TODOFILE
read -a todo -d '\n' < todo
next=${todo[0]}
echo $next
