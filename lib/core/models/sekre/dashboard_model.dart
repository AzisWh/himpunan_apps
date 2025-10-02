class DashboardReminder {
  final String id;
  final String namaProker;
  final DateTime tanggal;
  String status; // pending / terkirim

  DashboardReminder({
    required this.id,
    required this.namaProker,
    required this.tanggal,
    this.status = "pending",
  });
}
