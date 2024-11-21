import 'package:absen_presen/data/api/schedule_api.dart';
import 'package:absen_presen/logic/admin/schedule_logic.dart';
import 'package:absen_presen/logic/admin/users_list_logic.dart';
import 'package:absen_presen/logic/auth_logic.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/model/schedule/schedule_model.dart';

class AdminSchedule extends ConsumerWidget {
  const AdminSchedule({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleData = ref.watch(scheduleLogicProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddSchedule(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ref.read(scheduleLogicProvider.notifier).fetchSchedules();
            },
          ),
        ],
      ),
      body: scheduleData.when(
        data: (data) {
          return Card(
            child: InteractiveViewer(
              constrained: false,
              maxScale: 1,
              child: DataTable(
                rows: data
                    .map(
                      (e) => DataRow(
                        cells: [
                          DataCell(Text((e.id.toString()))),
                          DataCell(Text(e.user?.name ?? '')),
                          DataCell(Text(e.date.toString())),
                          DataCell(Text(e.startTime)),
                          DataCell(Text(e.endTime)),
                          DataCell(FilledButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => EditSchedule(
                                    schedule: e,
                                  ),
                                ),
                              );
                            },
                            child: Text('Edit'),
                          )),
                          DataCell(FilledButton(
                            onPressed: () async {
                              try {
                                final id = e.id;
                                if (id != null) {
                                  await deleteSchedule(
                                    ref.read(authLogicProvider).value?.token ??
                                        '',
                                    id,
                                  );
                                }
                                ref
                                    .read(scheduleLogicProvider.notifier)
                                    .fetchSchedules();
                              } on DioException catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(e.message ?? ''),
                                  ),
                                );
                              }
                            },
                            child: Text('Delete'),
                          )),
                        ],
                      ),
                    )
                    .toList(),
                columns: [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Nama')),
                  DataColumn(label: Text('Tanggal')),
                  DataColumn(label: Text('Jadwal masuk')),
                  DataColumn(label: Text('Jadwal keluar')),
                  DataColumn(label: Text('Edit')),
                  DataColumn(label: Text('Delete')),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
      ),
    );
  }
}

class AddSchedule extends HookConsumerWidget {
  const AddSchedule({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = useState(0);
    final dateCtl = useState(DateTime.now());
    final scheduleInCtl = useState(TimeOfDay.now());
    final scheduleOutCtl = useState(TimeOfDay.now());

    final users = ref.watch(usersListLogicProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah jadwal'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            // dropdown user
            if (users.hasValue)
              DropdownButton<int>(
                value: userId.value,
                items: users.value?.map((e) {
                  return DropdownMenuItem<int>(
                    value: e.id,
                    child: Text(e.name),
                  );
                }).toList(),
                onChanged: (value) {
                  userId.value = value ?? 0;
                },
              ),

            // Date
            TextField(
              readOnly: true,
              controller: TextEditingController(
                  text:
                      '${dateCtl.value.day}/${dateCtl.value.month}/${dateCtl.value.year}'),
              decoration: InputDecoration(labelText: 'Tanggal'),
              onTap: () async {
                final date = await showDatePicker(
                    context: context,
                    initialDate: dateCtl.value,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100));
                if (date != null) {
                  dateCtl.value = date;
                }
              },
            ),

            // Start time
            TextField(
              readOnly: true,
              controller: TextEditingController(
                  text:
                      '${scheduleInCtl.value.hour}:${scheduleInCtl.value.minute}'),
              decoration: InputDecoration(labelText: 'Jadwal masuk'),
              onTap: () async {
                final time = await showTimePicker(
                    context: context,
                    initialTime: scheduleInCtl.value,
                    initialEntryMode: TimePickerEntryMode.dial);
                if (time != null) {
                  scheduleInCtl.value = time;
                }
              },
            ),

            // End time
            TextField(
              readOnly: true,
              controller: TextEditingController(
                  text:
                      '${scheduleOutCtl.value.hour}:${scheduleOutCtl.value.minute}'),
              decoration: InputDecoration(labelText: 'Jadwal keluar'),
              onTap: () async {
                final time = await showTimePicker(
                    context: context,
                    initialTime: scheduleOutCtl.value,
                    initialEntryMode: TimePickerEntryMode.dial);
                if (time != null) {
                  scheduleOutCtl.value = time;
                }
              },
            ),

            // Submit
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () async {
                try {
                  final entry = scheduleInCtl.value;
                  final out = scheduleOutCtl.value;
                  final response = await storeSchedule(
                    ref.read(authLogicProvider).value!.token,
                    ScheduleModel(
                      userId: userId.value,
                      date: dateCtl.value,
                      startTime: '${entry.hour}:${entry.minute}:00',
                      endTime: '${out.hour}:${out.minute}:00',
                    ),
                  );

                  if (response.statusCode == 200 && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Jadwal berhasil ditambahkan!'),
                    ));
                    ref.read(scheduleLogicProvider.notifier).fetchSchedules();
                    Navigator.pop(context);
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(e.toString()),
                  ));
                }
              },
              child: Text('Submit'),
            )
          ],
        ),
      ),
    );
  }
}

class EditSchedule extends HookConsumerWidget {
  const EditSchedule({required this.schedule, super.key});

  final ScheduleModel schedule;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateCtl = useState(schedule.date);
    final scheduleInCtl = useState(
      TimeOfDay(
        hour: int.parse(schedule.startTime.split(':')[0]),
        minute: int.parse(schedule.startTime.split(':')[1]),
      ),
    );
    final scheduleOutCtl = useState(
      TimeOfDay(
        hour: int.parse(schedule.endTime.split(':')[0]),
        minute: int.parse(schedule.endTime.split(':')[1]),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah jadwal'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Text('ID: ${schedule.user?.id} : ${schedule.user?.name}'),

            // Date
            TextField(
              readOnly: true,
              controller: TextEditingController(
                  text:
                      '${dateCtl.value.day}/${dateCtl.value.month}/${dateCtl.value.year}'),
              decoration: InputDecoration(labelText: 'Tanggal'),
              onTap: () async {
                final date = await showDatePicker(
                    context: context,
                    initialDate: dateCtl.value,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100));
                if (date != null) {
                  dateCtl.value = date;
                }
              },
            ),

            // Start time
            TextField(
              readOnly: true,
              controller: TextEditingController(
                  text:
                      '${scheduleInCtl.value.hour.toString().padLeft(2, '0')}:${scheduleInCtl.value.minute.toString().padLeft(2, '0')}'),
              decoration: InputDecoration(labelText: 'Jadwal masuk'),
              onTap: () async {
                final time = await showTimePicker(
                    context: context,
                    initialTime: scheduleInCtl.value,
                    initialEntryMode: TimePickerEntryMode.dial);
                if (time != null) {
                  scheduleInCtl.value = time;
                }
              },
            ),

            // End time
            TextField(
              readOnly: true,
              controller: TextEditingController(
                  text:
                      '${scheduleOutCtl.value.hour.toString().padLeft(2, '0')}:${scheduleOutCtl.value.minute.toString().padLeft(2, '0')}'),
              decoration: InputDecoration(labelText: 'Jadwal keluar'),
              onTap: () async {
                final time = await showTimePicker(
                    context: context,
                    initialTime: scheduleOutCtl.value,
                    initialEntryMode: TimePickerEntryMode.dial);
                if (time != null) {
                  scheduleOutCtl.value = time;
                }
              },
            ),

            // Submit
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () async {
                try {
                  final entry = scheduleInCtl.value;
                  final out = scheduleOutCtl.value;
                  final response = await updateSchedule(
                    ref.read(authLogicProvider).value!.token,
                    ScheduleModel(
                      id: schedule.id,
                      userId: schedule.userId,
                      date: dateCtl.value,
                      startTime:
                          '${entry.hour.toString().padLeft(2, '0')}:${entry.minute.toString().padLeft(2, '0')}:00',
                      endTime:
                          '${out.hour.toString().padLeft(2, '0')}:${out.minute.toString().padLeft(2, '0')}:00',
                    ),
                  );

                  if (response.statusCode == 200 && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Jadwal berhasil ditambahkan!'),
                    ));
                    ref.read(scheduleLogicProvider.notifier).fetchSchedules();
                    Navigator.pop(context);
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(e.toString()),
                  ));
                }
              },
              child: Text('Submit'),
            )
          ],
        ),
      ),
    );
  }
}
