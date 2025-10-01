import 'package:flutter/material.dart';
import 'package:himpunan_app/core/constant/app_colors.dart';
import 'package:himpunan_app/core/models/user_model.dart';
import 'package:himpunan_app/screen/ketuawakil/tabs/departemen_screen.dart';
import 'package:himpunan_app/screen/ketuawakil/tabs/kegiatan_screen.dart';
import 'package:himpunan_app/screen/ketuawakil/tabs/verifikasi_screen.dart';

class KetuawakilScreen extends StatefulWidget {
  final UserModel? user;

  const KetuawakilScreen({super.key, required this.user});

  @override
  State<KetuawakilScreen> createState() => _KetuawakilScreenState();
}

class _KetuawakilScreenState extends State<KetuawakilScreen> {
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
              Tab(text: "Departemen", icon: Icon(Icons.work)),
              Tab(text: "Verifikasi", icon: Icon(Icons.verified)),
              Tab(text: "Kegiatan", icon: Icon(Icons.event)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            DepartemenScreen(user: widget.user),
            VerifikasiScreen(user: widget.user),
            KegiatanScreen(user: widget.user),
          ],
        ),
      ),
    );
  }
}
