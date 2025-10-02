import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:himpunan_app/core/models/sekre/menej_model.dart';

class UserState {
  final bool loading;
  final List<HimpunanUser> users;

  UserState({this.loading = false, this.users = const []});

  UserState copyWith({bool? loading, List<HimpunanUser>? users}) {
    return UserState(
      loading: loading ?? this.loading,
      users: users ?? this.users,
    );
  }
}

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserState());

  void loadDummyData() {
    emit(state.copyWith(loading: true));
    final dummy = [
      HimpunanUser(id: "1", nama: "Andi", role: "Ketua"),
      HimpunanUser(id: "2", nama: "Budi", role: "Wakil"),
      HimpunanUser(id: "3", nama: "Citra", role: "Sekretaris"),
      HimpunanUser(id: "4", nama: "Dewi", role: "Bendahara"),
      HimpunanUser(id: "5", nama: "Eko", role: "Iptek"),
      HimpunanUser(id: "6", nama: "Fajar", role: "Danus"),
      HimpunanUser(id: "7", nama: "Gita", role: "Medinco"),
      HimpunanUser(id: "8", nama: "Hani", role: "Internal"),
      HimpunanUser(id: "9", nama: "Indra", role: "Eksternal"),
    ];
    emit(state.copyWith(loading: false, users: dummy));
  }

  void addUser(HimpunanUser user) {
    final updated = List<HimpunanUser>.from(state.users)..add(user);
    emit(state.copyWith(users: updated));
  }

  void editUser(String id, String newName, String newRole) {
    final updated = state.users.map((u) {
      if (u.id == id) return u.copyWith(nama: newName, role: newRole);
      return u;
    }).toList();
    emit(state.copyWith(users: updated));
  }

  void deleteUser(String id) {
    final updated = state.users.where((u) => u.id != id).toList();
    emit(state.copyWith(users: updated));
  }
}


class FasilitasState {
  final bool loading;
  final List<Fasilitas> list;

  FasilitasState({this.loading = false, this.list = const []});

  FasilitasState copyWith({bool? loading, List<Fasilitas>? list}) {
    return FasilitasState(
      loading: loading ?? this.loading,
      list: list ?? this.list,
    );
  }
}

class FasilitasCubit extends Cubit<FasilitasState> {
  FasilitasCubit() : super(FasilitasState());

  void loadDummyData() {
    emit(state.copyWith(loading: true));
    final dummy = [
      Fasilitas(
        id: "1",
        nama: "Aula Kampus",
        peminjam: "Andi",
        tanggal: DateTime.now(),
      ),
      Fasilitas(
        id: "2",
        nama: "Lapangan",
        peminjam: "Citra",
        tanggal: DateTime.now().add(const Duration(days: 2)),
      ),
    ];
    emit(state.copyWith(loading: false, list: dummy));
  }

  void addFasilitas(Fasilitas fasilitas) {
    final updated = List<Fasilitas>.from(state.list)..add(fasilitas);
    emit(state.copyWith(list: updated));
  }

  void updateStatus(String id, String newStatus) {
    final updated = state.list.map((f) {
      if (f.id == id) return f.copyWith(status: newStatus);
      return f;
    }).toList();
    emit(state.copyWith(list: updated));
  }

  void deleteFasilitas(String id) {
    final updated = state.list.where((f) => f.id != id).toList();
    emit(state.copyWith(list: updated));
  }
}
