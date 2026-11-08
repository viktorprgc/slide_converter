#!/usr/bin/env bash

COMPRESSED_DIR='/mnt/t/lam_compr/'


compr_=( $(du -BM ${COMPRESSED_DIR}/* | cut --fields 1) )

orig_=( $(cat done | xargs -I chunkfile cat chunks/chunkfile |\
    xargs -I directory du -d0 -BM /mnt/t/lam/pato_ger/directory |\
    cut --fields 1) )

round()
{
    printf %.2f "$1"
}


if [[ ${#orig_[@]} == ${#compr_[@]} ]]; then
    n_files=$(ls ${COMPRESSED_DIR} | wc -l)

    IFS=+
    sum_orig=$(echo "${orig_[*]}"|bc -l)
    sum_compr=$(echo "${compr_[*]}"|bc -l)

    mean_orig=$(echo $sum_orig "/" $n_files|bc -l)
    mean_compr=$(echo $sum_compr "/" $n_files|bc -l)

    reduction=$(echo $sum_orig "/" $sum_compr |bc -l)

    echo $mean_orig
    echo $mean_compr
fi

echo "Ocorreu uma redução de tamanho de $(round $reduction) vezes."

echo "======================================================="
echo "Tamanho original das imagens processadas:" $(round $reduction) "MBs"
echo "Tamanho após compressão:" $(round $sum_compr) "MBs"
echo "-------------------------------------------------------"
echo "Tamanho médio das imagens antes:" $(round $mean_orig)
echo "Tamanho médio das imagens depois:" $(round $mean_compr)
