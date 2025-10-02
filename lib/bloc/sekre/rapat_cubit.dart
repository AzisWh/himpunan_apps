import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:himpunan_app/core/models/sekre/rapat_model.dart';

class KalenderRapatState {
  final bool loading;
  final List<KalenderRapat> events;

  KalenderRapatState({this.loading = false, this.events = const []});

  KalenderRapatState copyWith({bool? loading, List<KalenderRapat>? events}) {
    return KalenderRapatState(
      loading: loading ?? this.loading,
      events: events ?? this.events,
    );
  }
}

class KalenderRapatCubit extends Cubit<KalenderRapatState> {
  KalenderRapatCubit() : super(KalenderRapatState());

  void loadDummyData() {
    emit(state.copyWith(loading: true));
    final dummy = [
      KalenderRapat(id: "1", nama: "Rapat Harian", tanggal: DateTime.now()),
      KalenderRapat(
        id: "2",
        nama: "Rapat inventaris",
        tanggal: DateTime.now().add(const Duration(days: 2)),
      ),
    ];
    emit(state.copyWith(loading: false, events: dummy));
  }

  void addProker(KalenderRapat proker) {
    final updated = List<KalenderRapat>.from(state.events)..add(proker);
    emit(state.copyWith(events: updated));
  }

  void editProker(String id, String newName, DateTime newTanggal) {
    final updated = state.events.map((e) {
      if (e.id == id) {
        return e.copyWith(nama: newName, tanggal: newTanggal);
      }
      return e;
    }).toList();

    emit(state.copyWith(events: updated));
  }

  void deleteProker(String id) {
    final updated = state.events.where((e) => e.id != id).toList();
    emit(state.copyWith(events: updated));
  }

  List<KalenderRapat> getEventsForDay(DateTime day) {
    return state.events
        .where(
          (e) =>
              e.tanggal.year == day.year &&
              e.tanggal.month == day.month &&
              e.tanggal.day == day.day,
        )
        .toList();
  }
}
