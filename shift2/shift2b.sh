#!/bin/bash
uppercase='ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ'
normal='abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz'
waktu=$(stat -c %y $1 | grep -oP '(?<=[^ ] ).*(?=:.*:)')
namabaru=$(echo "${1%.txt}" | tr ${uppercase:$waktu:26}${normal:$waktu:26} ${uppercase:0:26}${normal:0:26})
mv $1 $namabaru".txt"
