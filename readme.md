##Tahap - tahap penginstalan

*pull project ini dan buat db baru*
*samain db yg di local dan ubah di .env nya, sesuaikan port*
*composer update, migrate db, seed.* Note : jika mau menggunakn db langsung sql tidak masalah
*akses login Admin : admin@admin.com*
*Member : member@member.com* Note : akun akan aktif bila email verfikasi telah terverifikasi, karena disini saya pake mailtrap yg free, maka                                            lebih enak lagi menggunakan hosting yang berbayar, Jika belum aktif maka dia tidak bisa memesan tiket dll.

 ##Petunjuk Pemesanan Tiket
 
 *       
 *       ->    Login Menggunakan member@member.com
 *       
 *       ->    Ke halaman Home pilih Kereta
 *       
 *       ->    Pilih Kota Asal, kota tujuan, Kelas Kereta, Perjalanan, Tanggal Berangkat dan Jumlah Penumpang.
 *       
 *       ->    Pastikan Data Sesuai Dengan jadwal di tabel train_schedule, jika tidak sesuai maka dia tidak menampilkan data perjalanan.
 *       
 *       ->    klik Pesan
 *       
 *       ->    Berikut tampilan List pemesanan Tiket : Metode Pembayaran, Data Penumpang kemudian isikan nama nya dan langsung tekan enter.
 *       
 *       ->    jangan lupa pilih Metode Pembayaran dulu.
 *       
 *       ->    jika berhasil maka akan tampil di pojok kanan atas, klik pemesanan.
 *       
 *       ->    disitu ada notif jika sudah di bayar dan yang belum, klik yang belum terbayar, dan klik tombol bayar.
 *       
 *       ->    pastikan nama pengirim ( Transfer ) dan nominal sesuai dengan tagihan, bila tidak sesuai maka tidak akan bisa. Note : hanya mendukung angka 0 sd 9 saja, tidak di perbolehkan , . " dll.
 
 
