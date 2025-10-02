import 'package:flutter/material.dart';
import 'package:himpunan_app/bloc/internal/internal_cubit.dart';
import 'package:himpunan_app/core/constant/app_colors.dart';
import 'package:himpunan_app/core/models/internal/internal_model.dart';
import 'package:himpunan_app/core/models/user_model.dart';
import 'package:himpunan_app/screen/main-tabs/auth_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InternalAbsensiScreen extends StatefulWidget {
  final UserModel? user;
  const InternalAbsensiScreen({super.key, required this.user});

  @override
  State<InternalAbsensiScreen> createState() => _InternalAbsensiScreenState();
}

class _InternalAbsensiScreenState extends State<InternalAbsensiScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InternalAbsenCubit()..loadDummyData(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Absensi Rapat Hari Ini"),
          backgroundColor: Colors.tealAccent.shade700,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 8.0,
              ),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const AuthScreen()),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.logout, size: 18),
                label: const Text("Logout", style: TextStyle(fontSize: 14)),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                "Rapat Internal - 02 Oktober 2025",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<InternalAbsenCubit, List<AbsensiModel>>(
                  builder: (context, state) {
                    if (state.isEmpty) {
                      return const Center(child: Text("Tidak ada anggota"));
                    }
                    return ListView.builder(
                      itemCount: state.length,
                      itemBuilder: (context, index) {
                        final anggota = state[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            leading: const Icon(Icons.person),
                            title: Text(anggota.nama),
                            trailing: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: anggota.hadir
                                    ? AppColors.hijauTosca
                                    : Colors.red,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () {
                                context.read<InternalAbsenCubit>().toggleHadir(
                                  index,
                                );
                              },
                              child: Text(
                                anggota.hadir ? "Hadir" : "Belum Hadir",
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
