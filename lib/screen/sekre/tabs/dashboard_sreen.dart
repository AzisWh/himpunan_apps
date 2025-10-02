import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:himpunan_app/bloc/sekre/dashboard_cubit.dart';
import 'package:himpunan_app/core/models/user_model.dart';
import 'package:himpunan_app/screen/main-tabs/auth_screen.dart';

class DashboardSreen extends StatefulWidget {
  final UserModel? user;
  const DashboardSreen({super.key, required this.user});

  @override
  State<DashboardSreen> createState() => _DashboardSreenState();
}

class _DashboardSreenState extends State<DashboardSreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardCubit()..loadDummyData(),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<DashboardCubit, DashboardState>(
            builder: (context, state) {
              if (state.loading) {
                return const Center(child: CircularProgressIndicator());
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔹 Row Logout + Username
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
                    const SizedBox(height: 24),

                    // 🔹 Ringkasan
                    const Text(
                      "📊 Ringkasan Dashboard",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Card(
                      child: ListTile(
                        leading: const Icon(
                          Icons.monetization_on,
                          color: Colors.green,
                        ),
                        title: const Text("Saldo Kas Himpunan"),
                        subtitle: const Text("Rp 2.500.000"),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.group, color: Colors.blue),
                        title: const Text("Total Anggota"),
                        subtitle: const Text("54 orang"),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // 🔹 Reminder
                    const Text(
                      "⏰ Reminder Proker Terdekat",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Column(
                      children: state.reminders.map((reminder) {
                        return Card(
                          child: ListTile(
                            title: Text(reminder.namaProker),
                            subtitle: Text(
                              "Tanggal: ${reminder.tanggal.day}/${reminder.tanggal.month}/${reminder.tanggal.year}",
                            ),
                            trailing: reminder.status == "pending"
                                ? ElevatedButton(
                                    onPressed: () {
                                      context.read<DashboardCubit>().sendNotif(
                                        reminder.id,
                                      );
                                    },
                                    child: const Text("Kirim Notif"),
                                  )
                                : const Text(
                                    "Sudah Terkirim",
                                    style: TextStyle(color: Colors.green),
                                  ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
