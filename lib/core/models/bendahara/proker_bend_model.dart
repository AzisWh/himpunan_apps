class ProkerBend {
  final String id;
  final String nama;
  final double rab;
  final DateTime tanggal;
  String reminderStatus; // "pending" / "terkirim"

  ProkerBend({
    required this.id,
    required this.nama,
    required this.rab,
    required this.tanggal,
    this.reminderStatus = "pending",
  });
}
