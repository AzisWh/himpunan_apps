import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:himpunan_app/bloc/auth/auth_cubit.dart';
import 'package:himpunan_app/bloc/auth/auth_state.dart';
import 'package:himpunan_app/core/constant/app_colors.dart';
import 'package:himpunan_app/screen/bendahara/bendahara_screen.dart';
import 'package:himpunan_app/screen/ketuawakil/ketuawakil_screen.dart';
import 'package:himpunan_app/screen/main-tabs/beranda_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    final email = _emailController.text;
    final pw = _passwordController.text;
    context.read<AuthCubit>().login(email: email, password: pw);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) async {
        if (Navigator.canPop(context)) {
          Navigator.of(
            context,
            rootNavigator: true,
          ).popUntil((route) => route.isFirst);
        }

        if (state is AuthLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else {
          Navigator.of(
            context,
            rootNavigator: true,
          ).popUntil((route) => route.isFirst);
        }

        if (state is AuthAuthenticated) {
          if (Navigator.canPop(context)) {
            Navigator.of(context, rootNavigator: true).pop();
          }
          if (state.user.email == "wakil@himpunan.com" &&
              state.user.password == "wakil123") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => KetuawakilScreen(user: state.user),
              ),
            );
          } else if (state.user.email == "ketua@himpunan.com" &&
              state.user.password == "ketua123") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => KetuawakilScreen(user: state.user),
              ),
            );
          } else if (state.user.email == "bendahara@himpunan.com" &&
              state.user.password == "bend123") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => BendaharaScreen(user: state.user),
              ),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const BerandaScreen(), // default user
              ),
            );
          }
        }

        if (state is AuthFailure) {
          if (Navigator.canPop(context)) {
            Navigator.of(context, rootNavigator: true).pop();
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(16),
            ),
          );
        }

        if (state is AuthLoggedOut) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: AppColors.kPrimaryGradientColor,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// Logo dummy
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColors.white,
                    backgroundImage: AssetImage("assets/image/hmti.png"),
                  ),
                  const SizedBox(height: 30),

                  const Text(
                    "Welcome Back!",
                    style: TextStyle(
                      fontSize: 24,
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Login to your account",
                    style: TextStyle(fontSize: 16, color: AppColors.white),
                  ),
                  const SizedBox(height: 30),

                  /// Email field
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.white,
                      hintText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  /// Password field
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.white,
                      hintText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// Login button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.biru,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _onLoginPressed,
                      child: const Text(
                        "Login",
                        style: TextStyle(color: AppColors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),

                  const SizedBox(height: 16),
                  const Text(
                    "Or continue with",
                    style: TextStyle(color: AppColors.white),
                  ),
                  const SizedBox(height: 12),

                  /// Social buttons row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _socialButton("G"),
                      const SizedBox(width: 12),
                      _socialButton("F"),
                      const SizedBox(width: 12),
                      _socialButton("in"),
                    ],
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialButton(String label) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: AppColors.white,
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.biru,
        ),
      ),
    );
  }
}
