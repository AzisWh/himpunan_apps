import 'package:flutter/material.dart';
import 'package:himpunan_app/bloc/internal/internal_cubit.dart';
import 'package:himpunan_app/core/models/internal/internal_model.dart';
import 'package:himpunan_app/core/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:himpunan_app/screen/main-tabs/auth_screen.dart';

class InternalProkerScreen extends StatefulWidget {
  final UserModel? user;
  const InternalProkerScreen({super.key, required this.user});

  @override
  State<InternalProkerScreen> createState() => _InternalProkerScreenState();
}

class _InternalProkerScreenState extends State<InternalProkerScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InternalProkerCubit()..loadDummyData(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Departemen Internal"),
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
                  elevation: 2, // kasih shadow
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
        body: BlocBuilder<InternalProkerCubit, InternalProkerState>(
          builder: (context, state) {
            if (state.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // List Card Proker
                  ...state.prokers.map((proker) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(proker.nama),
                        subtitle: Text(
                          "${proker.deskripsi}\nTanggal: ${proker.tanggal.toLocal().toString().split(" ")[0]}",
                        ),
                        isThreeLine: true,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                _showProkerModal(context, proker: proker);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                context
                                    .read<InternalProkerCubit>()
                                    .deleteProker(proker.id);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),

                  const SizedBox(height: 20),

                  // Kalender Proker (sederhana, list tanggal terdekat)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Kalender Proker",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...state.prokers.map((proker) {
                    return ListTile(
                      leading: const Icon(Icons.calendar_today),
                      title: Text(proker.nama),
                      subtitle: Text(
                        proker.tanggal.toLocal().toString().split(" ")[0],
                      ),
                    );
                  }).toList(),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showProkerModal(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _showProkerModal(BuildContext context, {InternalProker? proker}) {
    final TextEditingController namaCtrl = TextEditingController(
      text: proker?.nama ?? "",
    );
    final TextEditingController deskCtrl = TextEditingController(
      text: proker?.deskripsi ?? "",
    );
    DateTime selectedDate = proker?.tanggal ?? DateTime.now();
    // final cubit = context.read<InternalProkerCubit>();

    showDialog(
      context: context,
      builder: (dialogCtx) {
        return AlertDialog(
          title: Text(proker == null ? "Tambah Proker" : "Edit Proker"),
          content: StatefulBuilder(
            builder: (context, setState) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: namaCtrl,
                      decoration: const InputDecoration(
                        labelText: "Nama Proker",
                      ),
                    ),
                    TextField(
                      controller: deskCtrl,
                      decoration: const InputDecoration(labelText: "Deskripsi"),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Tanggal: ${selectedDate?.toLocal().toString().split(" ")[0] ?? '-'}",
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.calendar_month),
                          onPressed: () async {
                            DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2030),
                            );
                            if (picked != null) {
                              setState(() {
                                selectedDate = picked;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogCtx).pop(),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                if (namaCtrl.text.isNotEmpty && deskCtrl.text.isNotEmpty) {
                  if (proker == null) {
                    final newProker = InternalProker(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      nama: namaCtrl.text,
                      deskripsi: deskCtrl.text,
                      tanggal: selectedDate,
                    );
                    context.read<InternalProkerCubit>().addProker(newProker);
                  } else {
                    final updated = InternalProker(
                      id: proker.id,
                      nama: namaCtrl.text,
                      deskripsi: deskCtrl.text,
                      tanggal: selectedDate,
                    );
                    context.read<InternalProkerCubit>().updateProker(updated);
                  }
                }
                Navigator.of(dialogCtx).pop();
              },
              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );
  }
}
