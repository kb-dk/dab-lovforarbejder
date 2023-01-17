#!/bin/bash

source "parameters.sh"

rm volumes/*.xml ; ./aggregate-volumes.pl

for filename in ./volumes/[gr]*.xml; do
    echo "$filename"
    result=`basename $filename .xml`

    $SAXON  $filename  add-structure.xsl  "volume_number=$result" > "volumes/step1-$result.xml"
    $SAXON  "volumes/step1-$result.xml"   split-into-chapters.xsl "volume_number=$result" > "volumes/step2-$result.xml"
    $SAXON  "volumes/step2-$result.xml"   chapters-into-sections.xsl "volume_number=$result" > "volumes/step3-$result.xml"

#    $SAXON  "volumes/step3-$result.xml"    sections-into-sections-1.xsl > "volumes/step4-$result.xml"

#    $SAXON  "volumes/step4-$result.xml"    sections-into-sections-2.xsl > "volumes/step5-$result.xml"

done
