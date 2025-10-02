class CalendarSekreProker {
  final String id;
  String nama;
  DateTime tanggal;

  CalendarSekreProker({
    required this.id,
    required this.nama,
    required this.tanggal,
  });

  CalendarSekreProker copyWith({String? id, String? nama, DateTime? tanggal}) {
    return CalendarSekreProker(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      tanggal: tanggal ?? this.tanggal,
    );
  }
}
