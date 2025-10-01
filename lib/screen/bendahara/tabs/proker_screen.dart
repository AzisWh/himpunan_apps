import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:himpunan_app/bloc/bendahara/proker_cubit.dart';
import 'package:himpunan_app/core/models/bendahara/proker_bend_model.dart';
import 'package:himpunan_app/core/models/user_model.dart';

class ProkerScreen extends StatefulWidget {
  final UserModel? user;
  const ProkerScreen({super.key, required this.user});

  @override
  State<ProkerScreen> createState() => _ProkerScreenState();
}

class _ProkerScreenState extends State<ProkerScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProkerCubit()..loadDummyData(),
      child: Scaffold(
        // appBar: AppBar(title: const Text("Proker")),
        body: BlocBuilder<ProkerCubit, ProkerBendaharaState>(
          builder: (context, state) {
            if (state.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // === Reminder Proker Terdekat ===
                  const Text(
                    "Reminder Proker Terdekat",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ...state.prokerList.map((proker) {
                    return Card(
                      child: ListTile(
                        title: Text(proker.nama),
                        subtitle: Text(
                          "Tanggal: ${proker.tanggal.toLocal().toString().split(" ")[0]}",
                        ),
                        trailing: ElevatedButton(
                          onPressed: proker.reminderStatus == "pending"
                              ? () {
                                  context.read<ProkerCubit>().updateReminder(
                                    proker.id,
                                  );
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: proker.reminderStatus == "pending"
                                ? Colors.orange
                                : Colors.grey,
                          ),
                          child: Text(
                            proker.reminderStatus == "pending"
                                ? "Kirim"
                                : "Terkirim",
                          ),
                        ),
                      ),
                    );
                  }),

                  const SizedBox(height: 20),

                  // === Daftar RAB Proker ===
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "RAB Proker",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => _showAddModal(context),
                        child: const Text("Tambah RAB"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ...state.prokerList.map((proker) {
                    return Card(
                      child: ListTile(
                        title: Text(proker.nama),
                        subtitle: Text(
                          "RAB: Rp${proker.rab.toStringAsFixed(0)}",
                        ),
                      ),
                    );
                  }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showAddModal(BuildContext context) {
    final namaCtrl = TextEditingController();
    final rabCtrl = TextEditingController();
    final tglCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Tambah Proker"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: namaCtrl,
                  decoration: const InputDecoration(labelText: "Nama Proker"),
                ),
                TextField(
                  controller: rabCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "RAB"),
                ),
                TextField(
                  controller: tglCtrl,
                  decoration: const InputDecoration(
                    labelText: "Tanggal (YYYY-MM-DD)",
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                final proker = ProkerBend(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  nama: namaCtrl.text,
                  rab: double.tryParse(rabCtrl.text) ?? 0,
                  tanggal: DateTime.tryParse(tglCtrl.text) ?? DateTime.now(),
                );
                context.read<ProkerCubit>().addProker(proker);
                Navigator.pop(context);
              },
              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );
  }
}
