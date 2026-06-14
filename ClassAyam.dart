
// 1. CLASS PERTAMA: Ayam (Parent Class)
// Menerapkan ENCAPSULATION dengan menggunakan private properties dan getter untuk mengakses data ayam 
class Ayam {
  // Menggunakan underscore (_) untuk Private Properties (Encapsulation) 
  String _idCincin; // ID cincin unik untuk setiap ayam, digunakan untuk identifikasi ayam dalam kandang
  double _bobot; // Bobot ayam dalam kilogram, digunakan untuk menentukan apakah ayam sudah siap panen atau belum 

  // Konstruktor untuk menginisialisasi data ayam
  Ayam(this._idCincin, this._bobot);

  // Getter untuk membaca private data (Encapsulation)
  String get idCincin => _idCincin; // Getter untuk mendapatkan nilai ID cincin ayam 
  double get bobot => _bobot; // Getter untuk mendapatkan nilai bobot ayam

  // Method dasar untuk Polymorphism (akan di-override oleh child class)
  // Method ini akan di-override oleh kelas anak untuk menampilkan jenis ayam yang sesuai 
  String getJenis() { 
    return "Ayam Umum"; // Menampilkan jenis ayam umum jika method ini dipanggil tanpa di-override oleh kelas anak 
  }
}


