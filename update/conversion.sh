#!/bin/bash
find . -type f -name "*.jp*g" -exec sh -c '
    for f do
        echo "Converting $f"
        convert -density 300 "$f" -auto-orient "${f%.*}.png"
    done' sh {} +
