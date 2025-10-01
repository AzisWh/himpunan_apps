import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/models/user_model.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  // Dummy users (hardcoded)
  final List<UserModel> _dummyUsers = [
    UserModel(
      username: "Wakil Himpunan",
      email: "wakil@himpunan.com",
      password: "wakil123",
    ),
    UserModel(
      username: "Ketua Himpunan",
      email: "ketua@himpunan.com",
      password: "ketua123",
    ),
    UserModel(
      username: "Sekre Himpunan",
      email: "sekre@himpunan.com",
      password: "sekre123",
    ),
    UserModel(
      username: "Bendahara Himpunan",
      email: "bendahara@himpunan.com",
      password: "bend123",
    ),
    UserModel(
      username: "Iptek Himpunan",
      email: "iptek@himpunan.com",
      password: "iptek123",
    ),
    UserModel(
      username: "Danus Himpunan",
      email: "danus@himpunan.com",
      password: "danus123",
    ),
    UserModel(
      username: "Medinco Himpunan",
      email: "medinco@himpunan.com",
      password: "medinco123",
    ),
    UserModel(
      username: "Internal Himpunan",
      email: "internal@himpunan.com",
      password: "internal123",
    ),
    UserModel(
      username: "Eksternal Himpunan",
      email: "eksternal@himpunan.com",
      password: "eksternal123",
    ),
  ];

  // login by email + password
  void login({required String email, required String password}) async {
    emit(AuthLoading());

    // simulate delay
    await Future.delayed(const Duration(milliseconds: 600));

    try {
      final user = _dummyUsers.firstWhere(
        (u) =>
            u.email.toLowerCase() == email.trim().toLowerCase() &&
            u.password == password,
        orElse: () => throw Exception("Invalid credentials"),
      );

      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(const AuthFailure("Email atau password salah"));
    }
  }

  void logout() {
    emit(AuthLoggedOut());
  }
}
