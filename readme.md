##Tahap - tahap penginstalan

*pull project ini dan buat db baru*
*samain db yg di local dan ubah di .env nya, sesuaikan port*
*composer update, migrate db, seed.* Note : jika mau menggunakn db langsung sql tidak masalah

*           akses login Admin : admin@admin.com
*           pw                : admin
*           Member            : member@member.com
*           Pw                : member
Note : akun akan aktif bila email verfikasi telah terverifikasi, karena disini saya pake mailtrap yg free, maka                                            lebih enak lagi menggunakan hosting yang berbayar, Jika belum aktif maka dia tidak bisa memesan tiket dll.

 ##Petunjuk Pemesanan Tiket
 
  #1.First One
 *       ->    Login Menggunakan member@member.com
  #2.First Two
 *       ->    Ke halaman Home pilih Kereta
  #3.First Three
 *       ->    Pilih Kota Asal, kota tujuan, Kelas Kereta, Perjalanan, Tanggal Berangkat dan Jumlah Penumpang.
  #4.First Four
 *       ->    Pastikan Data Sesuai Dengan jadwal di tabel train_schedule, jika tidak sesuai maka dia tidak menampilkan data perjalanan.
  #5.First Five
 *       ->    klik Pesan
  #6.First Six
 *       ->    Berikut tampilan List pemesanan Tiket : Metode Pembayaran, Data Penumpang kemudian isikan nama nya dan langsung tekan enter.
  #7.First Seven
 *       ->    jangan lupa pilih Metode Pembayaran dulu.
  #8.First Eight
 *       ->    jika berhasil maka akan tampil di pojok kanan atas, klik pemesanan.
  #9.First Nine
 *       ->    disitu ada notif jika sudah di bayar dan yang belum, klik yang belum terbayar, dan klik tombol bayar.
  #10.First Ten
 *       ->    pastikan nama pengirim ( Transfer ) dan nominal sesuai dengan tagihan, bila tidak sesuai maka tidak akan bisa. Note : hanya mendukung angka 0 sd 9 saja, tidak di perbolehkan , . " dll.
 
 
