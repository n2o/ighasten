#!/bin/sh
# Prepare Hasten Hats PDFs for the Web

mkdir ori

# Create thumbnail
for f in *01.pdf
do
    file="${f%.*}"
    echo "Creating thumbnail of:" "$file"
    convert "$file".pdf -trim "$file".jpg
    mogrify -resize 300x "$file".jpg
    mv "$file".jpg "$file".thumb.jpg
done

# Trim and convert PDFs
for f in *.pdf
do
    file="${f%.*}"
    echo "Processing:" "$file"
    convert "$file".pdf -trim "$file".jpg
    mogrify -resize 100x "$file".jpg
    pdfcrop --margin 10 "$file".pdf
    mv "$file".pdf ori
    mv "$file"-crop.pdf "$file".pdf
    echo "Done."
done

echo "Conversion complete."
