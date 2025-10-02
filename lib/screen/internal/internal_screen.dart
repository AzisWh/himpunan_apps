import 'package:flutter/material.dart';
import 'package:himpunan_app/core/constant/app_colors.dart';
import 'package:himpunan_app/core/models/user_model.dart';
import 'package:himpunan_app/screen/internal/tabs/internal_absensi_screen.dart';
import 'package:himpunan_app/screen/internal/tabs/internal_pengaduan.dart';
import 'package:himpunan_app/screen/internal/tabs/internal_proker_screen.dart';

class InternalScreen extends StatefulWidget {
  final UserModel? user;
  const InternalScreen({super.key, required this.user});

  @override
  State<InternalScreen> createState() => _InternalScreenState();
}

class _InternalScreenState extends State<InternalScreen> {
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
              Tab(text: "Proker", icon: Icon(Icons.work)),
              Tab(text: "Absensi", icon: Icon(Icons.person)),
              Tab(text: "Pengaduan", icon: Icon(Icons.book)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            InternalProkerScreen(user: widget.user),
            InternalAbsensiScreen(user: widget.user),
            InternalPengaduan(user: widget.user),
          ],
        ),
      ),
    );
  }
}
