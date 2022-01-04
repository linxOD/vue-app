# bin/bash

for file in src/data/xslt/*.xsl; do
    filename=$(echo $file | sed -e "s_.xsl__g")
    xslt3 -xsl:$file -export:$filename.sef.json -nogo
    echo "$filename.sef.json created"
done
echo "all files created"
