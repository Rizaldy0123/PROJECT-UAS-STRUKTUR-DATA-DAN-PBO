import 'ClassAyam.dart';
// 3. CLASS KETIGA: AyamKampung (Child Class)
// Menerapkan INHERITANCE & POLYMORPHISM 
// Memanggil konstruktor Parent menggunakan super() 
class AyamKampung extends Ayam { // AyamKampung adalah kelas anak yang mewarisi dari kelas Ayam (Parent Class)
  AyamKampung(String idCincin, double bobot) : super(idCincin, bobot);

// Meng-override method dari Parent Class (Polymorphism)
// Method ini akan di-override untuk menampilkan jenis ayam kampung saat dipanggil 
  @override
  String getJenis() { 
    return "Ayam Kampung"; // Menampilkan jenis ayam kampung saat method getJenis() dipanggil
  }
}