import 'dart:io'; // Tambahan wajib untuk membaca input dari keyboard
import 'dart:collection'; // Untuk menggunakan Queue dalam proses vaksinasi 
import 'ClassAyam.dart'; // Mengimpor file ClassAyam.dart yang berisi definisi kelas Ayam (Parent Class)
import 'AyamBroiler.dart'; // Mengimpor file AyamBroiler.dart yang berisi definisi kelas AyamBroiler (Child Class)
import 'AyamKampung.dart'; // Mengimpor file AyamKampung.dart yang berisi definisi kelas AyamKampung (Child Class)

void main() {
  // KONSEP 1: LIST & INSTANSIASI CHILD CLASS (Polymorphism) 
  // Membuat list kandangAyam yang berisi objek-objek dari kelas AyamBroiler dan AyamKampung,
  // memanfaatkan konsep Polymorphism untuk menyimpan objek dari kelas turunan dalam list yang bertipe kelas induk (Ayam)
  List<Ayam> kandangAyam = [
    AyamBroiler('BR-001', 1.8),
    AyamBroiler('BR-002', 2.1),
    AyamKampung('KP-001', 1.2),
    AyamBroiler('BR-003', 1.9),
    AyamKampung('KP-002', 1.5),
    AyamBroiler('BR-004', 2.0),
    AyamKampung('KP-003', 1.3),
  ];

  // INISIALISASI KONSEP 2: QUEUE (Antrean Vaksinasi) - FIFO (First In First Out)
  // Membuat Queue untuk proses vaksinasi ayam. Inisialisasi diletakkan di luar menu 
  // agar data antrean tidak ter-reset saat pengguna memilih menu lain.
  Queue<Ayam> antreanVaksin = Queue<Ayam>(); 
  antreanVaksin.add(kandangAyam[0]); // BR-001 
  antreanVaksin.add(kandangAyam[2]); // KP-001
  antreanVaksin.add(kandangAyam[4]); // KP-002

  bool isProgramBerjalan = true; // Variabel pengontrol perulangan menu utama 

  // LOOPING MENU INTERAKTIF 
  // Perulangan while untuk menampilkan menu utama secara terus-menerus hingga user memilih untuk keluar (pilihan 7)
  while (isProgramBerjalan) {
    print('\n======================================');
    print('   SISTEM MANAJEMEN FARMTRACK');
    print('======================================');
    print('1. Tampilkan Populasi Kandang (List)');
    print('2. Proses Antrean Vaksinasi (Queue / Dequeue)');
    print('3. Daftar Ayam Siap Panen (Sorting)');
    print('4. Cari Data Ayam (Searching)');
    print('5. Tambah Bibit Ayam (Insert Data ke List)'); 
    print('6. Tambah Antrean Vaksinasi (Enqueue)'); // MENU BARU DITAMBAHKAN
    print('7. Keluar Program'); // Menu keluar digeser ke urutan 7
    print('======================================');
    
    // MENGAMBIL INPUT DARI USER UNTUK MEMILIH MENU 
    // Menggunakan stdout.write untuk menampilkan prompt tanpa membuat baris baru, sehingga input user akan berada di sebelah prompt
    stdout.write('Pilih menu (1-7): ');  // Prompt untuk memasukkan pilihan menu oleh user 
    String? pilihan = stdin.readLineSync(); // Membaca input angka dari user

    print(''); // Cetak baris kosong agar output terminal rapi

    // Logika pemilihan menu menggunakan switch-case untuk mengeksekusi fungsi sesuai pilihan user 
    switch (pilihan) {
      case '1':
        // Menampilkan data populasi kandang dengan memanfaatkan konsep Polymorphism
        // Saat memanggil method getJenis(), akan secara dinamis menampilkan jenis ayam 
        // yang sesuai dengan objek yang dipanggil (AyamBroiler atau AyamKampung)
        print('=== DATA POPULASI KANDANG ===');
        for (var ayam in kandangAyam) { // Menggunakan for-each loop untuk iterasi setiap objek ayam dalam list kandangAyam
          // Memanggil getter dan method polymorphism secara dinamis untuk menampilkan ID, jenis, dan bobot ayam dalam format yang rapi
          print('ID: ${ayam.idCincin} | Jenis: ${ayam.getJenis()} | Bobot: ${ayam.bobot} kg');
        }
        break;

      case '2':
        // Proses vaksinasi dengan konsep Queue (FIFO) 
        // untuk memastikan ayam yang pertama masuk antrean akan diproses terlebih dahulu 
        print('=== PROSES VAKSINASI (QUEUE) ===');
        if (antreanVaksin.isEmpty) { // Mengecek apakah antrean vaksinasi kosong sebelum memproses vaksinasi 
          print('Tidak ada antrean vaksinasi saat ini (sudah diproses semua).');
        } else { // Jika masih ada ayam dalam antrean, proses vaksinasi satu per satu sesuai urutan masuk (FIFO)
          while (antreanVaksin.isNotEmpty) { // Perulangan while untuk memproses vaksinasi selama masih ada ayam dalam antrean 
            Ayam diproses = antreanVaksin.removeFirst(); // Mengambil ayam pertama dari antrean untuk diproses vaksinasi (Dequeue)
            print('Meneteskan vaksin untuk ${diproses.getJenis()} dengan ID ${diproses.idCincin}...');
          } // Setelah semua ayam dalam antrean diproses, tampilkan pesan bahwa semua jadwal vaksinasi hari ini telah selesai
          print('Semua jadwal vaksinasi hari ini telah selesai!'); 
        }
        break;

      case '3':
        // KONSEP 3: SORTING (Insertion Sort - Bobot Panen)
        // Menampilkan daftar ayam yang siap panen dengan mengurutkan berdasarkan bobot menggunakan algoritma Insertion Sort
        print('=== DAFTAR AYAM SIAP PANEN (URUT BOBOT TERBERAT) ===');
        List<Ayam> listSiapPanen = List.from(kandangAyam); // Membuat salinan list tanpa mengubah data asli

        // Menggunakan Insertion Sort untuk mengurutkan ayam berdasarkan bobot dari yang terberat ke yang teringan
        // Looping dimulai dari index 1 karena kita menganggap ayam pertama (index 0) sudah berada di posisi yang benar 
        for (int i = 1; i < listSiapPanen.length; i++) { 
          Ayam key = listSiapPanen[i]; // Menyimpan ayam yang akan dibandingkan (key) 
          int j = i - 1;
          // Menggeser ayam dengan bobot lebih ringan ke kanan untuk memberi ruang bagi ayam dengan bobot lebih berat (key) 
          // Perbandingan menggunakan key.bobot untuk mengurutkan berdasarkan bobot, 
          // jika ayam di posisi j memiliki bobot lebih ringan dari key, geser ke kanan
          while (j >= 0 && listSiapPanen[j].bobot < key.bobot) { 
            listSiapPanen[j + 1] = listSiapPanen[j];
            j = j - 1;
          } 
          // Menempatkan ayam dengan bobot lebih berat (key) pada posisi yang tepat dalam list yang sudah diurutkan
          listSiapPanen[j + 1] = key;
        }

        // Menampilkan daftar ayam yang siap panen setelah diurutkan berdasarkan bobot dari yang terberat ke yang teringan
        for (var ayam in listSiapPanen) {
          print('${ayam.idCincin} - ${ayam.getJenis()} (${ayam.bobot} kg)');
        } 
        break;

      case '4':
        // KONSEP 4: SEARCHING (Linear Search) 
        // Mencari data ayam berdasarkan ID cincin yang dimasukkan oleh user menggunakan algoritma Linear Search 
        print('=== PENCARIAN DATA AYAM ===');
        stdout.write('Masukkan ID Cincin yang dicari (contoh: KP-001): '); // Prompt untuk memasukkan ID cincin yang ingin dicari oleh user
        String? cariIdInput = stdin.readLineSync(); // Membaca input ID yang diketik user

        // Validasi input untuk memastikan user tidak memasukkan ID kosong sebelum melakukan pencarian 
        if (cariIdInput != null && cariIdInput.isNotEmpty) {
          bool statusDitemukan = false; // Variabel untuk menandai apakah data ayam dengan ID yang dicari ditemukan dalam list atau tidak
          // Melakukan pencarian linear untuk menemukan ayam dengan ID cincin yang sesuai 
          for (int i = 0; i < kandangAyam.length; i++) {
            // toUpperCase() digunakan agar pencarian mengabaikan huruf besar/kecil
            // Jika ditemukan ayam dengan ID cincin yang sesuai, tampilkan informasi ayam tersebut 
            // dan ubah statusDitemukan menjadi true, kemudian keluar dari loop
            if (kandangAyam[i].idCincin.toUpperCase() == cariIdInput.toUpperCase()) { 
              print('Ditemukan: ${kandangAyam[i].getJenis()} (ID: ${kandangAyam[i].idCincin}) bobot ${kandangAyam[i].bobot} kg.');
              statusDitemukan = true;
              break; // Menghentikan iterasi karena data sudah ditemukan
            }
          }

          // Jika setelah iterasi selesai statusDitemukan masih false, berarti data tidak ditemukan dalam list 
          //dan berikan feedback kepada user bahwa ayam dengan ID cincin yang dicari tidak ditemukan
          if (!statusDitemukan) {
            print('Ayam dengan ID cincin "$cariIdInput" tidak ditemukan.');
          }
        } else { // Memberikan feedback kepada user jika input ID kosong, meminta untuk memasukkan ID yang valid
          print('Input ID tidak boleh kosong.');
        }
        break; 

      case '5':
        // KONSEP 5: INSERT DATA (Menambah ke List Dinamis)
        // Memungkinkan user memasukkan bibit ayam baru ke dalam list kandangAyam
        print('=== TAMBAH BIBIT AYAM BARU ===');
        stdout.write('Masukkan ID Cincin (contoh: BR-005): '); // Prompt untuk memasukkan ID ayam baru
        String? idBaru = stdin.readLineSync();
        // Validasi input ID agar tidak kosong sebelum melanjutkan ke input berikutnya
        stdout.write('Pilih Jenis (1 untuk Broiler, 2 untuk Kampung): '); // Prompt pilihan jenis
        String? jenisBaru = stdin.readLineSync();
        // Validasi input jenis agar tidak kosong sebelum melanjutkan ke input berikutnya
        stdout.write('Masukkan Bobot (dalam kg, contoh: 0.5): '); // Prompt untuk bobot awal ayam
        String? bobotStr = stdin.readLineSync();

        // Validasi agar input tidak ada yang dibiarkan kosong
        if (idBaru != null && idBaru.isNotEmpty && bobotStr != null && jenisBaru != null) {
          // Mengonversi input bobot bertipe string menjadi double
          double? bobotBaru = double.tryParse(bobotStr); 
          
          if (bobotBaru != null) {
            // Menerapkan konsep Polymorphism saat instansiasi objek dan memasukkannya ke dalam List Induk
            if (jenisBaru == '1') {
              kandangAyam.add(AyamBroiler(idBaru.toUpperCase(), bobotBaru));
              print('-> Berhasil! Ayam Broiler (ID: ${idBaru.toUpperCase()}) ditambahkan ke kandang.');
            } else if (jenisBaru == '2') {
              kandangAyam.add(AyamKampung(idBaru.toUpperCase(), bobotBaru));
              print('-> Berhasil! Ayam Kampung (ID: ${idBaru.toUpperCase()}) ditambahkan ke kandang.');
            } else {
              print('-> Gagal: Pilihan jenis ayam tidak valid. Silakan ketik 1 atau 2.');
            }
          } else {
            // Feedback jika user mengetikkan format bobot yang salah (misalnya pakai huruf)
            print('-> Gagal: Format bobot harus berupa angka (gunakan titik untuk desimal, contoh: 1.5).');
          }
        } else { // Feedback jika ada input yang kosong, meminta user untuk mengisi semua data dengan benar
          print('-> Gagal: Input tidak boleh ada yang kosong.');
        }
        break;

      case '6':
        // KONSEP: ENQUEUE (Menambah Data ke Antrean secara Dinamis)
        // Memanfaatkan Linear Search untuk mencari objek ayam di dalam List kandangAyam
        // Jika ditemukan, ayam tersebut akan dimasukkan ke dalam Queue antreanVaksin
        print('=== TAMBAH ANTREAN VAKSINASI (ENQUEUE) ===');
        stdout.write('Masukkan ID Cincin ayam yang akan divaksin: ');
        String? idVaksin = stdin.readLineSync();

        // Validasi input ID agar tidak kosong sebelum melakukan pencarian dan penambahan ke antrean vaksinasi
        if (idVaksin != null && idVaksin.isNotEmpty) {
          bool ditemukanDiKandang = false;

          // Menggunakan Linear Search untuk mencari referensi objek ayam di kandang
          for (var ayam in kandangAyam) {
            if (ayam.idCincin.toUpperCase() == idVaksin.toUpperCase()) {
              // Jika ayam ditemukan di kandang, tambahkan objek ayam tersebut ke antrean vaksinasi (Enqueue) 
              // dan berikan feedback kepada user bahwa ayam berhasil masuk ke antrean vaksinasi
              antreanVaksin.add(ayam); 
              print('-> Berhasil! ${ayam.getJenis()} (ID: ${ayam.idCincin}) masuk ke antrean vaksinasi.');
              ditemukanDiKandang = true;
              break;
            }
          }

          if (!ditemukanDiKandang) {
            print('-> Gagal: Ayam dengan ID "$idVaksin" tidak ditemukan di kandang.');
          }
        } else {
          print('-> Gagal: Input ID tidak boleh kosong.');
        }
        break;

      case '7':
      // Keluar dari program dengan menampilkan pesan terima kasih dan menghentikan perulangan menu utama
      // Menggunakan break untuk keluar dari switch-case dan menghentikan perulangan while, sehingga program akan berhenti berjalan
        print('Terima kasih telah menggunakan sistem FarmTrack!');
        isProgramBerjalan = false; // Menghentikan perulangan while, keluar dari program
        break;
      
      // Default case untuk menangani input yang tidak valid, memberikan feedback kepada user agar memasukkan pilihan yang benar
      default:
        print('Pilihan tidak valid! Silakan ketik angka 1 hingga 7.'); 
    }
  }
}