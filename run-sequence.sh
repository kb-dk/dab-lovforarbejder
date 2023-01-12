#!/bin/bash

source "parameters.sh"

rm ./volumes/result*

for filename in ./volumes/*.xml; do
    echo "$filename"
    result=`basename $filename .xml`

    $SAXON  $filename  add-structure.xsl  "volume_number=$result" > "volumes/result-$result.xml"

done
