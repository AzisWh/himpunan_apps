import 'package:flutter/material.dart';
import 'package:himpunan_app/bloc/internal/internal_cubit.dart';
import 'package:himpunan_app/core/models/internal/internal_model.dart';
import 'package:himpunan_app/core/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:himpunan_app/screen/main-tabs/auth_screen.dart';

class InternalPengaduan extends StatefulWidget {
  final UserModel? user;
  const InternalPengaduan({super.key, required this.user});

  @override
  State<InternalPengaduan> createState() => _InternalPengaduanState();
}

class _InternalPengaduanState extends State<InternalPengaduan> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PengaduanCubit()..loadDummyData(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Pengaduan Internal"),
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
        body: BlocBuilder<PengaduanCubit, PengaduanState>(
          builder: (context, state) {
            if (state.pengaduanList.isEmpty) {
              return const Center(child: Text("Belum ada pengaduan"));
            }
            return ListView.builder(
              itemCount: state.pengaduanList.length,
              itemBuilder: (context, index) {
                final item = state.pengaduanList[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.nama,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(item.deskripsi),
                        const SizedBox(height: 6),
                        Text(
                          "Tanggal: ${item.tanggal.day}/${item.tanggal.month}/${item.tanggal.year}",
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _statusButton(
                              context,
                              index,
                              PengaduanStatus.pending,
                              item,
                            ),
                            const SizedBox(width: 6),
                            _statusButton(
                              context,
                              index,
                              PengaduanStatus.diterima,
                              item,
                            ),
                            const SizedBox(width: 6),
                            _statusButton(
                              context,
                              index,
                              PengaduanStatus.ditolak,
                              item,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _statusButton(
    BuildContext context,
    int index,
    PengaduanStatus status,
    Pengaduan item,
  ) {
    final isSelected = item.status == status;
    String text = "";
    Color color = Colors.grey;

    switch (status) {
      case PengaduanStatus.pending:
        text = "Pending";
        color = Colors.orange;
        break;
      case PengaduanStatus.diterima:
        text = "Diterima";
        color = Colors.green;
        break;
      case PengaduanStatus.ditolak:
        text = "Ditolak";
        color = Colors.red;
        break;
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? color : Colors.grey.shade300,
        foregroundColor: isSelected ? Colors.white : Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      onPressed: () {
        context.read<PengaduanCubit>().updateStatus(index, status);
      },
      child: Text(text),
    );
  }
}
