import 'package:flutter/material.dart';
import 'package:himpunan_app/core/constant/app_colors.dart';
import 'package:himpunan_app/screen/auth/login_screen.dart';
import 'package:himpunan_app/screen/auth/register_scree.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Login + Register
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: AppColors.white,
          // title: const Text("Authentication"),
          toolbarHeight: 0,
          centerTitle: true,
          bottom: const TabBar(
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            tabs: [
              Tab(text: "Login", icon: Icon(Icons.login)),
              Tab(text: "Register", icon: Icon(Icons.app_registration)),
            ],
          ),
        ),
        body: const TabBarView(children: [LoginScreen(), RegisterScreen()]),
      ),
    );
  }
}
