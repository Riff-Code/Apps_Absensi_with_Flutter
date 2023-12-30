class Cuti {
  String? id;
  String namaP;
  String tanggalMulai;
  String tanggalSelesai;
  String jenisCuti;
  String ket;
  Cuti({
    this.id,
    required this.namaP,
    required this.tanggalMulai,
    required this.jenisCuti,
    required this.ket,
    required this.tanggalSelesai,
  });
  factory Cuti.fromJson(Map<String, dynamic> json) => Cuti(
      namaP: json["nama"],
      tanggalMulai: json["tanggal_mulai"],
      jenisCuti: json["jenis_cuti"],
      ket: json["keterangan"],
      tanggalSelesai: json["tanggal_selesai"],
      id: json["id"]);
  Map<String, dynamic> toJson() => {
        "tanggal_mulai": tanggalMulai,
        "nama": namaP,
        "jenis_cuti": jenisCuti,
        "keterangan": ket,
        "tanggal_selesai": tanggalSelesai
      };
}
