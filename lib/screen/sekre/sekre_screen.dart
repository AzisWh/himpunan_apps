import 'package:flutter/material.dart';
import 'package:himpunan_app/core/constant/app_colors.dart';
import 'package:himpunan_app/core/models/user_model.dart';
import 'package:himpunan_app/screen/sekre/tabs/dashboard_sreen.dart';
import 'package:himpunan_app/screen/sekre/tabs/manajemen_screen.dart';
import 'package:himpunan_app/screen/sekre/tabs/proker_sekre_screen.dart';
import 'package:himpunan_app/screen/sekre/tabs/rapat_screen.dart';

class SekreScreen extends StatefulWidget {
  final UserModel? user;
  const SekreScreen({super.key, required this.user});

  @override
  State<SekreScreen> createState() => _SekreScreenState();
}

class _SekreScreenState extends State<SekreScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
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
              Tab(text: "Dashboard", icon: Icon(Icons.library_books)),
              Tab(text: "Proker", icon: Icon(Icons.work)),
              Tab(text: "Menej", icon: Icon(Icons.list)),
              Tab(text: "Rapat", icon: Icon(Icons.meeting_room)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            DashboardSreen(user: widget.user),
            ProkerSekreScreen(user: widget.user),
            ManajemenScreen(user: widget.user),
            RapatScreen(user: widget.user),
          ],
        ),
      ),
    );
  }
}
