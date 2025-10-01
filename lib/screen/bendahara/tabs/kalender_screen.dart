import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:himpunan_app/core/models/user_model.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:himpunan_app/core/models/bendahara/calendar_model.dart';
import 'package:himpunan_app/bloc/bendahara/calendar_cubit.dart';

class KalenderScreen extends StatefulWidget {
  final UserModel? user;
  const KalenderScreen({super.key, required this.user});

  @override
  State<KalenderScreen> createState() => _KalenderScreenState();
}

class _KalenderScreenState extends State<KalenderScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CalendarCubit()..loadDummyData(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Kalender Proker")),
        body: BlocBuilder<CalendarCubit, CalendarState>(
          builder: (context, state) {
            if (state.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                TableCalendar<CalendarProker>(
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
                    return context.read<CalendarCubit>().getEventsForDay(day);
                  },
                  calendarStyle: const CalendarStyle(
                    markerDecoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView(
                    children: context
                        .read<CalendarCubit>()
                        .getEventsForDay(_selectedDay ?? DateTime.now())
                        .map(
                          (e) => ListTile(
                            title: Text(e.nama),
                            subtitle: Text(
                              "${e.tanggal.day}/${e.tanggal.month}/${e.tanggal.year}",
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

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Tambah Proker"),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(hintText: "Nama Proker"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                context.read<CalendarCubit>().addProker(
                  CalendarProker(
                    id: DateTime.now().toIso8601String(),
                    nama: nameController.text,
                    tanggal: _selectedDay ?? DateTime.now(),
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
}
