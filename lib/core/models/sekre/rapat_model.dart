class KalenderRapat {
  final String id;
  String nama;
  DateTime tanggal;

  KalenderRapat({required this.id, required this.nama, required this.tanggal});

  KalenderRapat copyWith({String? id, String? nama, DateTime? tanggal}) {
    return KalenderRapat(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      tanggal: tanggal ?? this.tanggal,
    );
  }
}
