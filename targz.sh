#!/bin/bash
FILE_LIST="file1 file2 file3"

for f in $FILE_LIST;
do
    tar -rvf archive.tar $f
done

gzip archive.tar
