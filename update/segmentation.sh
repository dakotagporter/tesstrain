#!/bin/bash
#SOURCE="./"
lang=storysquadset
#set -- **/*.png_bw
find . -type f -name "*.png_bw.png" -exec sh -c '
    for img_file do
        echo  "\r\n File: $img_file"
        mogrify -density 300 "$img_file"
        OMP_THREAD_LIMIT=1 tesseract --tessdata-dir /mnt/c/Users/dabor/dev/storysquad/Tessie_True/tesseract/tessdata   "${img_file}" "${img_file%.*}"  --dpi 300 --psm 4  --oem 1 -l storysquadset -c page_separator="" hocr
        PYTHONIOENCODING=UTF-8 hocr-extract-images -p "${img_file%.*}"-%03d.tif  "${img_file%.*}".hocr
    done' sh {} +

find . -type f -name '*.txt' -execdir rename 's/\.\/(.+)\.txt$/$1.gt.txt/' '{}' \;

echo -e "\nImage files converted and processed. Correct the ground truth files and then run ./train_gt.sh -t to create training files."

