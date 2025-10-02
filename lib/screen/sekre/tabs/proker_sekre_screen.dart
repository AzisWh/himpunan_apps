import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:himpunan_app/bloc/sekre/cal_cubit.dart';
import 'package:himpunan_app/core/models/sekre/cal_model.dart';
import 'package:himpunan_app/core/models/user_model.dart';
import 'package:table_calendar/table_calendar.dart';

class ProkerSekreScreen extends StatefulWidget {
  final UserModel? user;
  const ProkerSekreScreen({super.key, required this.user});

  @override
  State<ProkerSekreScreen> createState() => _ProkerSekreScreenState();
}

class _ProkerSekreScreenState extends State<ProkerSekreScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CalendarSekreCubit()..loadDummyData(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Kalender Proker Himpunan")),
        body: BlocBuilder<CalendarSekreCubit, CalendarSekreState>(
          builder: (context, state) {
            if (state.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                TableCalendar<CalendarSekreProker>(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  eventLoader: (day) {
                    return context.read<CalendarSekreCubit>().getEventsForDay(
                      day,
                    );
                  },
                  calendarStyle: const CalendarStyle(
                    markerDecoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView(
                    children: context
                        .read<CalendarSekreCubit>()
                        .getEventsForDay(_selectedDay ?? DateTime.now())
                        .map(
                          (e) => ListTile(
                            title: Text(e.nama),
                            subtitle: Text(
                              "${e.tanggal.day}/${e.tanggal.month}/${e.tanggal.year}",
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.orange,
                                  ),
                                  onPressed: () {
                                    _showEditDialog(context, e);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    context
                                        .read<CalendarSekreCubit>()
                                        .deleteProker(e.id);
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showAddDialog(context);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final nameController = TextEditingController();
    DateTime selectedDate = _selectedDay ?? DateTime.now();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Tambah Proker"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: "Nama Proker"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                if (picked != null) {
                  selectedDate = picked;
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
              if (nameController.text.isNotEmpty) {
                context.read<CalendarSekreCubit>().addProker(
                  CalendarSekreProker(
                    id: DateTime.now().toIso8601String(),
                    nama: nameController.text,
                    tanggal: selectedDate,
                  ),
                );
                Navigator.pop(context);
              }
            },
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, CalendarSekreProker proker) {
    final nameController = TextEditingController(text: proker.nama);
    DateTime selectedDate = proker.tanggal;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Proker"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: "Nama Proker"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                if (picked != null) {
                  selectedDate = picked;
                }
              },
              child: const Text("Ubah Tanggal"),
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
              if (nameController.text.isNotEmpty) {
                context.read<CalendarSekreCubit>().editProker(
                  proker.id,
                  nameController.text,
                  selectedDate ?? proker.tanggal,
                );
                Navigator.pop(context);
              }
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }
}
