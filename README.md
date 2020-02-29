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
## soal 3
1 tahun telah berlalu sejak pencampakan hati Kusuma. Akankah sang pujaan hati kembali ke naungan Kusuma? Memang tiada maaf bagi Elen. Tapi apa daya hati yang sudah hancur, Kusuma masih terguncang akan sikap Elen. Melihat kesedihan Kusuma, kalian mencoba menghibur Kusuma dengan mengirimkan gambar kucing.
### nomor A

soal : Maka dari itu, kalian mencoba membuat script untuk mendownload 28 gambar dari "https://loremflickr.com/320/240/cat" menggunakan command wget dan menyimpan file dengan nama "pdkt_kusuma_NO" (contoh: pdkt_kusuma_1, pdkt_kusuma_2, pdkt_kusuma_3) serta jangan lupa untuk menyimpan log messages wget kedalam sebuah file "wget.log". .

Source Code : 
[source](https://github.com/belladewusa/SoalShiftSISOP20_modul1_T07 /soal3/shift3a.sh)

pertama-tama dicek dulu apa terdapat file `pdkt_kusuma_NO` , jika ada, penomoran akan dilanjutkan dari nomor yang terakhir, jika tidak ada, maka akan dibuat file dengan nama pdkt_kusuma_1 hingga pdkt_kusuma_28.  file di list menggunakan command `ls` . `Grep` untuk melakukan pencarian sebuah pattern dalam file teks pdkt_kusuma, kemudian di cut untuk mendapatkan nomornya saja. `short -n` , agar bisa dishort berdasarkan nilai numerik secara ascending. setelah itu nilai paling terakhir akan diambil dengan command `tail -1`. kemudian nilainya disimpan dalam variable `$C` . jika tidak ada nilai, variable `$c` tidak akan menyimpan nilai apapun, harusnya menyimpan nilai 0. looping dilakukan dari `$c + 1` sampai `$c + 29`. pada command wget terdapat opsi `-a` untuk mengappend log dari wget kedalam file yang dideklarasikan, dan opsi `-O` untuk mendeklarasikan nama file output hasil wget.


### nomor B

soal: Karena kalian gak suka ribet, kalian membuat penjadwalan untuk menjalankan script download gambar tersebut. Namun, script download tersebut hanya berjalan[b] setiap 8 jam dimulai dari jam 6.05 setiap hari kecuali hari Sabtu

Source Code : 
[source](https://github.com/belladewusa/SoalShiftSISOP20_modul1_T07 /soal3/crontab)

Penjadwalan dilakukan dengan membuat crontab. Kita set yang paling awal adalah setiap menit ke-5 , lalu setiap 8 jam dari jam 6 hingga jam 23, tanggalnya bebas, bulannya bebas, dan yang terakhir setiap hari minggu hingga jumat (kecuali sabtu).

### nomor C

soal : Karena gambar yang didownload dari link tersebut bersifat random, maka ada kemungkinan gambar yang terdownload itu identik. Supaya gambar yang identik tidak dikira Kusuma sebagai spam, maka diperlukan sebuah script untuk memindahkan salah satu gambar identik. Setelah memilah gambar yang identik, maka dihasilkan gambar yang berbeda antara satu dengan yang lain. Gambar yang berbeda tersebut, akan kalian kirim ke Kusuma supaya hatinya kembali ceria. Setelah semua gambar telah dikirim, kalian akan selalu menghibur Kusuma, jadi gambar yang telah terkirim tadi akan kalian simpan kedalam folder /kenangan dan kalian bisa mendownload gambar baru lagi. [c] Maka dari itu buatlah sebuah script untuk mengidentifikasi gambar yang identik dari keseluruhan gambar yang terdownload tadi. Bila terindikasi sebagai gambar yang identik, maka sisakan 1 gambar dan pindahkan sisa file identik tersebut ke dalam folder ./duplicate dengan format filename "duplicate_nomor" (contoh : duplicate_200, duplicate_201). Setelah itu lakukan pemindahan semua gambar yang tersisa kedalam folder ./kenangan dengan format filename "kenangan_nomor" (contoh: kenangan_252, kenangan_253). Setelah tidak ada gambar di current directory, maka lakukan backup seluruh log menjadi ekstensi ".log.bak". Hint : Gunakan wget.log untuk membuat location.log yang isinya merupakan hasil dari grep "Location". *Gunakan Bash, Awk dan Crontab.


Source Code : 
[source](https://github.com/belladewusa/SoalShiftSISOP20_modul1_T07 /soal3/shift3bc.sh)


Hal yang pertama dilakukan adalah mengecek file yang identic dengan cara mendapatkan location dari masing-masing log di file wget.log. jika ada yang sama maka itu adalah file duplicate. Tentukan nomor terakhir dari file “pdkt_kusuma”. Jika tidak ada yang sama maka `mkdir` directory tersebut. Selanjutnya kita menyimpan location yang sudah dicek tadi dengan menggunakan variable `$arr` dan `string` untuk memudahkan proses pengecekan. Looping berproses dari file pertama hingga file ke-`$end` . disimpan location dari file saat ini dengan `$loc`, kemudian gunakan `cat wget.log` untuk menampilkan isinya. Pipe ke dalam grep untuk mencari locationnya saja. Command head -$i untuk mengambil $i baris pertama, lalu `tail -1` untuk mengambil 1 yang terakhir. Kemudian di pipe lagi. Di cek file saat ini duplikat atau tidak menggunakan `$isDuplicate`. Pertama `$arr` akan di `echo-e` untuk mengeluarkan isinya, lalu hasilnya di pipe dengan command awk.  Selanjutnya diasumsikan file yang saat ini di cek bukan duplikat, tertera dalam block BEGIN. Kemudian cek dilakukan apa ada baris yang sama dengan $loc, jika yam aka file merupakan duplikan, ini tertera dalam block BODY. Terakhir nilai isDuplicate di print dan masuk kedalam variable `$isDuplicate` pada shell , ini tertera dalam block END. Kemudian pengecekan apakah file yang di-cek merupakan duplikat atau bukan . Jika iya, maka pindahkan file ke duplicate. Jika tidak, maka tambahkan `$loc` dari file baru tersebut kedalam `$arr` dan pindahkan file ke kenangan. Setelah itu, `wget.log` di pindahkan * kedalam `wget.log.bak`. Dan `wget.log` dihapus.




