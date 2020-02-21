#!/bin/bash

uppercase='ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ'
normal='abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz'
namafile=$(echo "${1%.txt}" | tr ${uppercase:0:26}${normal:0:26} ${uppercase:`date +%-H`:26}${normal:`date +%-H`:26})
mv $1 $namafile".txt"
