import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:himpunan_app/bloc/verifikasi/verifikasi_cubit.dart';
import 'package:himpunan_app/core/models/user_model.dart';
import 'package:himpunan_app/core/models/verikasi_model.dart';
import 'package:himpunan_app/screen/main-tabs/auth_screen.dart';

class VerifikasiScreen extends StatefulWidget {
  final UserModel? user;
  const VerifikasiScreen({super.key, required this.user});

  @override
  State<VerifikasiScreen> createState() => _VerifikasiScreenState();
}

class _VerifikasiScreenState extends State<VerifikasiScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VerifikasiCubit()..loadDummyData(),
      child: Scaffold(
        body: BlocBuilder<VerifikasiCubit, VerifikasiState>(
          builder: (context, state) {
            if (state.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.items.isEmpty) {
              return const Center(child: Text("Belum ada data verifikasi"));
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Row logout + halo user
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
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

                  // List Verifikasi dibagi per tipe
                  buildSegment(context, state, "surat"),
                  buildSegment(context, state, "proker"),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildSegment(
    BuildContext context,
    VerifikasiState state,
    String tipe,
  ) {
    final data = state.items.where((e) => e.tipe == tipe).toList();
    if (data.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tipe == "surat" ? "Penyetujuan Surat" : "Penyetujuan Proker",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ...data.map((item) {
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (ctx) {
                  String selected = item.status;
                  return AlertDialog(
                    title: Text("Ubah Status - ${item.nama}"),
                    content: DropdownButtonFormField<String>(
                      value: selected,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: "pending",
                          child: Text("Pending"),
                        ),
                        DropdownMenuItem(
                          value: "disetujui",
                          child: Text("Disetujui"),
                        ),
                        DropdownMenuItem(
                          value: "ditolak",
                          child: Text("Ditolak"),
                        ),
                      ],
                      onChanged: (val) {
                        selected = val ?? "pending";
                      },
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text("Batal"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.read<VerifikasiCubit>().updateStatus(
                            item.id,
                            selected,
                          );
                          Navigator.pop(ctx);
                        },
                        child: const Text("Simpan"),
                      ),
                    ],
                  );
                },
              );
            },
            child: Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: Icon(
                  tipe == "surat" ? Icons.mail : Icons.work,
                  color: Colors.blue,
                ),
                title: Text(item.nama),
                subtitle: Text("Status: ${item.status}"),
                trailing: const Icon(Icons.edit, color: Colors.grey),
              ),
            ),
          );
        }),
        const SizedBox(height: 20),
      ],
    );
  }
}
