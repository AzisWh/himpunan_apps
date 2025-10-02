import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:himpunan_app/bloc/sekre/menej_cubit.dart';
import 'package:himpunan_app/core/models/sekre/menej_model.dart';
import 'package:himpunan_app/core/models/user_model.dart';
import 'package:himpunan_app/screen/main-tabs/auth_screen.dart';

class ManajemenScreen extends StatefulWidget {
  final UserModel? user;
  const ManajemenScreen({super.key, required this.user});

  @override
  State<ManajemenScreen> createState() => _ManajemenScreenState();
}

class _ManajemenScreenState extends State<ManajemenScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserCubit()..loadDummyData()),
        BlocProvider(create: (_) => FasilitasCubit()..loadDummyData()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Dashboard Manajemen"),
          actions: const [
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Center(child: Text("Halo, User 👋")),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ---------------- User Section ----------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Manajemen User",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () => _showUserModal(context),
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  if (state.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Column(
                    children: state.users.map((u) {
                      return ListTile(
                        title: Text(u.nama),
                        subtitle: Text(u.role),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => _showUserModal(context, user: u),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.redAccent,
                              ),
                              onPressed: () {
                                context.read<UserCubit>().deleteUser(u.id);
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                },
              ),

              const Divider(height: 40),

              /// ---------------- Fasilitas Section ----------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Peminjaman Fasilitas",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () => _showFasilitasModal(context),
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              BlocBuilder<FasilitasCubit, FasilitasState>(
                builder: (context, state) {
                  if (state.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Column(
                    children: state.list.map((f) {
                      return Card(
                        child: ListTile(
                          title: Text(f.nama),
                          subtitle: Text(
                            "Peminjam: ${f.peminjam}\nTanggal: ${f.tanggal.toLocal().toString().split(' ')[0]}\nStatus: ${f.status}",
                          ),
                          isThreeLine: true,
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (f.status == "Pending")
                                IconButton(
                                  icon: const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  ),
                                  onPressed: () {
                                    context.read<FasilitasCubit>().updateStatus(
                                      f.id,
                                      "Disetujui",
                                    );
                                  },
                                ),
                              if (f.status == "Pending")
                                IconButton(
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    context.read<FasilitasCubit>().updateStatus(
                                      f.id,
                                      "Ditolak",
                                    );
                                  },
                                ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ),
                                onPressed: () {
                                  context
                                      .read<FasilitasCubit>()
                                      .deleteFasilitas(f.id);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ---------------- Modal Tambah/Edit User ----------------
  void _showUserModal(BuildContext context, {HimpunanUser? user}) {
    final nameController = TextEditingController(text: user?.nama ?? "");
    final roleController = TextEditingController(text: user?.role ?? "");

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(user == null ? "Tambah User" : "Edit User"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Nama"),
            ),
            TextField(
              controller: roleController,
              decoration: const InputDecoration(labelText: "Role"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  roleController.text.isNotEmpty) {
                if (user == null) {
                  context.read<UserCubit>().addUser(
                    HimpunanUser(
                      id: DateTime.now().toString(),
                      nama: nameController.text,
                      role: roleController.text,
                    ),
                  );
                } else {
                  context.read<UserCubit>().editUser(
                    user.id,
                    nameController.text,
                    roleController.text,
                  );
                }
                Navigator.pop(context);
              }
            },
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }

  /// ---------------- Modal Tambah Fasilitas ----------------
  void _showFasilitasModal(BuildContext context) {
    final nameController = TextEditingController();
    final peminjamController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Ajukan Fasilitas"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Nama Fasilitas"),
            ),
            TextField(
              controller: peminjamController,
              decoration: const InputDecoration(labelText: "Peminjam"),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2023),
                  lastDate: DateTime(2030),
                );
                if (picked != null) {
                  setState(() {
                    selectedDate = picked;
                  });
                }
              },
              child: const Text("Pilih Tanggal"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  peminjamController.text.isNotEmpty) {
                context.read<FasilitasCubit>().addFasilitas(
                  Fasilitas(
                    id: DateTime.now().toString(),
                    nama: nameController.text,
                    peminjam: peminjamController.text,
                    tanggal: selectedDate,
                  ),
                );
                Navigator.pop(context);
              }
            },
            child: const Text("Ajukan"),
          ),
        ],
      ),
    );
  }
}
