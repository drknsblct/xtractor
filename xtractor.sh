#!/bin/bash
dir=$(basename $PWD)
cp ~/data.txt /tmp/$dir/backup
xxd -r backup >data

ftype=$(file -b --mime-type data* | cut -d '/' -f2)

until [ $ftype == 'plain' ]; do
        case $ftype in
        gzip)
                mv data* data.gz
                gzip -d data.gz
                echo "gzip -> data"
                ;;

        x-bzip2)
                mv data* data.bz2
                bzip2 -d data.bz2
                echo "bzip2 -> data"
                ;;

        x-tar)
                if [ $(ls | grep "bin") ]; then
                        bfile=$(ls | grep *"bin")
                        tar -xf $bfile
                        rm $bfile
                else
                        tar -xf data
                        rm data
                fi
                echo "tar -> data"
                ;;
        esac
        ftype=$(file -b --mime-type data* | cut -d '/' -f2)
done

cat data
