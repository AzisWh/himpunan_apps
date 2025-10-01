import 'package:flutter/material.dart';
import 'package:himpunan_app/core/constant/app_colors.dart';
import 'package:himpunan_app/core/models/user_model.dart';
import 'package:himpunan_app/screen/bendahara/tabs/kalender_screen.dart';
import 'package:himpunan_app/screen/bendahara/tabs/keuangan_screen.dart';
import 'package:himpunan_app/screen/bendahara/tabs/proker_screen.dart';
import 'package:himpunan_app/screen/main-tabs/auth_screen.dart';

class BendaharaScreen extends StatefulWidget {
  final UserModel? user;

  const BendaharaScreen({super.key, required this.user});

  @override
  State<BendaharaScreen> createState() => _BendaharaScreenState();
}

class _BendaharaScreenState extends State<BendaharaScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: AppColors.white,
          toolbarHeight: 0,
          bottom: const TabBar(
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            tabs: [
              Tab(text: "Keuangan", icon: Icon(Icons.money)),
              Tab(text: "Proker", icon: Icon(Icons.list)),
              Tab(text: "Kalender", icon: Icon(Icons.calendar_month)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            KeuanganScreen(user: widget.user),
            ProkerScreen(user: widget.user),
            KalenderScreen(user: widget.user),
          ],
        ),
      ),
    );
  }
}
