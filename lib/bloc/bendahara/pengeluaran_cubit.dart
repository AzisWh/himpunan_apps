import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:himpunan_app/core/models/bendahara/kas_model.dart';
import 'package:himpunan_app/core/models/bendahara/pengeluaran_model.dart';

class KeuanganState extends Equatable {
  final bool loading;
  final List<Pengeluaran> pengeluarans;
  final List<Kas> kasList;

  const KeuanganState({
    this.loading = false,
    this.pengeluarans = const [],
    this.kasList = const [],
  });

  KeuanganState copyWith({
    bool? loading,
    List<Pengeluaran>? pengeluarans,
    List<Kas>? kasList,
  }) {
    return KeuanganState(
      loading: loading ?? this.loading,
      pengeluarans: pengeluarans ?? this.pengeluarans,
      kasList: kasList ?? this.kasList,
    );
  }

  @override
  List<Object?> get props => [loading, pengeluarans, kasList];
}

class KeuanganCubit extends Cubit<KeuanganState> {
  KeuanganCubit() : super(const KeuanganState());

  void loadDummyData() {
    emit(state.copyWith(loading: true));

    final dummyPengeluaran = [
      Pengeluaran(
        id: "1",
        nama: "Beli Spanduk",
        tanggal: "2025-10-01",
        jumlah: 200000,
      ),
      Pengeluaran(
        id: "2",
        nama: "Konsumsi Rapat",
        tanggal: "2025-10-02",
        jumlah: 150000,
      ),
    ];

    final dummyKas = [
      Kas(id: "1", namaPembayar: "Budi", tanggal: "2025-10-01", jumlah: 50000),
      Kas(id: "2", namaPembayar: "Siti", tanggal: "2025-10-02", jumlah: 50000),
    ];

    emit(
      state.copyWith(
        loading: false,
        pengeluarans: dummyPengeluaran,
        kasList: dummyKas,
      ),
    );
  }

  void tambahPengeluaran(Pengeluaran pengeluaran) {
    final updated = [...state.pengeluarans, pengeluaran];
    emit(state.copyWith(pengeluarans: updated));
  }

  void tambahKas(Kas kas) {
    final updated = [...state.kasList, kas];
    emit(state.copyWith(kasList: updated));
  }
}
