# SoalShiftSISOP20_modul1_T07


## soal 1
### nomor A

soal : tentukan region mana yang memiliki profit terendah

    echo "Region yang memiliki profit paling sedikit : "
    negaramiskin=`awk -F "," 'FNR>1{(seen[$13]+=$NF)}END{for(i in seen) print i, seen[i]}' Sample-Superstore.csv | sort -gk2 |  awk 'FNR < 2{print $1}'`
    echo "$negaramiskin"



1. `awk -F ","`  dengan , sebagai separator daripada column yang ada di csv.
2. `FNR > 1 ` dikarenakan baris pertama adalah judul , menggunakan fungsi ini agar mulai dari baris ke 2
3. `seen[$13]+=$NF` yang berartikan bahwa variable seen, yang memiliki index $13 (Antara lain West, South,Central,East) dan +=NF
                      yang digunakan untuk menjumlahkan semua profit
4. `END{for (i in seen) print i, print seen[i]}` Setelah proses awk selesai (END) maka akan dijalankan perintah untuk melakukan perintah print i yaitu nama dari Region, beserta profit tiap tiap Region
5. `Sample-Superstore.csv` Nama file yang digunakan
6. `sort -gk2`  melakukan sort (generik) pada kolom ke 2 (profit)
7. `awk FNR < 2{print $1}`  Melakukan proses print nama Region yang berada di posisi teratas (Profit Terkecil)

### nomor B

soal: tentukan 2 negara bagian yang memiliki profit terendah

    echo "negara bagian dengan profit terkecil adalah : "
    negarabagian=`awk -F "," -v a=$negaramiskin 'NR>1 {if(match($13, a))seen[$11]+=$NF} END{for(i in seen) printf "%s, %f\n", i, seen[i]}' Sample-Superstore.csv | sort -g -t "," -k2 | awk -F "," 'FNR < 3{printf "%s ", $1}'`
    profit=`awk -F "," -v a=$negaramiskin 'NR>1 {if(match($13, a))seen[$11]+=$NF} END{for(i in seen) printf "%s, %f\n", i, seen[i]}' Sample-Superstore.csv | sort -g -t "," -k2 | awk -F "," 'FNR < 3{printf "%s ", $2}'`
    negarabag1=`echo "$negarabagian" | awk -F " " '{printf "%s ",$1}'`
    profit1=`echo "$profit" | awk -F " " '{printf "%s ",$1}'`
    negarabag2=`echo "$negarabagian" | awk -F " " '{printf "%s",$2}'`
    profit2=`echo "$profit" | awk -F " " '{printf "%s",$2}'`

echo "$negarabag1 dengan profit $profit1"
echo "$negarabag2 dengan profit $profit2"


 1.  awk -F "," adalah separator ","
 2. -v a=$negaramiskin  Menyimpan nilai negaramiskin, ke dalam variable a
 3. NR>1  Start dari row ke 2
 4. if(match($13, a)seen[$11]+=NF)END --> Jika Kolom ke 13, match dengan variable a (NAMA REGION) maka buat array dengan index state, dan tambahkan profit dari tiap state,
 5. for(i in seen) printf "%s","%f"\n,i , seen[i] --> Untuk tiap i (State) print state dan juga jumlahlahnya
 6. sort -g -t "," -k2 --> sort menggunakan generik number , dan menggunakan separator "," , lalu disort dimulai dari kolom ke 2
 7. awk -F "," 'FNR < 3 {printf "%s ", $1}' --> Print 2 nama(negara bagian) pertama yang telah di sort
 8. awk -F "," 'FNR < 3 {printf "%s ", $2}' --> Print 2 profit yang telah dihasilkan oleh 2 negara bagian teratas yang telah disort
    
    negarabag1=`echo "$negarabagian" | awk -F " " '{printf "%s ",$1}'` dengan menggunakan echo dan separator , mengambil urutan pertama negara dengan profit terendah menggunakan $1 lalu dengan $2 menampilkan urutan ke 2
    
    hal tersebut juga dilakukan pada profit dimana dengan melakukan echo pada $profit dan melakukan panggilan $1 dan $2 dapat memanggil urutan 1 dan 2 pada profit terendah
    
### nomor C

soal : tampilkan 10 produk dengan profit terendah di negara bagian tersebut

    echo " 10 produk di $negarabag1"
    satuc1=`awk -F "," -v x1=$negarabag1 'NR>1 {if(match($11, x1))seen[$17]+=$NF}END{for(i in seen) printf "%s!%f\n", i,seen[i]}' Sample-Superstore.csv | sort -g -t "!" -k2 | awk -F "!" 'NR < 11 {print $1}'`
    echo "$satuc1"


  1. awk -F "," -v x1=$negarabag1 melakukan separator dan mendeklarasi variable dengan menggunakan data pada $negarabag1 
  2.  'NR>1 {if(match($11, x1))seen[$17]+=$NF}END{for(i in seen) printf "%s!%f\n", i,seen[i]}' Sample-Superstore.csv melihat semua kolom 11($11) di file sample (sampe-suprestore.csv) apakah sesuai dengan variable x1(negara bagian) jika iya makan nama barang($17) akan disimpan
  
  3. | sort -g -t "!" -k2 | awk -F "!" 'NR < 11 {print $1}'` melakukan sort pada nama barang sesuai dengan profit terkecil lalu di print hingga 10x
  4. lakukan hal yang sama pada $negarabag2 untuk menghasilkan nama barang yang ke 2
  
  
  ##soal 2
  
  ### nomor A
  
  soal : membuat password terdiri dari 28 huruf/angka acak yang dimasukkan kedalam folder(nama tidak boleh memiliki angka)
  
    randompass=`cat /dev/urandom | tr -d -c 'A-Za-z0-9' | fold -w 28 | head -n 1`
    namafile=`echo $1 | tr -dc 'A-Z a-z'`

    echo $randompass > $namafile.txt
    
  1. `cat /dev/urandom | tr -d -c 'A-Za-z0-9' | fold -w 28 | head -n 1` membuat 28 karakter secara acak
  2. namafile=`echo $1 | tr -dc 'A-Z a-z'` memastikan tidak ada angka pada nama file
  3. echo $randompass > $namafile.txt memasukkan password kedalam file
  
  ### nomor B
  
  soal : mengenkripsi nama file demgan menggunakan metode caecar chipper dengan menambahkan huruf pada nama file dengan waktu(jam) program dijalankan
  
    uppercase='ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ'
    normal='abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz'
    waktu=$(stat -c %y $1 | grep -oP '(?<=[^ ] ).*(?=:.*:)')
    namabaru=$(echo "${1%.txt}" | tr ${uppercase:$waktu:26}${normal:$waktu:26} ${uppercase:0:26}${normal:0:26})
    mv $1 $namabaru".txt"
    
 1. $(stat -c %y $1 | grep -oP '(?<=[^ ] ).*(?=:.*:)') mengambil jam last modified dari file
 2. $(echo "${1%.txt}" | tr ${uppercase:$waktu:26}${normal:$waktu:26} ${uppercase:0:26}${normal:0:26}) menambahkan karakter dengan kunci yang diberikan dari waktu
 3. mv $1 $namabaru".txt" mengubah nama file
 
 ### nomor C
 
 soal : mendekripsi nama file yang telah dienkripsi sebelumnya 
 
    uppercase='ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ'
    normal='abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz'
    namafile=$(echo "${1%.txt}" | tr ${uppercase:0:26}${normal:0:26} ${uppercase:`date +%-H`:26}${normal:`date +%-H`:26})
    mv $1 $namafile".txt"
   
   dengan menggunakan kodingan diatas mengembalikan enkripsi dari 2b ke normal
   
  
  
    
    
    
