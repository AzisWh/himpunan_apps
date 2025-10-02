import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:himpunan_app/core/models/sekre/cal_model.dart';

class CalendarSekreState {
  final bool loading;
  final List<CalendarSekreProker> events;

  CalendarSekreState({this.loading = false, this.events = const []});

  CalendarSekreState copyWith({
    bool? loading,
    List<CalendarSekreProker>? events,
  }) {
    return CalendarSekreState(
      loading: loading ?? this.loading,
      events: events ?? this.events,
    );
  }
}

class CalendarSekreCubit extends Cubit<CalendarSekreState> {
  CalendarSekreCubit() : super(CalendarSekreState());

  void loadDummyData() {
    emit(state.copyWith(loading: true));
    final dummy = [
      CalendarSekreProker(
        id: "1",
        nama: "IT Competition",
        tanggal: DateTime.now(),
      ),
      CalendarSekreProker(
        id: "2",
        nama: "Seminar Nasional",
        tanggal: DateTime.now().add(const Duration(days: 2)),
      ),
    ];
    emit(state.copyWith(loading: false, events: dummy));
  }

  void addProker(CalendarSekreProker proker) {
    final updated = List<CalendarSekreProker>.from(state.events)..add(proker);
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

  List<CalendarSekreProker> getEventsForDay(DateTime day) {
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
