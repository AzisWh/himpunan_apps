import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/models/verikasi_model.dart';

class VerifikasiState {
  final bool loading;
  final List<VerifikasiItem> items;

  VerifikasiState({this.loading = false, this.items = const []});

  VerifikasiState copyWith({bool? loading, List<VerifikasiItem>? items}) {
    return VerifikasiState(
      loading: loading ?? this.loading,
      items: items ?? this.items,
    );
  }
}

class VerifikasiCubit extends Cubit<VerifikasiState> {
  VerifikasiCubit() : super(VerifikasiState());

  void loadDummyData() {
    emit(state.copyWith(loading: true));
    // dummy data
    final data = [
      VerifikasiItem(
        id: 1,
        nama: "Surat Undangan Rapat",
        status: "pending",
        tipe: "surat",
      ),
      VerifikasiItem(
        id: 2,
        nama: "Proker Bakti Sosial",
        status: "disetujui",
        tipe: "proker",
      ),
      VerifikasiItem(
        id: 3,
        nama: "Surat Peminjaman Aula",
        status: "ditolak",
        tipe: "surat",
      ),
    ];
    emit(VerifikasiState(loading: false, items: data));
  }

  void updateStatus(int id, String newStatus) {
    final updatedItems = state.items.map((e) {
      if (e.id == id) {
        return e.copyWith(status: newStatus);
      }
      return e;
    }).toList();

    emit(state.copyWith(items: updatedItems));
  }
}
