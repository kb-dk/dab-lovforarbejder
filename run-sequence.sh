#!/bin/bash

source "parameters.sh"

rm volumes/*.xml ; ./aggregate-volumes.pl

for filename in ./volumes/[gr]*.xml; do
    echo "$filename"
    result=`basename $filename .xml`

    $SAXON  $filename  add-structure.xsl  "volume_number=$result" > "volumes/step1-$result.xml"
    $SAXON  "volumes/step1-$result.xml" \
	    split-into-chapters.xsl "volume_number=$result" > "volumes/step2-$result.xml"
    $SAXON  "volumes/step2-$result.xml" \
	    chapters-into-sections.xsl "volume_number=$result" > "$filename"

    rm "volumes/step1-$result.xml" "volumes/step2-$result.xml"
    
done
