import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../core/models/kegiatan_model.dart';

class KegiatanState extends Equatable {
  final bool loading;
  final List<Kegiatan> kegiatans;

  const KegiatanState({this.loading = false, this.kegiatans = const []});

  KegiatanState copyWith({bool? loading, List<Kegiatan>? kegiatans}) {
    return KegiatanState(
      loading: loading ?? this.loading,
      kegiatans: kegiatans ?? this.kegiatans,
    );
  }

  @override
  List<Object?> get props => [loading, kegiatans];
}

class KegiatanCubit extends Cubit<KegiatanState> {
  KegiatanCubit() : super(const KegiatanState());

  void loadDummyData() {
    emit(state.copyWith(loading: true));

    final dummy = [
      Kegiatan(
        id: "1",
        nama: "Rapat Harian Himpunan",
        tanggal: "2025-10-02",
        jenis: "rapat",
      ),
      Kegiatan(
        id: "2",
        nama: "Persiapan Proker Seminar",
        tanggal: "2025-10-05",
        jenis: "proker",
      ),
    ];

    emit(state.copyWith(loading: false, kegiatans: dummy));
  }

  void updateReminder(String id, String status) {
    final updated = state.kegiatans.map((k) {
      if (k.id == id) {
        return k.copyWith(reminderStatus: status);
      }
      return k;
    }).toList();

    emit(state.copyWith(kegiatans: updated));
  }
}
