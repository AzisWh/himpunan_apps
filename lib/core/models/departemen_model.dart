// models/departemen_model.dart
class Proker {
  final String nama;
  final String ketua;
  final String tanggal;
  final String status; //next, ongoing, done
  final List<String> progress; //khusus status= next

  Proker({
    required this.nama,
    required this.ketua,
    required this.tanggal,
    required this.status,
    this.progress = const [],
  });
}

class Departemen {
  final String nama;
  final List<Proker> prokers;

  Departemen({required this.nama, required this.prokers});
}
