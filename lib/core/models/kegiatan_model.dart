class Kegiatan {
  final String id;
  final String nama;
  final String tanggal;
  final String jenis; // rapat / proker
  final String reminderStatus; // pending / sudah diingatkan

  Kegiatan({
    required this.id,
    required this.nama,
    required this.tanggal,
    required this.jenis,
    this.reminderStatus = "pending",
  });

  Kegiatan copyWith({String? reminderStatus}) {
    return Kegiatan(
      id: id,
      nama: nama,
      tanggal: tanggal,
      jenis: jenis,
      reminderStatus: reminderStatus ?? this.reminderStatus,
    );
  }
}
