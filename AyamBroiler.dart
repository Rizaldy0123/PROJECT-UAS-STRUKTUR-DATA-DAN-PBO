import 'ClassAyam.dart';
// 2. CLASS KEDUA: AyamBroiler (Child Class)
// Menerapkan INHERITANCE & POLYMORPHISM 
// Memanggil konstruktor Parent menggunakan super()
class AyamBroiler extends Ayam { // AyamBroiler adalah kelas anak yang mewarisi dari kelas Ayam (Parent Class)
  AyamBroiler(String idCincin, double bobot) : super(idCincin, bobot);

  // Meng-override method dari Parent Class (Polymorphism)
  // Method ini akan di-override untuk menampilkan jenis ayam broiler saat dipanggil 
  @override
  String getJenis() { // Meng-override method getJenis() untuk menampilkan jenis ayam broiler saat dipanggil
    return "Ayam Broiler"; // Menampilkan jenis ayam broiler saat method getJenis() dipanggil
  }
}