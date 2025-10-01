class VerifikasiItem {
  final int id;
  final String nama;
  final String tipe; //surat atau proker
  String status; // "pending", "disetujui", "ditolak"

  VerifikasiItem({
    required this.id,
    required this.nama,
    required this.tipe,
    this.status = "pending",
  });

  VerifikasiItem copyWith({String? status}) {
    return VerifikasiItem(
      id: id,
      nama: nama,
      tipe: tipe,
      status: status ?? this.status,
    );
  }
}
