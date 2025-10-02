import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:himpunan_app/core/models/internal/internal_model.dart';

class InternalProkerState {
  final bool loading;
  final List<InternalProker> prokers;

  InternalProkerState({this.loading = false, this.prokers = const []});

  InternalProkerState copyWith({bool? loading, List<InternalProker>? prokers}) {
    return InternalProkerState(
      loading: loading ?? this.loading,
      prokers: prokers ?? this.prokers,
    );
  }
}

class InternalProkerCubit extends Cubit<InternalProkerState> {
  InternalProkerCubit() : super(InternalProkerState(loading: true));

  void loadDummyData() {
    emit(
      InternalProkerState(
        loading: false,
        prokers: [
          InternalProker(
            id: "1",
            nama: "Seminar Internal",
            deskripsi: "Seminar pengembangan anggota",
            tanggal: DateTime.now().add(const Duration(days: 3)),
          ),
          InternalProker(
            id: "2",
            nama: "Workshop Teknologi",
            deskripsi: "Workshop AI untuk anggota",
            tanggal: DateTime.now().add(const Duration(days: 10)),
          ),
        ],
      ),
    );
  }

  void addProker(InternalProker proker) {
    final updated = List<InternalProker>.from(state.prokers)..add(proker);
    emit(state.copyWith(prokers: updated));
  }

  void updateProker(InternalProker updatedProker) {
    final updated = state.prokers.map((p) {
      return p.id == updatedProker.id ? updatedProker : p;
    }).toList();
    emit(state.copyWith(prokers: updated));
  }

  void deleteProker(String id) {
    final updated = state.prokers.where((p) => p.id != id).toList();
    emit(state.copyWith(prokers: updated));
  }
}

class InternalAbsenCubit extends Cubit<List<AbsensiModel>> {
  InternalAbsenCubit() : super([]);

  // Dummy data
  void loadDummyData() {
    emit([
      AbsensiModel(nama: "Azis"),
      AbsensiModel(nama: "Budi"),
      AbsensiModel(nama: "Citra"),
      AbsensiModel(nama: "Dewi"),
    ]);
  }

  // Toggle hadir
  void toggleHadir(int index) {
    final updatedList = List<AbsensiModel>.from(state);
    updatedList[index].hadir = !updatedList[index].hadir;
    emit(updatedList);
  }

  // Tambah anggota
  void addAnggota(String nama) {
    final updatedList = List<AbsensiModel>.from(state);
    updatedList.add(AbsensiModel(nama: nama));
    emit(updatedList);
  }

  // Hapus anggota
  void removeAnggota(int index) {
    final updatedList = List<AbsensiModel>.from(state);
    updatedList.removeAt(index);
    emit(updatedList);
  }
}

class PengaduanState {
  final List<Pengaduan> pengaduanList;
  const PengaduanState({required this.pengaduanList});
}

class PengaduanCubit extends Cubit<PengaduanState> {
  PengaduanCubit() : super(const PengaduanState(pengaduanList: []));

  void loadDummyData() {
    emit(
      PengaduanState(
        pengaduanList: [
          Pengaduan(
            nama: 'Rahasia 1',
            deskripsi: 'Laporan terkait fasilitas AC rusak di ruang meeting.',
            tanggal: DateTime.now().subtract(const Duration(days: 1)),
            status: PengaduanStatus.pending,
          ),
          Pengaduan(
            nama: 'Rahasia 2',
            deskripsi: 'Keluhan kebersihan toilet lantai 2.',
            tanggal: DateTime.now().subtract(const Duration(days: 2)),
            status: PengaduanStatus.diterima,
          ),
          Pengaduan(
            nama: 'Rahasia 3',
            deskripsi: 'Permintaan tambahan kursi di ruang rapat.',
            tanggal: DateTime.now().subtract(const Duration(days: 3)),
            status: PengaduanStatus.ditolak,
          ),
        ],
      ),
    );
  }

  void updateStatus(int index, PengaduanStatus status) {
    final list = List<Pengaduan>.from(state.pengaduanList);
    final item = list[index];
    list[index] = Pengaduan(
      nama: item.nama,
      deskripsi: item.deskripsi,
      tanggal: item.tanggal,
      status: status,
    );
    emit(PengaduanState(pengaduanList: list));
  }
}
