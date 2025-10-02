class InternalProker {
  final String id;
  String nama;
  String deskripsi;
  DateTime tanggal;

  InternalProker({
    required this.id,
    required this.nama,
    required this.deskripsi,
    required this.tanggal,
  });
}

class AbsensiModel {
  final String nama;
  bool hadir;

  AbsensiModel({required this.nama, this.hadir = false});
}

enum PengaduanStatus { pending, diterima, ditolak }

class Pengaduan {
  final String nama;
  final String deskripsi;
  final DateTime tanggal;
  final PengaduanStatus status;

  Pengaduan({
    required this.nama,
    required this.deskripsi,
    required this.tanggal,
    required this.status,
  });
}
