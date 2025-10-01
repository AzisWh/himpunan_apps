import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:himpunan_app/core/models/user_model.dart';
import 'package:himpunan_app/screen/main-tabs/auth_screen.dart';
import '../../../bloc/kegiatan/kegiatan_cubit.dart';
import '../../../core/models/kegiatan_model.dart';

class KegiatanScreen extends StatefulWidget {
  final UserModel? user;
  const KegiatanScreen({super.key, required this.user});

  @override
  State<KegiatanScreen> createState() => _KegiatanScreenState();
}

class _KegiatanScreenState extends State<KegiatanScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => KegiatanCubit()..loadDummyData(),
      child: Scaffold(
        body: BlocBuilder<KegiatanCubit, KegiatanState>(
          builder: (context, state) {
            if (state.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // HEADER ROW: Logout + Halo user
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
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // LIST KEGIATAN
                  ...state.kegiatans.map((kegiatan) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      elevation: 3,
                      child: ListTile(
                        title: Text(kegiatan.nama),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Tanggal: ${kegiatan.tanggal}"),
                            Text("Jenis: ${kegiatan.jenis}"),
                            Text("Reminder: ${kegiatan.reminderStatus}"),
                          ],
                        ),
                        trailing: kegiatan.reminderStatus == "pending"
                            ? ElevatedButton(
                                onPressed: () {
                                  context.read<KegiatanCubit>().updateReminder(
                                    kegiatan.id,
                                    "sudah diingatkan",
                                  );
                                },
                                child: const Text("Reminder"),
                              )
                            : const Icon(
                                Icons.check_circle,
                                color: Colors.green,
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
