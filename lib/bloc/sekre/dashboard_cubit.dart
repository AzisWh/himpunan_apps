import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:himpunan_app/core/models/sekre/dashboard_model.dart';

class DashboardState {
  final bool loading;
  final List<DashboardReminder> reminders;

  DashboardState({this.loading = false, this.reminders = const []});

  DashboardState copyWith({bool? loading, List<DashboardReminder>? reminders}) {
    return DashboardState(
      loading: loading ?? this.loading,
      reminders: reminders ?? this.reminders,
    );
  }
}

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardState());

  void loadDummyData() {
    emit(state.copyWith(loading: true));
    final dummy = [
      DashboardReminder(
        id: "1",
        namaProker: "Rapat Mingguan",
        tanggal: DateTime.now().add(const Duration(days: 1)),
      ),
      DashboardReminder(
        id: "2",
        namaProker: "Seminar Nasional",
        tanggal: DateTime.now().add(const Duration(days: 3)),
      ),
    ];
    emit(state.copyWith(loading: false, reminders: dummy));
  }

  void sendNotif(String id) {
    final updated = state.reminders.map((r) {
      if (r.id == id) {
        return DashboardReminder(
          id: r.id,
          namaProker: r.namaProker,
          tanggal: r.tanggal,
          status: "terkirim",
        );
      }
      return r;
    }).toList();
    emit(state.copyWith(reminders: updated));
  }
}
