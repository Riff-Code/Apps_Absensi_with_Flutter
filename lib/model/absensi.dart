class Absensi {
  String? id;
  String namaP;
  String tanggalAbsensi;
  String jamMasuk;
  String jamKeluar;
  String ket;
  Absensi({
    this.id,
    required this.namaP,
    required this.tanggalAbsensi,
    required this.jamKeluar,
    required this.ket,
    required this.jamMasuk,
  });
  factory Absensi.fromJson(Map<String, dynamic> json) => Absensi(
      namaP: json["nama"],
      tanggalAbsensi: json["tanggal_absensi"],
      jamKeluar: json["jam_keluar"],
      ket: json["keterangan"],
      jamMasuk: json["jam_masuk"],
      id: json["id"]);
  Map<String, dynamic> toJson() => {
        "tanggal_absensi": tanggalAbsensi,
        "nama": namaP,
        "jam_keluar": jamKeluar,
        "keterangan": ket,
        "jam_masuk": jamMasuk
      };
}
