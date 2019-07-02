#!/usr/bin/bash


SCRIPT=$(readlink -m $(type -p "$0"))
SCRIPTDIR=${SCRIPT%/*}      

usage() {
    echo -e "Makes 'trainingDataT2Masks.csv'
Usage: 
    ${0##*/} <dir>

    <dir>   output directory for csv files
    "
}

[ "$#" -gt 0 ] && [[ "$1" != -h* ]] || { usage; exit 1; }
dirOutput=$1

datadir="$SCRIPTDIR/"
ls -1 $datadir/*mask.nrrd | sed "s|.*\/|$datadir|" > /tmp/t2masks.txt
ls -1 $datadir/*t2w.nrrd | sed "s|.*\/|$datadir|" > /tmp/t2s.txt

# no header
paste -d, /tmp/t2s.txt /tmp/t2masks.txt > $dirOutput/trainingDataT2Masks.csv
# with header
echo "image,mask" > $dirOutput/trainingDataT2Masks-hdr.csv
paste -d, /tmp/t2s.txt /tmp/t2masks.txt >> $dirOutput/trainingDataT2Masks-hdr.csv
