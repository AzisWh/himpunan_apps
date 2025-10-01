import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:himpunan_app/core/models/bendahara/proker_bend_model.dart';

// STATE
class ProkerBendaharaState {
  final bool loading;
  final List<ProkerBend> prokerList;

  ProkerBendaharaState({this.loading = false, this.prokerList = const []});

  ProkerBendaharaState copyWith({bool? loading, List<ProkerBend>? prokerList}) {
    return ProkerBendaharaState(
      loading: loading ?? this.loading,
      prokerList: prokerList ?? this.prokerList,
    );
  }
}

// CUBIT
class ProkerCubit extends Cubit<ProkerBendaharaState> {
  ProkerCubit() : super(ProkerBendaharaState());

  void loadDummyData() {
    emit(state.copyWith(loading: true));
    final dummy = [
      ProkerBend(
        id: "1",
        nama: "Seminar Nasional",
        rab: 5000000,
        tanggal: DateTime.now().add(const Duration(days: 3)),
      ),
      ProkerBend(
        id: "2",
        nama: "Lomba Esport",
        rab: 2000000,
        tanggal: DateTime.now().add(const Duration(days: 7)),
      ),
    ];
    emit(state.copyWith(loading: false, prokerList: dummy));
  }

  void addProker(ProkerBend proker) {
    final updated = List<ProkerBend>.from(state.prokerList)..add(proker);
    emit(state.copyWith(prokerList: updated));
  }

  void updateReminder(String id) {
    final updated = state.prokerList.map((p) {
      if (p.id == id) {
        return ProkerBend(
          id: p.id,
          nama: p.nama,
          rab: p.rab,
          tanggal: p.tanggal,
          reminderStatus: "terkirim",
        );
      }
      return p;
    }).toList();
    emit(state.copyWith(prokerList: updated));
  }
}
