#!/bin/bash
randompass=`cat /dev/urandom | tr -d -c 'A-Za-z0-9' | fold -w 28 | head -n 1`
namafile=`echo $1 | tr -dc 'A-Z a-z'`

echo $randompass > $namafile.txt
