import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:himpunan_app/bloc/bendahara/pengeluaran_cubit.dart';
import 'package:himpunan_app/core/models/bendahara/kas_model.dart';
import 'package:himpunan_app/core/models/bendahara/pengeluaran_model.dart';
import 'package:himpunan_app/core/models/user_model.dart';
import 'package:himpunan_app/screen/main-tabs/auth_screen.dart';

class KeuanganScreen extends StatefulWidget {
  final UserModel? user;
  const KeuanganScreen({super.key, required this.user});

  @override
  State<KeuanganScreen> createState() => _KeuanganScreenState();
}

class _KeuanganScreenState extends State<KeuanganScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => KeuanganCubit()..loadDummyData(),
      child: Scaffold(
        body: BlocBuilder<KeuanganCubit, KeuanganState>(
          builder: (context, state) {
            if (state.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ROW LOGOUT + HALO USER
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
                      Expanded(
                        child: Text(
                          "Halo, ${widget.user?.username ?? 'Guest'}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis, // biar ga overflow
                          maxLines: 1, // satu baris aja
                          textAlign: TextAlign.right, // rapat kanan
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // LIST PENGELUARAN
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Pengeluaran",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          _showTambahPengeluaranDialog(context);
                        },
                      ),
                    ],
                  ),
                  ...state.pengeluarans.map((p) {
                    return Card(
                      child: ListTile(
                        title: Text(p.nama),
                        subtitle: Text("Tanggal: ${p.tanggal}"),
                        trailing: Text("Rp ${p.jumlah}"),
                      ),
                    );
                  }),

                  const SizedBox(height: 20),

                  // TABEL UANG KAS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Uang Kas",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          _showTambahKasDialog(context);
                        },
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text("Nama")),
                        DataColumn(label: Text("Tanggal")),
                        DataColumn(label: Text("Jumlah")),
                      ],
                      rows: state.kasList.map((k) {
                        return DataRow(
                          cells: [
                            DataCell(Text(k.namaPembayar)),
                            DataCell(Text(k.tanggal)),
                            DataCell(Text("Rp ${k.jumlah}")),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // 🔽 dialog tambah pengeluaran
  void _showTambahPengeluaranDialog(BuildContext context) {
    final namaCtrl = TextEditingController();
    final tanggalCtrl = TextEditingController();
    final jumlahCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        // 🔥 bawa cubit dari parent context ke dalam dialog
        return BlocProvider.value(
          value: context.read<KeuanganCubit>(),
          child: AlertDialog(
            title: const Text("Tambah Pengeluaran"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: namaCtrl,
                  decoration: const InputDecoration(
                    labelText: "Nama Pengeluaran",
                  ),
                ),
                TextField(
                  controller: tanggalCtrl,
                  decoration: const InputDecoration(
                    labelText: "Tanggal (yyyy-mm-dd)",
                  ),
                ),
                TextField(
                  controller: jumlahCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Jumlah"),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text("Batal"),
              ),
              ElevatedButton(
                onPressed: () {
                  final pengeluaran = Pengeluaran(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    nama: namaCtrl.text,
                    tanggal: tanggalCtrl.text,
                    jumlah: int.tryParse(jumlahCtrl.text) ?? 0,
                  );
                  dialogContext.read<KeuanganCubit>().tambahPengeluaran(
                    pengeluaran,
                  );
                  Navigator.pop(dialogContext);
                },
                child: const Text("Simpan"),
              ),
            ],
          ),
        );
      },
    );
  }

  // 🔽 dialog tambah kas
  void _showTambahKasDialog(BuildContext context) {
    final namaCtrl = TextEditingController();
    final tanggalCtrl = TextEditingController();
    final jumlahCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return BlocProvider.value(
          value: context.read<KeuanganCubit>(),
          child: AlertDialog(
            title: const Text("Tambah Kas"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: namaCtrl,
                  decoration: const InputDecoration(labelText: "Nama Pembayar"),
                ),
                TextField(
                  controller: tanggalCtrl,
                  decoration: const InputDecoration(
                    labelText: "Tanggal (yyyy-mm-dd)",
                  ),
                ),
                TextField(
                  controller: jumlahCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Jumlah"),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text("Batal"),
              ),
              ElevatedButton(
                onPressed: () {
                  final kas = Kas(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    namaPembayar: namaCtrl.text,
                    tanggal: tanggalCtrl.text,
                    jumlah: int.tryParse(jumlahCtrl.text) ?? 0,
                  );
                  dialogContext.read<KeuanganCubit>().tambahKas(kas);
                  Navigator.pop(dialogContext);
                },
                child: const Text("Simpan"),
              ),
            ],
          ),
        );
      },
    );
  }
}
