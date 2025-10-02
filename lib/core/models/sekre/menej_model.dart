class HimpunanUser {
  final String id;
  final String nama;
  final String role;

  HimpunanUser({required this.id, required this.nama, required this.role});

  HimpunanUser copyWith({String? id, String? nama, String? role}) {
    return HimpunanUser(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      role: role ?? this.role,
    );
  }
}

class Fasilitas {
  final String id;
  final String nama;
  final String peminjam;
  final DateTime tanggal;
  final String status; // pending, disetujui, ditolak

  Fasilitas({
    required this.id,
    required this.nama,
    required this.peminjam,
    required this.tanggal,
    this.status = "Pending",
  });

  Fasilitas copyWith({
    String? id,
    String? nama,
    String? peminjam,
    DateTime? tanggal,
    String? status,
  }) {
    return Fasilitas(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      peminjam: peminjam ?? this.peminjam,
      tanggal: tanggal ?? this.tanggal,
      status: status ?? this.status,
    );
  }
}
