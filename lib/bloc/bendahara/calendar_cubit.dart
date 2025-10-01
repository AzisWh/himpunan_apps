import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:himpunan_app/core/models/bendahara/calendar_model.dart';

class CalendarState {
  final bool loading;
  final List<CalendarProker> events;

  CalendarState({this.loading = false, this.events = const []});

  CalendarState copyWith({bool? loading, List<CalendarProker>? events}) {
    return CalendarState(
      loading: loading ?? this.loading,
      events: events ?? this.events,
    );
  }
}

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit() : super(CalendarState());

  void loadDummyData() {
    emit(state.copyWith(loading: true));

    final dummy = [
      CalendarProker(id: "1", nama: "Rapat Harian", tanggal: DateTime.now()),
      CalendarProker(
        id: "2",
        nama: "Seminar Nasional",
        tanggal: DateTime.now().add(const Duration(days: 2)),
      ),
    ];

    emit(state.copyWith(loading: false, events: dummy));
  }

  void addProker(CalendarProker proker) {
    final updated = List<CalendarProker>.from(state.events)..add(proker);
    emit(state.copyWith(events: updated));
  }

  List<CalendarProker> getEventsForDay(DateTime day) {
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
