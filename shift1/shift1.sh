#!/bin/bash

echo "Region yang memiliki profit paling sedikit : "
negaramiskin=`awk -F "," 'FNR>1{(seen[$13]+=$NF)}END{for(i in seen) print i, seen[i]}' Sample-Superstore.csv | sort -gk2 | awk 'FNR < 2{print $1}'`
echo "$negaramiskin"
echo "negara bagian dengan profit terkecil adalah : "
negarabagian=`awk -F "," -v a=$negaramiskin 'NR>1 {if(match($13, a))seen[$11]+=$NF} END{for(i in seen) printf "%s, %f\n", i, seen[i]}' Sample-Superstore.csv | sort -g -t "," -k2 | awk -F "," 'FNR < 3{printf "%s ", $1}'`
profit=`awk -F "," -v a=$negaramiskin 'NR>1 {if(match($13, a))seen[$11]+=$NF} END{for(i in seen) printf "%s, %f\n", i, seen[i]}' Sample-Superstore.csv | sort -g -t "," -k2 | awk -F "," 'FNR < 3{printf "%s ", $2}'`
negarabag1=`echo "$negarabagian" | awk -F " " '{printf "%s ",$1}'`
profit1=`echo "$profit" | awk -F " " '{printf "%s ",$1}'`
negarabag2=`echo "$negarabagian" | awk -F " " '{printf "%s",$2}'`
profit2=`echo "$profit" | awk -F " " '{printf "%s",$2}'`

echo "$negarabag1 dengan profit $profit1"
echo "$negarabag2 dengan profit $profit2"

echo " 10 produk di $negarabag1"
satuc1=`awk -F "," -v x1=$negarabag1 'NR>1 {if(match($11, x1))seen[$17]+=$NF}END{for(i in seen) printf "%s!%f\n", i,seen[i]}' Sample-Superstore.csv | sort -g -t "!" -k2 | awk -F "!" 'NR < 11 {print $1}'`
echo "$satuc1"

echo "10 produk di $negarabag2"
satuc2=`awk -F "," -v x1=$negarabag2 'NR>1 {if(match($11, x1))seen[$17]+=$NF}END{for(i in seen) printf "%s!%f\n", i,seen[i]}' Sample-Superstore.csv | sort -g -t "!" -k2 | awk -F "!" 'NR < 11 {print $1}'`
echo "$satuc2"


