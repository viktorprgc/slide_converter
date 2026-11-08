INPUT_DIR='/mnt/t/lam/pato_ger'
OUTPUT_DIR='/mnt/t/lam_compr'
chunk="/mnt/t/lam/xab"

while IFS= read -r file_stem; do
    python3 convslide "${INPUT_DIR}/${file_stem}.mrxs" "${OUTPUT_DIR}" \
     --raw-compression 9 --tiff-compression 0.2 --max-cached-tiles 256
 done < "$chunk"
