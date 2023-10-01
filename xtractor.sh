#!/bin/bash

xxd -r backup > data
ftype=$(file data* | cut -d ' ' -f2)

until [ $ftype == 'ASCII' ]; do

        if [ $ftype == "gzip" ]; then
                mv data* data.gz
                gzip -d data.gz
                echo "gzip -> data"

        elif [ $ftype == "bzip2" ]; then
                mv data* data.bz2
                bzip2 -d data.bz2
                echo "bzip2 -> data"

        elif [ $(ls | grep "bin") ]; then
                bfile=$(ls | grep *"bin")
                tar -xf $bfile
                rm $bfile
                echo "tar -> data"

        elif [ $ftype == "POSIX" ]; then
                tar -xf data
                rm data
                echo "tar -> data"
        fi

        ftype=$(file data* | cut -d ' ' -f2)
done

cat data
