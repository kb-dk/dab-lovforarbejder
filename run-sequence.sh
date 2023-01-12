#!/bin/bash

source "parameters.sh"

rm volumes/*.xml ; ./aggregate-volumes.pl

for filename in ./volumes/*.xml; do
    echo "$filename"
    result=`basename $filename .xml`

    $SAXON  $filename  add-structure.xsl  "volume_number=$result" > "volumes/step1-$result.xml"

done
