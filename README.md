Dokumentasi Aplikasi
====================

1. Deskripsi Aplikasi
---------------------

Aplikasi Travel Pesawat dan Kereta yang menyediakan pilihan rute travel.
Aplikasi ini terbagi menjadi 2 bagian, yaitu *Client Side* dan *Server Side*
yang tiap-tiap bagian memiliki platformnya tersendiri.

Untuk *Client Side* tersedia dalam bentuk aplikasi berbasis Android, dimana
pengguna sebagai penumpang. Dan untuk bagian *Server Side* tersedia dalam bentuk
website yang fungsinya sebagai pengatur data pada keseluruhan aplikasi Ticketing
ini.

2. Kebutuhan Aplikasi
---------------------

Aplikasi ini terbagi menjadi dua macam platform yaitu *mobille* dan *website*
yang tiap-tiap platform memiliki kebutuhannya masing-masing. Berikut ini adalah
kebutuhan aplikasi berdasarkan platform yang dipakai :

### Mobile

-   Flutter SDK

-   Android Studio

-   Android SDK

-   VS Code

Website
-------

-   PHP versi 7.2

-   Composer

-   Laravel 5

-   MySQL

-   XAMPP

3. Mempersiapkan Aplikasi
-------------------------

### Website dan Database

-   Install PHP+Database, atau menggunakan paket AMP contohnya XAMPP, MAMP, dll.

-   Install Composer.

-   Masuk ke dalam folder project ujikom, berikut ini adalah conto perintahnya

-   Serelah ada di dalam folder project, buka Terminal/Command Prompt/Powershell
    lalu masukkan perintah di bawah.

-   Generate security key untuk kebutuhan session, berikut ini contoh
    perintahnya

-   Bikin database baru untuk menampung data dari aplikasi, untuk nama database
    bebas bisa apapun.

-   Edit file .env untuk konfigurasi. Khususnya konfigurasi database, berikut
    ini adalah contohnya

-   Karena laravel menyediakan fitur migrasi database, untuk pembuatan table
    database hanya tinggal memasukkan perintah berikut. Maka tabel-tabel akan
    otomatis menambah ke database yang telah diatur di file .env sebelumnya.

-   Dikarenakan belum terdapat trigger dan stored procedure yang tersetting saat
    migrasi database di laravel, maka diharuskan mengimport file travelijal.sql
    yang telah tersedia di folder projek ini.

### Aplikasi Mobile

-   Install Android Studio yang bisa didownload di
    <https://developer.android.com/studio> dan Berikut ini adalah yang
    dibutuhkan dari android studio

    -   Android SDK

    -   Android SDK Platform Tools

    -   Android SDK Build Tools

![](media/6d53a72d7dcb8ea9d868962b758b3c36.png)

![](media/cad6cdb3939a6018fb175b8b6c2ce67a.png)

-   Install Flutter SDK yang bisa didapatkan di <http://flutter.dev> dan untuk
    cara pemasangan flutter bisa dilihat di
    <https://flutter.dev/docs/get-started/install> kemudian pilih sistem operasi
    kemudian ikuti instruksi cara pemasangan Flutter.

-   Setelah menginstall flutter, untuk mengecek instalasi flutter dapat
    dilakukan dengan memasukkan perintah ini ke Command
    Prompt/PowerShell/Terminal.

    Nantinya akan muncul hasil perintah seperti ini sebagai indikasi apakah
    kebutuhan flutter SDK telah benar-benar terpasang.

    ![](media/aaf9a39684c8ccf54ebf92d2cff569e8.png)

    Dan apabila muncul error mengenai *Android license status unknown* masukkan
    perintah berikut ini kemudian tekan ‘Y’ pada setiap penerimaan akses lisensi
    android.

-   Setelah menginstall flutter dan segala kebutuhannya sekarang Install VS
    Code, selain VS Code, Android Studio dapat juga dipakai sebagai *source code
    editor*. Disini menggunakan VS Code sebagai *source code editor*.

-   Jika VS Code telah terinstall, pasang 2 Plugin berikut.

    -   Dart

    -   Flutter

-   Buka folder project aplikasi mobile.

-   Kemudian ketikkan perintah berikut untuk menginstall plugin-plugin yang
    digunakan didalam aplikasi ini. Untuk melakukan perintah ini harus terhubung
    koneksi internet.

4. Menjalankan Aplikasi
-----------------------

Setelah semua kebutuhan telah siap mulai dari database, website, dan juga mobile
apps sekarang lakukan perintah-perintah berikut untuk menjalankan aplikasi.

1.  Pertama nyalakan database terlebih dahulu, berikut ini contoh menyalakan
    database menggunakan XAMPP

    ![](media/ea08a6da70946b7bfd3d3e9d82bbbef4.png)

2.  Setelah database aktif, pastikan bahwa alat untuk menjalankan aplikasi
    mobile memiliki koneksi yang sama dengan komputer yang nantinya akan menjadi
    server, sebagai contoh adalah dengan terkoneksi dengan WiFi yang sama.

3.  Jika koneksi kedua perangkat telah sama, sekarang aktifkan website dengan
    cara berikut.

    -   Cek IP Address komputer dengan cara memasukkan perintah berikut kedalam
        terminal.

        Kemudian cek IP Komputer dengan melihat *value* dari IPv4 address.

    -   Setelah itu buka project website lalu masukkan perintah berikut

        Berikut ini untuk contoh lengkapnya.

4.  Setelah selesai sekarang website bisa dibuka menggunakan browser, masukkan
    link website kedalam form browser contohnya <http://192.168.1.1:8000>
    sesuaikan dengan ip komputer. Maka website telah dapat diakses

5.  Untuk pemakaian pertama maka belum terdapat user yang terdaftar maka harus
    didaftarkan terlebih dahulu dengan membuka halaman register dengan membuka
    daftarkan akun pertama di halaman tersebut.

    \*halaman register hanya dapat diakses apabila belum ada akun terdaftar.

6.  Buka database dan buka tabel **users** ubah **id_level** menjadi 1 untuk
    menjadikan akun tersebut menjadi admin.

7.  Kemudian login kembali menggunakan akun admin.

8.  Setelah pada bagian website selesai sekarang mulai kebagian aplikasi mobile.

9.  Sebelum running aplikasi, buka file **BaseServices.dart** yang terdapat pada
    folder **lib/utils**. Kemudian ubah value dari String baseUrl menjadi link
    url website yang telah aktif.

    ![](media/a5147d6d5635a48cd9f22e4870884028.png)

10. Jalankan emulator atau gunakan HP sebagai alat menaj

11. Sekarang Run aplikasi mobile.

    -   Untuk VS Code dapat dilakukan dengan cara Klik **F5** maka aplikasi akan
        otomatis berjalan ke alat atau emulator android.

    -   Untuk Android Studio klik button Run untuk menjalankan aplikasi.

5. Fitur Aplikasi
-----------------

### Login dan Register Penumpang

>   Login dan Register untuk penumpang terdapat pada aplikasi mobile, dimana
>   aplikasi mobile sebagai *Client Side* aplikasi.

![](media/165dd470a0fb824c54931f81fe85efd3.png)

![](media/d4ca9af56951b9feb2428ce0c7b3082c.png)

### Cari Tiket/Rute

>   Cari tiket atau rute terdapat pada aplikasi mobile, berfungsi untuk mencari
>   pilihan rute yang tersedia di aplikasi.

![](media/69bebc41c4c85eae898f31140340dd6a.png)

![](media/52516a2c54300cdde6c03bbb7d098a8e.png)

### Order / Pesan Tiket

>   Pesan tiket terapat pada aplikasi mobile, fitur ini berguna untuk melakukan
>   pemesanan tiket yang nantinya akan di validasi oleh petugas/admin agar tiket
>   yang telah dipesan menjadi aktif.

![](media/0c7a033797d750fab7a0e6d6b6520367.png)

![](media/23f03f6aae67d3b5d949148c2780d4e1.png)

### Edit Profil Penumpang

>   Edit data penumpang terdapat di aplikasi mobile, bertujuan untuk mengubah
>   data penumpang sesuai keinginan user.

![](media/9a1a9163e2c3a5e5d18fb1ea2bc47cad.png)

### Daftar Pesanan Tiket Penumpang

>   Daftar pesanan berisikan data pesanan yang telah dibeli oleh penumpang/user
>   dan memiliki status **pending** apabila belum tervalidasi, dan jika telah
>   divalidasi oleh admin/petugas status akan berubah menjadi **aktif**.

![](media/cad6e72102c3e4069131a0067ed75ea5.png)

### Login Admin/Petugas

>   Halaman login untuk admin atau petugas sebelum memasuki halaman dashboard
>   untuk mengelola data aplikasi.

![](media/b5e25cd7ecab954c56a827562e1fee3d.png)

### Data Pesanan

>   Halaman yang berisikan semua data-data pesanan yang telah dipesan oleh
>   penumpang atau user aplikasi mobile.

![](media/41099508911c6557b442aa3901ef1726.png)

### Validasi Pesanan

>   Button untuk memvalidasi pesanan, dan apabila jika sudah tervalidasi akan
>   muncul nama petugas yang bertanggung jawab telah memvalidasi pesanan
>   tersebut.

![](media/5439b2d4deae1b1c7f03d22879efba3d.png)

### Print Report Pesanan

>   Button untuk mencetak pesanan yang dipilih, yang akan di print merupakan
>   detail pesanan tiket.

![](media/ad89e66030be48fd9c48d92f484f0533.png)

### Print *Recap* Data Pesanan

>   Button untuk mencetak keselurahan data pesanan yang muncul di halaman data
>   pesanan, dan apabila telah di filter yang dicetak adalah semua data hasil
>   filter.

![](media/e962067e57419329165727a3fc607767.png)

### Data Rute

>   Halaman yang berisikan seluruh Data Rute yang tersedia di aplikasi. Data
>   Rute yang terdaftar akan muncul juga di aplikasi mobile/*Client Side* yang
>   bisa dipesan oleh penumpang.

![](media/198ee16f8ef703a3bbb4f37d44f6e9e2.png)

### Tambah Data Rute

>   Form untuk menambahkan data rute baru. Button ini hanya akan muncul apabila
>   yang login merupakan admin, petugas tidak dapat melihat button ini.

![](media/ad4d709e4729e9144f4f7dd6753d0221.png)

### Edit dan Hapus Data Rute

>   Button yang dapatt memunculkan form untuk mengedit data rute dan juga button
>   yang digunakan untuk menghapus data rute yang dipilih. Button ini hanya akan
>   muncul apabila yang login merupakan admin, petugas tidak dapat melihat
>   button ini.

![](media/ba957016e0b098570660660d2ee77a35.png)

![](media/5b03b4994863caaf284d840c61caf130.png)

### Data Transportasi

>   Halaman yang berisikan seluruh data transportasi yang tersedia di aplikasi.
>   Data transportasi nantinya akan muncul di form tambah rute.

![](media/f0f275a4b529d1ec675985f7a4ce30f3.png)

### Tambah Data Transportasi

>   Form untuk menambahkan data transportasi baru. Button ini hanya akan muncul
>   apabila yang login merupaksan admin, petugas tidak dapat melihat button ini.

![](media/47fd7f501cbcf24aa8ed3db6fa265969.png)

### Edit dan Hapus Data Transportasi

>   Button untuk menampilkan form untuk mengedit data transportasi dan button
>   untuk menghapus data transportasi yang dipilih. Button ini hanya akan muncul
>   apabila yang login merupakan admin, petugas tidak dapat melihat button ini.

![](media/a1cfb10a5c7a7d88a1f4a54086e37780.png)

![](media/64e0157dd9e01dac3f16cb5f4b2faa54.png)

### Data Petugas

>   Halaman data petugas yang terdaftar di aplikasi.

![](media/ddf817f89f022a295f0eae2f4f33bd92.png)

### Tambah Data Petugas

>   Form untuk menambahkan petugas yang dapat masuk kedalam aplikasi sebagai
>   petugas untuk memvalidasi tiket pesanan para penumpang. Button untuk
>   menambahkan data petugas hanya dapat dilihat dan diakses oleh Admin.

![](media/fa6f020746bdc08928c8ddd17e627dee.png)
