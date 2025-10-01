import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:himpunan_app/core/models/user_model.dart';
import 'package:himpunan_app/core/models/departemen_model.dart';
import 'package:himpunan_app/bloc/departemen/departemen_cubit.dart';
import 'package:himpunan_app/screen/main-tabs/auth_screen.dart';

class DepartemenScreen extends StatefulWidget {
  final UserModel? user;
  const DepartemenScreen({super.key, this.user});

  @override
  State<DepartemenScreen> createState() => _DepartemenScreenState();
}

class _DepartemenScreenState extends State<DepartemenScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DepartemenCubit()..loadDepartemen(),
      child: Scaffold(
        // appBar: AppBar(title: const Text("")),
        body: BlocBuilder<DepartemenCubit, DepartemenState>(
          builder: (context, state) {
            if (state.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.departemens.isEmpty) {
              return const Center(child: Text("Belum ada departemen"));
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red, // warna merah
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AuthScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        icon: const Icon(Icons.logout),
                        label: const Text("Logout"),
                      ),
                      Text(
                        "Halo, ${widget.user?.username ?? 'Guest'}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // List Departemen
                  ...state.departemens.map((dept) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                DepartemenDetailScreen(departemen: dept),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 4,
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.account_tree,
                                size: 40,
                                color: Colors.blue,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  dept.nama,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class DepartemenDetailScreen extends StatefulWidget {
  final Departemen departemen;
  const DepartemenDetailScreen({super.key, required this.departemen});

  @override
  State<DepartemenDetailScreen> createState() => _DepartemenDetailScreenState();
}

class _DepartemenDetailScreenState extends State<DepartemenDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final next = widget.departemen.prokers
        .where((p) => p.status == "next")
        .toList();
    final ongoing = widget.departemen.prokers
        .where((p) => p.status == "ongoing")
        .toList();
    final done = widget.departemen.prokers
        .where((p) => p.status == "done")
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(widget.departemen.nama)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildProkerList(next, "Next Proker"),
            buildProkerList(ongoing, "On Going"),
            buildProkerList(done, "Selesai"),
          ],
        ),
      ),
    );
  }

  Widget buildProkerList(List<Proker> list, String title) {
    if (list.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...list.map(
          (proker) => Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    proker.nama,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Ketua: ${proker.ketua}"),
                  Text("Tanggal: ${proker.tanggal}"),
                  if (proker.status == "next" &&
                      proker.progress.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    const Text(
                      "Progress Persiapan:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    ...proker.progress.map(
                      (p) => Row(
                        children: [
                          const Icon(
                            Icons.check_circle_outline,
                            size: 18,
                            color: Colors.blue,
                          ),
                          const SizedBox(width: 6),
                          Expanded(child: Text(p)),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
