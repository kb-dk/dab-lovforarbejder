#!/bin/bash

source "parameters.sh"

rm volumes/*.xml ; ./aggregate-volumes.pl

for filename in ./volumes/[gr]*.xml; do
# for filename in ./volumes/g01.xml; do
    echo "$filename"
    result=`basename $filename .xml`

    $SAXON  $filename  add-structure.xsl  "volume_number=$result" > "volumes/step1-$result.xml"
    
    $SAXON  "volumes/step1-$result.xml" \
	    split-into-chapters.xsl "volume_number=$result" > "volumes/step2-$result.xml"

    $SAXON  "volumes/step2-$result.xml" \
	    extract-metadata.xsl "volume_number=$result" > "volumes/step2a-$result.xml"
    
    $SAXON  "volumes/step2a-$result.xml" \
	    chapters-into-sections.xsl "volume_number=$result" > "volumes/step3-$result.xml" 

    $SAXON  "volumes/step3-$result.xml" \
	    add-id-and-cleanup.xsl "volume_number=$result" > "volumes/step4-$result.xml"

    $SAXON  "volumes/step4-$result.xml" \
	    remove-redundant-sections.xsl "volume_number=$result" > "$filename"

    
    rm "volumes/step1-$result.xml" \
       "volumes/step2-$result.xml" \
       "volumes/step2a-$result.xml" \
       "volumes/step3-$result.xml" \
       "volumes/step4-$result.xml"
    
done
